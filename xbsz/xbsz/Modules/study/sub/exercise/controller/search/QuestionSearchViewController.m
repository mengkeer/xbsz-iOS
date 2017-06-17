//
//  SearchViewController.m
//  xbsz
//
//  Created by lotus on 2017/4/27.
//  Copyright © 2017年 lotus. All rights reserved.
//

#import "QuestionSearchViewController.h"
#import "CXBaseTableView.h"
#import "FMDBUtil.h"
#import "ExerciseQuestion.h"
#import "SearchResultViewController.h"

static NSString *cellID = @"QuestionSearchTableViewCell";
static NSInteger symbolWidth = 35;

@interface QuestionSearchViewController () <UITextFieldDelegate,CXBaseTableViewDelegate>

@property (nonatomic, strong) UITextField *searchField;

@property (nonatomic, strong) UIButton *cancelBtn;

@property (nonatomic, strong) CXBaseTableView *tableView;

@property (nonatomic, strong) NSMutableArray *questions;

@end

@implementation QuestionSearchViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.customNavBarView.hidden = YES;
    
    UIView *topView = [[UIView alloc] init];
    topView.backgroundColor = CXBackGroundColor;
    [self.view addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(64);
    }];
    
    [topView addSubview:self.searchField];
    [topView addSubview:self.cancelBtn];
    
    CGSize size = CGSizeMake(CGFLOAT_MAX, 44);
    CGRect labelRect = [@"取消" boundingRectWithSize:size
                                          options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin
                                       attributes:@{NSFontAttributeName:CXSystemFont(16)} context:nil];
    
    [_cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).mas_offset(20);
        make.right.mas_equalTo(self.view.mas_right).mas_offset(-10);
        make.width.mas_equalTo(CGRectGetWidth(labelRect)+5);
        make.height.mas_equalTo(44);
    }];
    
    [_searchField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).mas_offset(27);
        make.left.mas_equalTo(self.view).mas_offset(10);
        make.right.mas_equalTo(_cancelBtn.mas_left).mas_offset(-7);
        make.height.mas_equalTo(30);
    }];
    
    [self.view addSubview:self.tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view.mas_top).mas_offset(64);
    }];
    [self loadData:_searchText];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (void)loadData:(NSString *)text{
    _questions = [FMDBUtil getSearchResultsBySearchText:text type:_type];
    [_tableView reloadData];
}

#pragma  mark - getter/setter

- (UITextField *)searchField{
    if(!_searchField){
        _searchField = [[UITextField alloc] init];
        _searchField.placeholder = @"搜索题干、选项";
        _searchField.backgroundColor = CXWhiteColor;
        _searchField.clearButtonMode=UITextFieldViewModeWhileEditing;
        _searchField.returnKeyType = UIReturnKeySearch;
        [_searchField setFont:[UIFont systemFontOfSize:16.0]];
        [_searchField setTextColor:CXBlackColor];
        
        _searchField.layer.cornerRadius = 5;
        _searchField.clipsToBounds = YES;
        _searchField.delegate = self;
        if(_searchText != nil || [[_searchText stringByTrim] length] != 0){
            _searchField.text = _searchText;
        }
        
        UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"course_search"]];
        imageView.frame = CGRectMake(6, 6, 18,18);
        [leftView addSubview:imageView];
        
        _searchField.leftView = leftView;
        _searchField.leftViewMode=UITextFieldViewModeAlways; //此处用来设置leftview现实时机
    }
    return _searchField;
}

- (UIButton *)cancelBtn{
    if(!_cancelBtn){
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        _cancelBtn.titleLabel.font = CXSystemFont(16);
        _cancelBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [_cancelBtn setTitleColor:CXBlackColor forState:UIControlStateNormal];
        [_cancelBtn addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}

- (CXBaseTableView *)tableView{
    if(!_tableView){
        _tableView = [[CXBaseTableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped enablePullRefresh:NO];
        _tableView.baseDelegate = self;
        _tableView.backgroundColor = CXWhiteColor;
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

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(section == 0 && [_questions count] <= 20){
        return 40.f;
    }
    return 0.01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if(section == 0 && ([_questions count]>20 || [_questions count] == 0)){
        return 40.f;
    }
    return 0.01f;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if([_questions count] > 20 || [_questions count] <= 0) return nil;
    UIView *view = [[UIView alloc] init];
    UILabel *label = [[UILabel alloc] init];
    label.text = [NSString stringWithFormat:@"搜索结果 (共%ld条)",[_questions count]];
    label.font = CXSystemFont(14);
    label.textAlignment = NSTextAlignmentLeft;
    label.textColor = CXHexColor(0x4A4A4A);
    
    [view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(view).mas_offset(15);
        make.height.mas_equalTo(15);
        make.centerY.mas_equalTo(view.mas_centerY);
    }];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = CXLineColor;
    [view addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(view.mas_left).mas_offset(10);
        make.right.bottom.mas_equalTo(view);
        make.height.mas_equalTo(1/CXMainScale);
    }];
    
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if([_questions count] >0 && [_questions count] <= 20) return nil;
    UIView *view = [[UIView alloc] init];
    UILabel *label = [[UILabel alloc] init];
    NSString *text = nil;
    if([_questions count] == 0){
        text = @"暂无搜索结果,请重新搜索";
    }else{
        text = @"搜索结果太多,请重新搜索";
    }
    label.text = text;
    label.font = CXSystemFont(15);
    label.textAlignment = NSTextAlignmentLeft;
    label.textColor = CXHexColor(0x4A4A4A);
    
    CGSize size = CGSizeMake(CGFLOAT_MAX, 40);
    CGRect labelRect = [@"搜索结果太多,请重新搜索" boundingRectWithSize:size
                                           options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin
                                        attributes:@{NSFontAttributeName:CXSystemFont(15)} context:nil];
    CGFloat totalWidth = CGRectGetWidth(labelRect)+32+6;
    
    UIImageView *cryImageView = [[UIImageView alloc] init];
    cryImageView.image = [UIImage imageNamed:@"search_cry"];
    
    [view addSubview:label];
    [view addSubview:cryImageView];
    
    [cryImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(32);
        make.centerY.mas_equalTo(view.mas_centerY);
        make.left.mas_equalTo(view).mas_offset((CXScreenWidth-totalWidth)/2);
    }];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(cryImageView.mas_right).mas_offset(6);
        make.height.mas_equalTo(20);
        make.centerY.mas_equalTo(view.mas_centerY);
    }];
    
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self performSelector:@selector(deselect) withObject:nil afterDelay:0.2f];
    SearchResultViewController *resultVC = [SearchResultViewController controller];
    resultVC.question = [_questions objectAtIndex:indexPath.row];
    [self.lcNavigationController pushViewController:resultVC];
}

