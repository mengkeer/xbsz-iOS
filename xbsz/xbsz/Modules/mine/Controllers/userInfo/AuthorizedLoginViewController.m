//
//  AuthorizedLoginViewController.m
//  xbsz
//
//  Created by lotus on 2017/4/7.
//  Copyright © 2017年 lotus. All rights reserved.
//

#import "AuthorizedLoginViewController.h"
#import "IQKeyboardManager.h"

@interface AuthorizedLoginViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) UILabel *loginLabel;
@property (nonatomic, strong) UILabel *timeLabel;

@property (nonatomic, strong) UITextField *userNameField;
@property (nonatomic, strong) UITextField *passwordFiled;

@property (nonatomic, strong) UIButton *loginBtn;

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
    
    [self.contentView addSubview:self.loginLabel];
    [_loginLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top).mas_offset(40);
        make.left.right.mas_equalTo(self.contentView);
        make.height.mas_equalTo(20);
    }];
    
    if(_isAuthorized){
        [self.contentView addSubview:self.timeLabel];
        [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_loginLabel.mas_bottom).mas_offset(20);
            make.left.right.mas_equalTo(self.contentView);
            make.height.mas_equalTo(20);
        }];
    }
    
    
    [self.contentView addSubview:self.userNameField];
    [_userNameField mas_makeConstraints:^(MASConstraintMaker *make) {
        if(_isAuthorized)    make.top.mas_equalTo(self.timeLabel.mas_bottom).mas_offset(20);
        else   make.top.mas_equalTo(self.loginLabel.mas_bottom).mas_offset(20);
        make.height.mas_equalTo(45);
        make.left.mas_equalTo(self.contentView.mas_left).mas_offset(20);
        make.right.mas_equalTo(self.contentView.mas_right).mas_offset(-20);
    }];
    
    [self.contentView layoutIfNeeded];
    
    //设置上半部分圆角
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:_userNameField.bounds byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight cornerRadii:CGSizeMake(4, 4)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = _userNameField.bounds;
    maskLayer.path = maskPath.CGPath;
    
    //设置边框
    CAShapeLayer *borderLayer = [[CAShapeLayer alloc] init];
    borderLayer.frame = _userNameField.bounds;
    borderLayer.path = maskPath.CGPath;
    borderLayer.lineWidth = 1/CXMainScale;
    borderLayer.strokeColor = CXLightGrayColor.CGColor;   // 边框颜色
    borderLayer.fillColor = CXClearColor.CGColor;
    
    _userNameField.layer.mask = maskLayer;
    [_userNameField.layer addSublayer:borderLayer];
    
    
    [self.contentView addSubview:self.passwordFiled];
    [_passwordFiled mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.mas_equalTo(_userNameField.mas_bottom);
        make.left.mas_equalTo(self.contentView.mas_left).mas_equalTo(20);
        make.right.mas_equalTo(self.contentView.mas_right).mas_equalTo(-20);
        make.height.mas_equalTo(45);
    }];
    
    [self.contentView layoutIfNeeded];
    
    //设置下半部分圆角
    UIBezierPath *passwordPath = [UIBezierPath bezierPathWithRoundedRect:_passwordFiled.bounds byRoundingCorners:UIRectCornerBottomLeft|UIRectCornerBottomRight cornerRadii:CGSizeMake(4, 4)];
    
    CAShapeLayer *passwordMask = [[CAShapeLayer alloc] init];
    passwordMask.path = passwordPath.CGPath;
    passwordMask.frame = _passwordFiled.bounds;
    
    CAShapeLayer *passwordLayer = [[CAShapeLayer alloc] init];
    passwordLayer.frame = _passwordFiled.bounds;
    passwordLayer.path = passwordPath.CGPath;
    passwordLayer.lineWidth = 1/CXMainScale;
    passwordLayer.strokeColor = CXLightGrayColor.CGColor;
    passwordLayer.fillColor = CXClearColor.CGColor;
    
    _passwordFiled.layer.mask = passwordMask;
    [_passwordFiled.layer addSublayer:passwordLayer];
    
    //覆盖两文本框中间加深的那条线
    UIView *middleLine = [[UIView alloc] init];
    middleLine.backgroundColor = CXWhiteColor;
    [self.contentView addSubview:middleLine];
    [middleLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(1/CXMainScale);
        make.left.mas_equalTo(self.contentView.mas_left).mas_offset(20);
        make.right.mas_equalTo(self.contentView.mas_right).mas_offset(-20);
        make.bottom.mas_equalTo(_passwordFiled.mas_top);
    }];
    
    
    [self.contentView addSubview:self.loginBtn];
    [_loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).mas_offset(20);
        make.right.mas_equalTo(self.contentView.mas_right).mas_offset(-20);
        make.height.mas_equalTo(40);
        make.top.mas_equalTo(_passwordFiled.mas_bottom).mas_offset(30);
    }];
}

