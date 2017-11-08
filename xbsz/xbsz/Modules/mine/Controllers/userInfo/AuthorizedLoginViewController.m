//
//  AuthorizedLoginViewController.m
//  xbsz
//
//  Created by lotus on 2017/4/7.
//  Copyright © 2017年 lotus. All rights reserved.
//

#import "AuthorizedLoginViewController.h"
#import "IQKeyboardManager.h"
#import "CXNetwork+User.h"

@interface AuthorizedLoginViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) UIImageView *iconImageView;

@property (nonatomic, strong) UILabel *timeLabel;

@property (nonatomic, strong) UITextField *userNameField;
@property (nonatomic, strong) UITextField *passwordFiled;

@property (nonatomic, strong) UIButton *loginBtn;

@property (nonatomic, strong) UILabel *tipsLabel;

@property (nonatomic, strong) UILabel  *tipsLabel2;

@property (nonatomic, assign) BOOL isAuthorized;

@end

@implementation AuthorizedLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = CXBackGroundColor;
    
    self.title = @"教务网授权登陆";
    [IQKeyboardManager sharedManager].enable = YES;
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    self.isAuthorized = [[JWLocalUser instance] isAuthorized];
    [self createUI];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)createUI{
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.showsVerticalScrollIndicator  = YES;
    scrollView.alwaysBounceVertical = YES;
    scrollView.backgroundColor = CXBackGroundColor;
    scrollView.contentSize = CGSizeMake(CXScreenWidth, CXScreenHeight-CX_PHONE_NAVIGATIONBAR_HEIGHT);
    [self.view addSubview:scrollView];
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.customNavBarView.mas_bottom);
    }];
    
    UIView *bgView = [[UIView alloc] init];
    bgView.backgroundColor = CXWhiteColor;
    [scrollView addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(scrollView.mas_top);
        make.height.mas_equalTo(CXScreenHeight-CX_PHONE_NAVIGATIONBAR_HEIGHT);
    }];
    
    
    [scrollView addSubview:self.iconImageView];
    [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(scrollView.mas_top).mas_offset(36);
        make.width.height.mas_equalTo(72);
        make.centerX.mas_equalTo(self.view.mas_centerX);
    }];
    
    
    if(_isAuthorized){
        [scrollView addSubview:self.timeLabel];
        [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_iconImageView.mas_bottom).mas_offset(20);
            make.left.right.mas_equalTo(self.view);
            make.height.mas_equalTo(20);
        }];
    }
    
    [scrollView addSubview:self.userNameField];
    [_userNameField mas_makeConstraints:^(MASConstraintMaker *make) {
        if(_isAuthorized)    make.top.mas_equalTo(self.timeLabel.mas_bottom).mas_offset(20);
        else   make.top.mas_equalTo(self.iconImageView.mas_bottom).mas_offset(20);
        make.top.mas_equalTo(_iconImageView.mas_bottom).mas_equalTo(30);
        make.left.mas_equalTo(self.view).mas_offset(30);
        make.right.mas_equalTo(self.view).mas_offset(-30);
        make.height.mas_equalTo(45);
    }];
    
    UIView *lineView1 = [[UIView alloc] init];
    lineView1.backgroundColor = CXLineColor;
    [scrollView addSubview:lineView1];
    [lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(_userNameField.mas_bottom);
        make.left.mas_equalTo(self.view).mas_offset(30);
        make.right.mas_equalTo(self.view).mas_offset(-30);
        make.height.mas_equalTo(1/CXMainScale);
    }];
    
    
    [scrollView addSubview:self.passwordFiled];
    [_passwordFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_userNameField.mas_bottom);
        make.left.mas_equalTo(self.view).mas_offset(30);
        make.right.mas_equalTo(self.view).mas_offset(-30);
        make.height.mas_equalTo(50);
    }];
    
    UIView *lineView2 = [[UIView alloc] init];
    lineView2.backgroundColor = CXLineColor;
    [scrollView addSubview:lineView2];
    [lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(_passwordFiled.mas_bottom);
        make.left.mas_equalTo(self.view).mas_offset(30);
        make.right.mas_equalTo(self.view).mas_offset(-30);
        make.height.mas_equalTo(1/CXMainScale);
    }];
    
    
    [scrollView addSubview:self.loginBtn];
    [_loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_passwordFiled.mas_bottom).mas_offset(30);
        make.left.mas_equalTo(self.view).mas_offset(30);
        make.right.mas_equalTo(self.view).mas_offset(-30);
        make.height.mas_equalTo(50);
    }];
    
    
    [scrollView addSubview:self.tipsLabel];
    [_tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.loginBtn.mas_bottom).mas_offset(20);
        make.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(15);
    }];
    
    [scrollView addSubview:self.tipsLabel2];
    //获取文字高度
    CGRect labelRect = [self.tipsLabel2.text boundingRectWithSize:CGSizeMake(CXScreenWidth-40, CGFLOAT_MAX) options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:CXSystemFont(11)} context:nil] ;
    
    NSInteger textHeight = (int)CGRectGetHeight(labelRect)+1;
    [_tipsLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_tipsLabel.mas_bottom).mas_offset(15);
        make.left.mas_equalTo(self.view).mas_offset(20);
        make.right.mas_equalTo(self.view).mas_offset(-20);
        make.height.mas_equalTo(textHeight);
    }];
}

#pragma mark - getter/setter

