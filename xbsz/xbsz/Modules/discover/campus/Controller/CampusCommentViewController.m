//
//  CampusCommentViewController.m
//  xbsz
//
//  Created by lotus on 2017/5/15.
//  Copyright © 2017年 lotus. All rights reserved.
//

#import "CampusCommentViewController.h"
#import "CXBaseTableView.h"
#import "CampusCommentTableViewCell.h"
#import "IQKeyboardManager.h"
#import "CXAudioPlayer.h"

#import "CXNetwork+Course.h"        //暂时以课程评论为例
#import "CourseCommentList.h"       //暂时以课程评论为例


static NSString *cellID = @"InformTableViewCellID";
static NSString *lineCellID = @"InformLineCellID";
static NSInteger limit = 10;

@interface CampusCommentViewController () <CXBaseTableViewDelegate,UITextFieldDelegate>

@property (nonatomic, strong) CXBaseTableView *tableView;

@property (nonatomic, strong) CourseCommentList *commentList;

@property (nonatomic, strong) NSMutableArray *comments;

@property (nonatomic, strong) UIView *bottomView;

@property (nonatomic, strong) UITextField *writeTextField;

@property (nonatomic, strong) UIButton *sendBtn;

@property (nonatomic, strong) UILabel *totalLabel;

@property (nonatomic, strong) UIView *totalView;


@end

@implementation CampusCommentViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [IQKeyboardManager sharedManager].enable = YES;
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    [self loadDataAtPageIndex:CXFisrtLoadPage];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"评论";
    
    _tableView = [[CXBaseTableView alloc] initWithFrame:CGRectZero enablePullRefresh:YES];
    [self.contentView addSubview:_tableView];
    _tableView.contentSize = CGSizeMake(CXScreenWidth, CXScreenHeight-64-45);
    _tableView.backgroundColor = CXWhiteColor;
    _tableView.delegate = self;
    _tableView.separatorColor = CXLineColor;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.dataSource = self;
    _tableView.baseDelegate = self;
    _tableView.separatorStyle =   UITableViewCellSeparatorStyleNone;
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.mas_equalTo(self.contentView).mas_offset(-45);
        make.top.mas_equalTo(self.customNavBarView.mas_bottom);
    }];
    
    
    _bottomView = [UIView new];
    _bottomView.backgroundColor = CXWhiteColor;
    [self.view addSubview:_bottomView];
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.view);
        make.height.mas_equalTo(45);
    }];
    
    UIView *lineView = [UIView new];
    lineView.backgroundColor = CXLineColor;
    [self.view addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(_bottomView.mas_top);
        make.height.mas_equalTo(1/CXMainScale);
    }];
    
    [_bottomView addSubview:self.sendBtn];
    [_bottomView addSubview:self.writeTextField];
    
    [_sendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(30);
        make.right.mas_equalTo(_bottomView.mas_right).mas_offset(-15);
        make.centerY.mas_equalTo(_bottomView.mas_centerY);
    }];
    
    [_writeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_bottomView.mas_left).mas_offset(15);
        make.centerY.mas_equalTo(_bottomView.mas_centerY);
        make.right.mas_equalTo(_sendBtn.mas_left).mas_offset(-20);
        make.height.mas_equalTo(32);
    }];
    _writeTextField.layer.cornerRadius = 14;
    _writeTextField.clipsToBounds = YES;
    
    _comments = [NSMutableArray array];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - getter/setter

- (UITextField *)writeTextField{
    if(!_writeTextField){
//        writeicon
        _writeTextField = [[UITextField alloc] init];
        _writeTextField.placeholder = @"写评论...";
        _writeTextField.backgroundColor = CXHexColor(0xf4f5f6);
        _writeTextField.clearButtonMode = UITextFieldViewModeNever;
        _writeTextField.returnKeyType = UIReturnKeySend;
        [_writeTextField setFont:[UIFont systemFontOfSize:12.0]];
        [_writeTextField setTextColor:CXBlackColor2];
        _writeTextField.delegate = self;
    
        [_writeTextField setValue:CXHexColor(0x707070) forKeyPath:@"_placeholderLabel.textColor"];
        
        _writeTextField.inputAccessoryView = [[UIView alloc] init];
        
        
        UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(15, 0, 32, 32)];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"writeicon"]];
        imageView.frame = CGRectMake(8, 8, 16, 16);
        [leftView addSubview:imageView];
        
        _writeTextField.leftView = leftView;
        _writeTextField.leftViewMode=UITextFieldViewModeAlways; //此处用来设置leftview现实时机

    }
    return _writeTextField;
}