#pragma mark - getter/setter

- (UILabel *)loginLabel{
    if(!_loginLabel){
        _loginLabel = [[UILabel alloc] init];
        _loginLabel.textAlignment = NSTextAlignmentCenter;
        _loginLabel.text = @"使用东华大学教务网账号登录";
        CGAffineTransform matrix = CGAffineTransformMake(1, 0, tanf(-15 * (CGFloat)M_PI / 180), 1, 0, 0);
        _loginLabel.transform = matrix;
        _loginLabel.textColor = CXHexColor(0xf16c4d);
        _loginLabel.font = [UIFont italicSystemFontOfSize:17];
    }
    return _loginLabel;
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
        if(_isAuthorized)   _userNameField.placeholder = [JWLocalUser instance].JWUserName;
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
        _passwordFiled.placeholder = @"教务网密码";
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


#pragma mark - Action
- (void)authorize{
    if([[_userNameField.text stringByTrim] isEqualToString:@""] || [[_passwordFiled.text stringByTrim] isEqualToString:@""]){
        [ToastView showErrorWithStaus:@"信息填写有误🙃"];
    }else{
        [self getJWUserInfo:_userNameField.text password:_passwordFiled.text];
    }
}

- (void)getJWUserInfo:(NSString *)username password:(NSString *)password{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.securityPolicy.allowInvalidCertificates = YES; // not recommended for production
    manager.securityPolicy.validatesDomainName = NO;//不验证证书的域名
    
    NSDictionary *parameters = @{@"username": username, @"password":password,
                                 @"apnsKey":JWAPNSKey,@"serialNo":JWSerialNo};
    [ToastView show];
    
    [manager POST:JWLoginUrl parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        // 获取所有数据报头信息
        NSHTTPURLResponse *HTTPResponse = (NSHTTPURLResponse *)task.response;
        NSDictionary *fields = [HTTPResponse allHeaderFields];// 原生NSURLConnection写法
        
        NSString *cookieString = [fields valueForKey:@"ssoCookie"];
        NSArray *arr = [cookieString JSONValue];
        NSString *CASTGC = [[arr objectAtIndex:0] valueForKey:@"cookieValue"];
        NSString *JWSessionID = [fields valueForKey:@"Set-Cookie"];
        JWSessionID = [JWSessionID stringByReplacingOccurrencesOfString:@"JSESSIONID=" withString:@""];
        JWSessionID = [JWSessionID stringByReplacingOccurrencesOfString:@"; Path=/; Secure" withString:@""];
        
        NSString *userPwd = [fields valueForKey:@"userPwd"];
        JWLocalUser *user = [JWLocalUser instance];
        user.JWUserName = username;
        user.JWPassword = password;
        user.JWEncryptPassword = userPwd;
        user.JWCastgc = CASTGC;
        user.JWSessionID = JWSessionID;
        user.time = [[NSDate new] stringWithFormat:@"yyyy-MM-dd HH-mm"];
        [user save];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            //        [ToastView showErrorWithStaus:@"mmm"];
            [ToastView dismiss];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [ToastView showSuccessWithStaus:@"授权成功"];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self.navigationController popViewControllerAnimated:YES];
                });
            });
        });
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            //        [ToastView showErrorWithStaus:@"mmm"];
            [ToastView dismiss];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [ToastView showErrorWithStaus:@"授权失败，账号或密码错误"];
            });
        });
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