- (UIImageView *)iconImageView{
    if(!_iconImageView){
        NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
        //获取app中所有icon名字数组
        NSArray *iconsArr = infoDict[@"CFBundleIcons"][@"CFBundlePrimaryIcon"][@"CFBundleIconFiles"];
        NSString *iconLastName = [iconsArr lastObject];
        
        _iconImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:iconLastName]];
        _iconImageView.contentMode = UIViewContentModeScaleToFill;
    }
    return _iconImageView;
}

- (UILabel *)timeLabel{
    if(!_timeLabel){
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.textAlignment = NSTextAlignmentCenter;
        _timeLabel.text = [NSString stringWithFormat:@"上次授权时间:%@",[JWLocalUser instance].time];;
        _timeLabel.textColor = CXHexColor(0xf16c4d);
        _timeLabel.font = [UIFont italicSystemFontOfSize:11];
    }
    return _timeLabel;
}

- (UITextField *)userNameField{
    if(!_userNameField){
        _userNameField = [[UITextField alloc] init];
        _userNameField.placeholder = @"学号";
        _userNameField.backgroundColor = CXWhiteColor;
        _userNameField.clearButtonMode=UITextFieldViewModeWhileEditing;
        _userNameField.returnKeyType = UIReturnKeyNext;
        [_userNameField setFont:[UIFont systemFontOfSize:16.0]];
        [_userNameField setTextColor:CXLightGrayColor];
        _userNameField.delegate = self;
        
        UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 33, 17)];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_name"]];
        imageView.frame = CGRectMake(10, 0, 13, 17);
        [leftView addSubview:imageView];
        
        _userNameField.leftView = leftView;
        _userNameField.leftViewMode=UITextFieldViewModeAlways; //此处用来设置leftview现实时机
    }
    return _userNameField;
}

- (UITextField *)passwordFiled{
    if(!_passwordFiled){
        _passwordFiled = [[UITextField alloc] init];
        _passwordFiled.placeholder = @"密码";
        _passwordFiled.backgroundColor = CXWhiteColor;
        _passwordFiled.returnKeyType = UIReturnKeyDone;
        _passwordFiled.clearButtonMode = UITextFieldViewModeWhileEditing;
        _passwordFiled.secureTextEntry = YES;
        
        [_passwordFiled setFont:CXSystemFont(16)];
        [_passwordFiled setTextColor:CXLightGrayColor];
        _passwordFiled.delegate = self;
        
        UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 33, 17)];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_password"]];
        imageView.frame = CGRectMake(10, 0, 13, 17);
        [leftView addSubview:imageView];
        
        _passwordFiled.leftView = leftView;
        _passwordFiled.leftViewMode=UITextFieldViewModeAlways; //此处用来设置leftview现实时机
        
        
    }
    return _passwordFiled;
}

- (UIButton *)loginBtn{
    if(!_loginBtn){
        _loginBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
        [_loginBtn setTitle:@"授权登陆" forState:UIControlStateNormal];
        [_loginBtn setTitleColor:CXWhiteColor forState:UIControlStateNormal];
        [_loginBtn setBackgroundColor:CXMainColor];
        _loginBtn.layer.cornerRadius = 20;
        [_loginBtn setClipsToBounds:YES];
        [_loginBtn addTarget:self action:@selector(authorize) forControlEvents:UIControlEventTouchUpInside];
    }
    return  _loginBtn;
}

- (UILabel *)tipsLabel{
    if(!_tipsLabel){
        _tipsLabel = [[UILabel alloc] init];
        _tipsLabel.textAlignment = NSTextAlignmentCenter;
        _tipsLabel.text = @"tips:该账号为门户信息网站(my.dhu.edu.cn)的账号";
        _tipsLabel.textColor = CXHexColor(0x707070);
        _tipsLabel.font = [UIFont italicSystemFontOfSize:11];
    }
    return _tipsLabel;
}

- (UILabel *)tipsLabel2{
    if(!_tipsLabel2){
        _tipsLabel2 = [[UILabel alloc] init];
        _tipsLabel2.textAlignment = NSTextAlignmentCenter;
        _tipsLabel2.text = @"tips:账号密码只会保存到本地,不会上传到后台服务器,请放心登录";
        _tipsLabel2.textColor = CXHexColor(0x707070);
        _tipsLabel2.numberOfLines = 0;
        _tipsLabel2.font = [UIFont italicSystemFontOfSize:11];
    }
    return _tipsLabel2;
}

#pragma mark - Action
- (void)authorize{
    if([[_userNameField.text stringByTrim] isEqualToString:@""] || [[_passwordFiled.text stringByTrim] isEqualToString:@""]){
        [ToastView showStatus:@"信息填写有误🙃"];
    }else{
        [self getJWUserInfo:_userNameField.text password:_passwordFiled.text];
    }
}

- (void)getJWUserInfo:(NSString *)username password:(NSString *)password{
    
    [ToastView show];
    
    [CXNetwork JWLogin:username password:password success:^(NSObject *obj) {
        if(obj){
            [ToastView showStatus:@"授权成功" delay:1];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.lcNavigationController popViewController];
            });
        }
    } failure:^(NSError *error) {
        [ToastView showStatus:@"授权失败，账号或密码错误" delay:1];
    }];
    
}


#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if(textField == _userNameField){
        [_passwordFiled becomeFirstResponder];
    }else{
        [self.view endEditing:YES];
        [self authorize];
    }
    return YES;
}

@end
