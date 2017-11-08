//
//  LoginViewController.m
//  xbsz
//
//  Created by lotus on 2016/12/21.
//  Copyright © 2016年 lotus. All rights reserved.
//

#import "LoginViewController.h"
#import "IQKeyboardManager.h"
#import "RegisterViewController.h"
#import "ResetViewController.h"
#import "CXNetwork+User.h"

@interface LoginViewController ()<UITextFieldDelegate>

@property (nonatomic,strong) UIButton *closeBtn;
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic,strong) UILabel *loginTypeLabel;
@property (nonatomic,strong) UITextField *userNameField;
@property (nonatomic,strong) UITextField *passwordFiled;

@property (nonatomic,strong) UIButton *loginBtn;

@property (nonatomic,strong) UILabel *registerLabel;

@property (nonatomic,strong) UIButton *loginQQ;
@property (nonatomic,strong) UIButton *loginWeibo;
@property (nonatomic,strong) UIButton *loginWechat;

@end

@implementation LoginViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear: animated];
    [self.navigationController.view sendSubviewToBack:self.navigationController.navigationBar];
    _userNameField.text = @"";
    _passwordFiled.text = @"";
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self.view setBackgroundColor:CXWhiteColor];
    
    [IQKeyboardManager sharedManager].enable = YES;
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    [self createUI];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - private method

- (void)createUI{
    [self.view addSubview:self.closeBtn];
    [self.view addSubview:self.iconImageView];
//    [self.view addSubview:self.loginTypeLabel];
    
    [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).mas_offset(80);
        make.width.height.mas_equalTo(72);
        make.centerX.mas_equalTo(self.view.mas_centerX);
    }];
    
//    [_loginTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(_iconImageView.mas_bottom).mas_offset(30);
//        make.height.mas_equalTo(12);
//        make.centerX.mas_equalTo(self.view);
//    }];
    
    [self.view addSubview:self.userNameField];
    [_userNameField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_iconImageView.mas_bottom).mas_offset(32);
        make.height.mas_equalTo(50);
        make.left.mas_equalTo(self.view.mas_left).mas_offset(30);
        make.right.mas_equalTo(self.view.mas_right).mas_offset(-30);
    }];
    UIView *lineView1 = [[UIView alloc] init];
    lineView1.backgroundColor = CXLineColor;
    [self.view addSubview:lineView1];
    [lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(_userNameField.mas_bottom);
        make.left.mas_equalTo(self.view).mas_offset(30);
        make.right.mas_equalTo(self.view).mas_offset(-30);
        make.height.mas_equalTo(1/CXMainScale);
    }];
    
    
    [self.view addSubview:self.passwordFiled];
    [_passwordFiled mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.mas_equalTo(_userNameField.mas_bottom);
        make.left.mas_equalTo(self.view.mas_left).mas_equalTo(30);
        make.right.mas_equalTo(self.view.mas_right).mas_equalTo(-30);
        make.height.mas_equalTo(50);
    }];
    UIView *lineView2 = [[UIView alloc] init];
    lineView2.backgroundColor = CXLineColor;
    [self.view addSubview:lineView2];
    [lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(_passwordFiled.mas_bottom);
        make.left.mas_equalTo(self.view).mas_offset(30);
        make.right.mas_equalTo(self.view).mas_offset(-30);
        make.height.mas_equalTo(1/CXMainScale);
    }];
    
 
    
    [self.view addSubview:self.loginBtn];
    [_loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).mas_offset(20);
        make.right.mas_equalTo(self.view.mas_right).mas_offset(-20);
        make.height.mas_equalTo(40);
        make.top.mas_equalTo(_passwordFiled.mas_bottom).mas_offset(30);
    }];
    
    
    [self.view addSubview:self.registerLabel];
    
    [_registerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.width.mas_equalTo(100);
        make.top.mas_equalTo(_loginBtn.mas_bottom).mas_offset(18);
        make.height.mas_equalTo(13);
    }];
    
}


#pragma mark - getter / setter

- (UIButton *)closeBtn{
    if(!_closeBtn){
        _closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _closeBtn.titleLabel.font = CXSystemFont(16);
        _closeBtn.frame = CGRectMake(CXScreenWidth - 32, CX_PHONE_STATUSBAR_HEIGHT+7, 22, 22);
        [_closeBtn setImage:[UIImage imageNamed:@"common_close"] forState:UIControlStateNormal];
        @weakify(self);
        [_closeBtn addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
            [weak_self dismissViewControllerAnimated:YES completion:nil];
        }];
        
    }
    return _closeBtn;
}

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

- (UILabel *)loginTypeLabel{
    if(!_loginTypeLabel){
        _loginTypeLabel = [[UILabel alloc] init];
        _loginTypeLabel.font = CXSystemFont(12);
        _loginTypeLabel.text = @"上次登录方式:账号密码登录";
        _loginTypeLabel.textColor = CXHexColor(0xf16c4d);
        _loginTypeLabel.hidden = YES;
    }
    return _loginTypeLabel;
}