- (UIButton *)sendBtn{
    if(!_sendBtn){
        _sendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sendBtn setImage:[UIImage imageNamed:@"comment_send"] forState:UIControlStateNormal];
        [_sendBtn addTarget:self action:@selector(submitComment) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sendBtn;
}

- (UILabel *)totalLabel{
    if(!_totalLabel){
        _totalLabel = [UILabel new];
        _totalLabel.textColor = CXHexColor(0x4A4A4A);
        _totalLabel.textAlignment = NSTextAlignmentCenter;
        _totalLabel.text = @"";
        _totalLabel.font = CXSystemFont(12);
    }
    return _totalLabel;
}

- (UIView *)totalView{
    if(!_totalView){
        _totalView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CXScreenWidth, 15)];
        [_totalView addSubview:self.totalLabel];
        
        [_totalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(_totalView.mas_centerX);
            make.centerY.mas_equalTo(_totalView.mas_centerY);
            make.height.mas_equalTo(15);
            make.width.mas_equalTo(90);
        }];
        
        UIView *leftLineView = [UIView new];
        leftLineView.backgroundColor = CXLineColor;
        UIView *righttLineView = [UIView new];
        righttLineView.backgroundColor = CXLineColor;
        
        [_totalView addSubview:leftLineView];
        [_totalView addSubview:righttLineView];
        
        [leftLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_totalView.mas_left).mas_offset(15);
            make.right.mas_equalTo(_totalLabel.mas_left).mas_offset(-15);
            make.height.mas_equalTo(1/CXMainScale);
            make.centerY.mas_equalTo(_totalView.mas_centerY);
        }];
        
        [righttLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_totalLabel.mas_right).mas_offset(15);
            make.right.mas_equalTo(_totalView.mas_right).mas_offset(-15);
            make.height.mas_equalTo(1/CXMainScale);
            make.centerY.mas_equalTo(_totalView.mas_centerY);
        }];
        
    }
    return _totalView;
}

#pragma mark - 私有方法

- (void)loadDataAtPageIndex:(NSUInteger )pageIndex{
    @weakify(self);
    [CXNetwork getCourseComments:@"C1491831796925" offset:pageIndex-1 limit:limit success:^(NSObject *obj) {
        weak_self.commentList = [CourseCommentList yy_modelWithDictionary:(NSDictionary *)obj];
        if(pageIndex == 1){
            [weak_self.comments removeAllObjects];
        }
        
        [weak_self.comments addObjectsFromArray:_commentList.comments];
        
        CXPage *pageInfo = weak_self.commentList.pageInfo;
        
        if([weak_self.comments count] == 0){
            [weak_self.tableView showDefaultImageWithResult:NO];
        }else{
            [weak_self.tableView showRefresh];
        }
        
        if([weak_self.comments count] == pageInfo.count){
            [weak_self.tableView loadNoMoreData];
        }
        
        [weak_self.tableView reloadData];           //重新加载
        
        
    } failure:^(NSError *error) {
        if (weak_self.comments.count == 0) {
            [weak_self.tableView showDefaultImageWithResult:YES];
        }else{
            [ToastView showErrorWithStaus:@"加载失败"];
        }
        [weak_self.tableView endRefresh];
    }];
    
}


#pragma mark - UITableView delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}


- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45.f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}


#pragma mark - UITableView dataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_comments count]+2;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.row == 1){
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:lineCellID];
        if(!cell){
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:lineCellID];
            [cell.contentView addSubview:self.totalView];
            [_totalView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.top.right.bottom.mas_equalTo(cell.contentView);
                make.height.mas_equalTo(15);
            }];
        }
        if(_commentList == nil || _commentList.pageInfo == nil || _commentList.pageInfo.count  <0){
            _totalLabel.text = @"共0条回复";

        }else{
            _totalLabel.text = [NSString stringWithFormat:@"共%ld条回复",_commentList.pageInfo.count];
        }
        return cell;
        
    }else{
        CampusCommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if(!cell){
            cell = [[CampusCommentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        if(indexPath.row == 0){
            [cell updateUIWithModel:[self convertToComment:_note]];
        }else{
            [cell updateUIWithModel:[_comments objectAtIndex:indexPath.row-2]];
        }
        return cell;
    }
}

- (CampusComment *)convertToComment:(CampusNote *)note{
    CampusComment *comment = [CampusComment new];
    comment.noteID = note.noteID;
    comment.userID = note.user.userID;
    comment.content = note.subject;
    comment.avatar = note.user.avatar;
    comment.nickname = note.user.nickname;
    comment.time = note.time;
    
    return comment;
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if(textField == _writeTextField){
        [self submitComment];
    }else{
        [_writeTextField resignFirstResponder];
    }
    return YES;
}

- (void)submitComment{
    if(_writeTextField.text == nil || [_writeTextField.text length] == 0){
        if([_writeTextField isFirstResponder]){
            [ToastView showStatus:@"请输入评论内容"];
        }else{
            [_writeTextField becomeFirstResponder];
        }
        return;
    }
    
    if([_writeTextField.text length] !=0 && [[_writeTextField.text stringByTrim] length] == 0){
        [ToastView showStatus:@"评论内容为空"];
        return;
    }
    
    [CXAudioPlayer playSent];
    [ToastView showStatus:@"评论成功"];
    _writeTextField.text = @"";
    [_writeTextField resignFirstResponder];
    
}


@end
