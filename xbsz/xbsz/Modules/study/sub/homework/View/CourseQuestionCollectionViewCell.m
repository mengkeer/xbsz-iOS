//
//  CourseQuestionCollectionViewCell.m
//  xbsz
//
//  Created by lotus on 2017/4/25.
//  Copyright © 2017年 lotus. All rights reserved.
//

#import "CourseQuestionCollectionViewCell.h"
#import "CXBaseTableView.h"
#import "CourseQuestion.h"
#import "CourseQuestionTableViewCell.h"
#import "QuestionTitleLabel.h"
#import "FMDBUtil.h"

static NSString *cellID = @"QuestionTableViewCellID";

static NSInteger TitlePaddingLeft = 8;
static NSInteger TitlePaddingRight = 5;

@interface CourseQuestionCollectionViewCell () <CXBaseTableViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) CXBaseTableView *tableView;

@property (nonatomic, strong) QuestionTitleLabel *titleLabel;

@property (nonatomic, strong) UIView *titleLeftView;

@property (nonatomic, strong) CourseQuestion *question;

@property (nonatomic, strong) NSArray *options;     //各个选项内容

@property (nonatomic, assign) BOOL isSingle;        //是否是单选


@end

@implementation CourseQuestionCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self initCollectionCell];
    }
    return self;
}

- (void)initCollectionCell{
    
    [self.contentView addSubview:self.scrollView];
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.top.mas_equalTo(self.contentView);
    }];
    
    [self.contentView layoutIfNeeded];
    
    [_scrollView addSubview:self.titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).mas_offset(15);
        make.right.mas_equalTo(self.contentView.mas_right).mas_offset(-15);
        make.top.mas_equalTo(_scrollView.mas_top).mas_offset(15);
        make.height.mas_equalTo(25);
    }];
    
    _titleLeftView = [[UIView alloc] init];
    _titleLeftView.backgroundColor = CXHexColor(0x08b292);
    [_scrollView addSubview:_titleLeftView];
    [_titleLeftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.mas_equalTo(_titleLabel);
        make.width.mas_equalTo(2);
    }];
    
    
    [_scrollView addSubview:self.tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_titleLabel.mas_bottom).mas_offset(15);
        make.left.right.bottom.mas_equalTo(self.contentView);
    }];
    
}

#pragma mark - getter/setter

- (UIScrollView *)scrollView{
    if(!_scrollView){
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.backgroundColor = [CXUserDefaults instance].bgColor;
        _scrollView.showsVerticalScrollIndicator = YES;
        _scrollView.alwaysBounceVertical = YES;
    }
    return _scrollView;
}

- (QuestionTitleLabel *)titleLabel{
    if(!_titleLabel){
        _titleLabel = [[QuestionTitleLabel alloc] initWithInsets:UIEdgeInsetsMake(TitlePaddingRight, TitlePaddingLeft, TitlePaddingRight, TitlePaddingRight)];
        _titleLabel.font = CXSystemFont([CXUserDefaults instance].questionFontSize);
        _titleLabel.textColor = CXTextGrayColor;
        _titleLabel.numberOfLines = 0;
        _titleLabel.backgroundColor = [CXUserDefaults instance].bgColor;
        _titleLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _titleLabel;
}

- (CXBaseTableView *)tableView{
    if(!_tableView){
        _tableView = [[CXBaseTableView alloc] initWithFrame:CGRectZero enablePullRefresh:NO];
        _tableView.baseDelegate = self;
        _tableView.backgroundColor = [CXUserDefaults instance].bgColor;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = YES;
    }
    return _tableView;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (void)deselect{
    [_tableView deselectRowAtIndexPath:[_tableView indexPathForSelectedRow] animated:YES];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_options count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CourseQuestionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if(!cell){
        cell = [[CourseQuestionTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID isSingle:_isSingle];
    }
    cell.contentView.backgroundColor = [CXUserDefaults instance].bgColor;
   
    
    [cell updateUIWithIndex:indexPath.row option:[_options objectAtIndex:indexPath.row] isSingle:_isSingle];
    

    return cell;
}

#pragma mark - public method

- (void)updateUIByQuestion:(CourseQuestion *)question{
    _question = question;
    
    NSInteger textHeight = [self getTitleHeight:question.title];
        
    [_titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(textHeight);
    }];
    [_titleLeftView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(textHeight);
    }];
    
    _options = [FMDBUtil getOptionsByString:question.options type:1];          //获取各个选项
    _isSingle = [question.type isEqualToString:@"bbb"] ? NO : YES;
    
    [_tableView reloadData];
}



- (NSInteger)getTitleHeight:(NSString *)text{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:3];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [text length])];
    _titleLabel.attributedText = attributedString;
    
    CGSize size = CGSizeMake(CXScreenWidth-15*2 -TitlePaddingLeft-TitlePaddingRight, CGFLOAT_MAX);
    CGRect labelRect = [text boundingRectWithSize:size
                                                    options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin
                                                 attributes:@{NSFontAttributeName:CXSystemFont([CXUserDefaults instance].questionFontSize),NSParagraphStyleAttributeName:paragraphStyle} context:nil] ;
    
    NSInteger textHeight = (int)CGRectGetHeight(labelRect)+1+TitlePaddingRight*2;
    
    return textHeight;
}

@end