- (UITextField *)userNameField{
    if(!_userNameField){
        _userNameField = [[UITextField alloc] init];
        _userNameField.placeholder = @"用户名";
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
        _userNameField.leftViewMode = UITextFieldViewModeAlways; //此处用来设置leftview实现时机
    }
    return _userNameField;
}

- (UITextField *)passwordFiled{
    if(!_passwordFiled){
        _passwordFiled = [[UITextField alloc] init];
        _passwordFiled.placeholder = @"密码(6~20位)";
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
        [_loginBtn setTitle:@"登 录" forState:UIControlStateNormal];
        [_loginBtn setTitleColor:CXWhiteColor forState:UIControlStateNormal];
        [_loginBtn setBackgroundColor:CXMainColor];
        _loginBtn.layer.cornerRadius = 20;
        [_loginBtn setClipsToBounds:YES];
        [_loginBtn addTarget:self action:@selector(userLogin) forControlEvents:UIControlEventTouchUpInside];
    }
    return  _loginBtn;
}

- (UILabel *)registerLabel{
    if(!_registerLabel){
        _registerLabel = [[UILabel alloc] init];
        _registerLabel.text = @"新用户注册";
        _registerLabel.textAlignment = NSTextAlignmentCenter;
        _registerLabel.textColor = CXLightGrayColor;
        _registerLabel.font = CXSystemFont(13);
        _registerLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickRegister)];
        [_registerLabel addGestureRecognizer:tap];
        
        
    }
    return _registerLabel;
}

- (UIButton *)loginQQ{
    if(!_loginQQ){
        _loginQQ = [UIButton buttonWithType:UIButtonTypeCustom];
        [_loginQQ setImage:[UIImage imageNamed:@"loginQQ"] forState:UIControlStateNormal];
        _loginQQ.layer.cornerRadius = 45;
        _loginQQ.clipsToBounds = YES;
    }
    return _loginQQ;
}

- (UIButton *)loginWechat{
    if(!_loginWechat){
        _loginWechat = [UIButton buttonWithType:UIButtonTypeCustom];
        [_loginWechat setImage:[UIImage imageNamed:@"loginWeChat"] forState:UIControlStateNormal];
        _loginWechat.layer.cornerRadius = 45;
        _loginWechat.clipsToBounds = YES;
    }
    return _loginWechat;
}

- (UIButton *)loginWeibo{
    if(!_loginWeibo){
        _loginWeibo = [UIButton buttonWithType:UIButtonTypeCustom];
        [_loginWeibo setImage:[UIImage imageNamed:@"loginWeiBo"] forState:UIControlStateNormal];
        _loginWeibo.layer.cornerRadius = 45;
        _loginWeibo.clipsToBounds = YES;
    }
    return _loginWeibo;
}


#pragma mark - private method

- (void)clickRegister{
    [self.lcNavigationController pushViewController:[RegisterViewController controller]];
}

- (void)clickReset{
    [self.navigationController pushViewController:[ResetViewController controller] animated:YES];
}

- (void)userLogin{
    if([self check]){
        [ToastView show];
        [CXNetwork userLogin:_userNameField.text password:_passwordFiled.text success:^(NSObject *obj) {
            if([CXLocalUser instance].token){
                [self getUserInfo:[CXLocalUser instance].token];
            }else{
                [ToastView showErrorWithStaus:@"登录失败，该账号异常" delay:1];
            }
        } failure:^(NSError *error) {
            [ToastView showErrorWithStaus:@"登录失败，账号或密码错误" delay:1];
        }];
    }
}

- (void)getUserInfo:(NSString *)token{

    [CXNetwork getUserInfo:token success:^(NSObject *obj) {
        if(obj && ((NSDictionary *)obj)[@"userInfo"]){
            [ToastView showSuccessWithStaus:@"登录成功" delay:1];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self dismissViewControllerAnimated:YES completion:nil];
            });
        }
        
    } failure:^(NSError *error) {
        [ToastView showErrorWithStaus:@"获取用户信息失败" delay:1];
    }];
}

- (BOOL)check{
    
    if([_userNameField.text length] > 0){
        NSString *pattern = @"^[a-zA-Z0-9]{6,20}$";
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",pattern];
        BOOL isMatched = [pred evaluateWithObject:_userNameField.text];
        if(!isMatched){
            [ToastView showErrorWithStaus:@"请输入正确的用户名(6-20位字母或数字)"];
            return NO;
        }
    }else{
        [ToastView showErrorWithStaus:@"请输入用户名"];
        return NO;
    }
    
    if([_passwordFiled.text length] > 0){
        NSString *pattern = @"^[a-zA-Z0-9]{6,20}$";
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",pattern];
        BOOL isMatched = [pred evaluateWithObject:_passwordFiled.text];
        if(!isMatched){
            [ToastView showErrorWithStaus:@"密码错误(6-20位字母或数字)"];
            return NO;
        }
    }else{
        [ToastView showErrorWithStaus:@"请输入密码"];
        return NO;
    }
    
    return YES;
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if(textField == _userNameField){
        [_passwordFiled becomeFirstResponder];
    }else{
        [self.view endEditing:YES];
        [self userLogin];
    }
    return YES;
}

@end
