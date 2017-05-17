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
#import "StudyUtil.h"

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

@property (nonatomic, assign) NSInteger selectedIndex;          //单选模式下当前索引

@property (nonatomic, copy) NSString *selectedIndexs;           //多选模式下当前所选索引

@property (nonatomic, assign) BOOL showTemporarySelected;       //是否显示临时选择

@property (nonatomic, assign) BOOL allowSelect;         //是否允许选中

@property (nonatomic, assign) BOOL showPracticeResult;         //是否显示做题结果


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
    _selectedIndex = indexPath.row;
    if(_baseDelegate && [_baseDelegate respondsToSelector:@selector(selectOption:)]){
        [_baseDelegate selectOption:indexPath.row];
    }
    [self performSelector:@selector(deselect) withObject:nil afterDelay:0.2f];
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
    if(_allowSelect == YES){
        cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    }else{
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    //练习模式下显示多选正确答案
    if(_showPracticeResult){
        [cell showMutiPracticeResult:indexPath.row selectedIndex:_selectedIndexs answer:_question.answer];
    }
    
    //设置临时选中效果
    if(_showTemporarySelected){
        [cell setTemporarySelected:indexPath.row selectedIndexs:_selectedIndexs];
    }
    

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
    
    _options = [StudyUtil getOptionsByString:_question.options type:_question.type];         //获取各个选项
    _isSingle = [StudyUtil isSingle:_question.type];
    
    [_tableView reloadData];
}

- (void)updateUIByQuestion:(CourseQuestion *)question allowSelect:(BOOL)allowSelect{
    _question = question;
    _showTemporarySelected = NO;
    _allowSelect = allowSelect;
    
    NSInteger textHeight = [self getTitleHeight:question.title];
    
    [_titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(textHeight);
    }];
    [_titleLeftView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(textHeight);
    }];
    
    _options = [StudyUtil getOptionsByString:_question.options type:_question.type];         //获取各个选项
    _isSingle = [StudyUtil isSingle:_question.type];
    
    [_tableView reloadData];
}

- (BOOL)showMutiPracticeAnswer:(NSString *)selectIndexs{
    _showPracticeResult = YES;
    _showTemporarySelected = NO;
    _allowSelect = NO;
    _selectedIndexs = selectIndexs;
    [_tableView reloadData];
    return [FMDBUtil isMutiRightAnswer:selectIndexs answer:_question.answer];
}

- (void)setTemporarySelected:(NSString *)selectedIndexs{
    _selectedIndexs = selectedIndexs;
    _showTemporarySelected = YES;
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

#pragma mark - 简答题 cell

@interface BlankCollectionViewCell () <UITextViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) QuestionTitleLabel *titleLabel;

@property (nonatomic, strong) UITextView *blankTextView;

@property (nonatomic, strong) UILabel *placeholderLabel;

@property (nonatomic, strong) UIView *titleLeftView;

@property (nonatomic, strong) CourseQuestion *question;

@end

@implementation BlankCollectionViewCell

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
    
    
    [_scrollView addSubview:self.blankTextView];
    [_blankTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).mas_offset(15);
        make.right.mas_equalTo(self.contentView.mas_right).mas_offset(-15);
        make.top.mas_equalTo(_titleLabel.mas_bottom).mas_offset(30);
        make.height.mas_equalTo(110);
    }];
    
}

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

- (UITextView *)blankTextView{
    if(!_blankTextView){
        _blankTextView = [[UITextView alloc] initWithFrame:CGRectMake(15, 15, CXScreenWidth-30, 110)];
        _blankTextView.backgroundColor = CXWhiteColor;
        _blankTextView.font = [UIFont systemFontOfSize:15];
        _blankTextView.textColor = CXBlackColor2;
        _blankTextView.text = @"";
        _blankTextView.showsVerticalScrollIndicator = YES;
        _blankTextView.layer.borderColor = CXHexColor(0x66afe9).CGColor;
        _blankTextView.layer.borderWidth = 1.0;
        _blankTextView.layer.cornerRadius = 4.0;
        _blankTextView.layer.shadowColor = CXHexColor(0x66afe9).CGColor;
        _blankTextView.layer.shadowOpacity = 0.6;
        _blankTextView.layer.shadowOffset = CGSizeMake(0,0);
        _blankTextView.clipsToBounds = NO;
        _blankTextView.delegate = self;
        _blankTextView.inputAccessoryView = [[UIView alloc] init];
        [_blankTextView addSubview:self.placeholderLabel];
    }
    return _blankTextView;
}

- (UILabel *)placeholderLabel{
    if(!_placeholderLabel){
        _placeholderLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 7, 150, CXSystemFont(15).lineHeight)];
        _placeholderLabel.textColor = CXHexColor(0x707070);
        _placeholderLabel.font = CXSystemFont(13);
        _placeholderLabel.textAlignment = NSTextAlignmentLeft;
        _placeholderLabel.text = @"请在此处输入答案";
    }
    return _placeholderLabel;
}

#pragma mark -- UITextViewDelegate

- (void)textViewDidChange:(UITextView *)textView{
    if ([textView.text length] > 0) {
        _placeholderLabel.hidden = YES;
    }else{
        _placeholderLabel.hidden = NO;
    }
    if(_baseDelegate && [_baseDelegate respondsToSelector:@selector(blankTextEntered:)]){
        [_baseDelegate blankTextEntered:textView.text];
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    return YES;
}

#pragma mark - 私有方法
- (void)updateUIByQuestion:(CourseQuestion *)question{
    _question = question;
    
    NSInteger textHeight = [self getTitleHeight:question.title];
    
    [_titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(textHeight);
    }];
    
    [_titleLeftView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(textHeight);
    }];
    
}

- (void)showTemporaryText:(NSString *)text{
    _blankTextView.text = text;
}

- (BOOL)showPracticeAnswer:(NSString *)text{
    _blankTextView.text = [NSString stringWithFormat:@"参考答案:%@",_question.answer];
    return [_question.answer isEqualToString:text];
}


- (void)updateUIByQuestion:(CourseQuestion *)question allowEdit:(BOOL)allowEdit{
    _question = question;
    _blankTextView.editable = allowEdit;
    
    NSInteger textHeight = [self getTitleHeight:question.title];
    [_titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(textHeight);
    }];
    [_titleLeftView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(textHeight);
    }];
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