- (void)deselect{
    [_tableView deselectRowAtIndexPath:[_tableView indexPathForSelectedRow] animated:YES];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_questions count] > 20 ? 20 : [_questions count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    QuestionSearchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if(!cell){
        cell = [[QuestionSearchTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    ExerciseQuestion *question = (ExerciseQuestion *)[_questions objectAtIndex:indexPath.row];
    NSString *beforeStr = question.type == 1 ? @"单选·" : (question.type ==2 ? @"多选·" :@"判断·");
    NSString *text = [NSString stringWithFormat:@"%@  %@\t%@",beforeStr,[FMDBUtil getPureTitle:question.title],question.answer];
    [cell updateUIWithIndex:indexPath.row+1 content:text];
    return cell;
}


#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat sectionHeaderHeight = 40;
    if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
    }
   
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if(textField == _searchField){
        [self.view endEditing:YES];
        NSString *currentText = [_searchField.text stringByTrim];
        if([currentText length] == 0){
            [ToastView showErrorWithStaus:@"搜索内容的为空" delay:0.4];
        }else if([currentText isEqualToString:_searchText]){
            [ToastView showErrorWithStaus:@"亲，请不要重复搜索" delay:0.4];
        }
        else{
            _searchText = currentText;
            [self loadData:_searchText];
        }
    }
    return YES;
}

#pragma mark - private method

- (void)cancel{
    [self.lcNavigationController popViewController];
}


@end


#pragma mark - 自定义的Cell

@interface  QuestionSearchTableViewCell ()

@property (nonatomic, strong) UILabel *symbolLabel;

@property (nonatomic, strong) UILabel *contentLabel;

@end

@implementation QuestionSearchTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if([super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self initQuestionSearchCell];
    }
    return self;
}

- (void)initQuestionSearchCell{
    [self.contentView addSubview:self.symbolLabel];
    [self.contentView addSubview:self.contentLabel];
    [_symbolLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(symbolWidth);
        make.centerY.mas_equalTo(self.contentView);
        make.left.mas_equalTo(self.contentView.mas_left).mas_offset(10);
    }];
    
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_symbolLabel.mas_right).mas_offset(10);
        make.top.mas_equalTo(self.contentView.mas_top).mas_offset(10);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).mas_offset(-10);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.right.mas_equalTo(self.contentView.mas_right).mas_offset(-15);
        make.height.mas_equalTo(20);
    }];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = CXLineColor;
    [self.contentView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).mas_offset(55);
        make.right.bottom.mas_equalTo(self.contentView);
        make.height.mas_equalTo(1/CXMainScale);
    }];
}

- (UILabel *)symbolLabel{
    if(!_symbolLabel){
        _symbolLabel = [[UILabel alloc] init];
        _symbolLabel = [[UILabel alloc] init];
        _symbolLabel.font = CXSystemFont(14);
        _symbolLabel.textColor = CXBlackColor;
        _symbolLabel.textAlignment = NSTextAlignmentCenter;
        _symbolLabel.layer.borderWidth = 1;
        _symbolLabel.layer.cornerRadius = symbolWidth/2;
        _symbolLabel.layer.borderColor = CXBlackColor.CGColor;
        _symbolLabel.clipsToBounds = YES;
    }
    return _symbolLabel;
}

- (UILabel *)contentLabel{
    if(!_contentLabel){
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.textAlignment = NSTextAlignmentLeft;
        _contentLabel.font = CXSystemFont(15);
        _contentLabel.textColor = CXBlackColor;
        _contentLabel.numberOfLines = 0;
    }
    return _contentLabel;
}

- (void)updateUIWithIndex:(NSInteger)index content:(NSString *)text{
    _symbolLabel.text = [NSString stringWithFormat:@"%ld",index];

    NSInteger textHeight = [self getTitleHeight:text];
    [_contentLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(textHeight);
    }];
    [_contentLabel sizeToFit];
}

- (NSInteger)getTitleHeight:(NSString *)text{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:3];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [text length])];
    _contentLabel.attributedText = attributedString;
    
    CGSize size = CGSizeMake(CXScreenWidth-10-symbolWidth-10-15, CGFLOAT_MAX);
    CGRect labelRect = [text boundingRectWithSize:size
                                          options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin
                                       attributes:@{NSFontAttributeName:CXSystemFont(15),NSParagraphStyleAttributeName:paragraphStyle} context:nil] ;
    
    NSInteger textHeight = (int)CGRectGetHeight(labelRect)+1;
    
    if(textHeight<30)   return 30;
    
    return textHeight;
}

@end
