//
//  RegisterViewController.m
//  xbsz
//
//  Created by lotus on 2016/12/24.
//  Copyright © 2016年 lotus. All rights reserved.
//

#import "RegisterViewController.h"
#import "CXNetwork+User.h"
#import "CXBaseWebViewController.h"

@interface RegisterViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) UIImageView *iconImageView;

@property (nonatomic,strong) UITextField *userNameField;
@property (nonatomic,strong) UITextField *nickFiled;
@property (nonatomic,strong) UITextField *passwordFiled;

@property (nonatomic,strong) UIButton *registerBtn;


@end

@implementation RegisterViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear: animated];
    _userNameField.text = @"";
    _nickFiled.text = @"";
    _passwordFiled.text = @"";
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self showTopLineView];

    self.title = @"注册";
    self.view.backgroundColor = CXWhiteColor;
    
    [self.view addSubview:self.iconImageView];
    [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).mas_offset(CX_PHONE_NAVIGATIONBAR_HEIGHT+16);
        make.width.height.mas_equalTo(72);
        make.centerX.mas_equalTo(self.view.mas_centerX);
    }];
    
    [self.view addSubview:self.userNameField];
    [_userNameField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_iconImageView.mas_bottom).mas_offset(35);
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
    
   
    
    [self.view addSubview:self.nickFiled];
    [_nickFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_userNameField.mas_bottom);
        make.left.mas_equalTo(self.view.mas_left).mas_equalTo(30);
        make.right.mas_equalTo(self.view.mas_right).mas_equalTo(-40);
        make.height.mas_equalTo(50);
    }];
    UIView *lineView2 = [[UIView alloc] init];
    lineView2.backgroundColor = CXLineColor;
    [self.view addSubview:lineView2];
    [lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(_nickFiled.mas_bottom);
        make.left.mas_equalTo(self.view).mas_offset(30);
        make.right.mas_equalTo(self.view).mas_offset(-30);
        make.height.mas_equalTo(1/CXMainScale);
    }];
    
    
    [self.view addSubview:self.passwordFiled];
    [_passwordFiled mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.mas_equalTo(_nickFiled.mas_bottom);
        make.left.mas_equalTo(self.view.mas_left).mas_equalTo(30);
        make.right.mas_equalTo(self.view.mas_right).mas_equalTo(-30);
        make.height.mas_equalTo(50);
    }];
    UIView *lineView3 = [[UIView alloc] init];
    lineView3.backgroundColor = CXLineColor;
    [self.view addSubview:lineView3];
    [lineView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(_passwordFiled.mas_bottom);
        make.left.mas_equalTo(self.view).mas_offset(30);
        make.right.mas_equalTo(self.view).mas_offset(-30);
        make.height.mas_equalTo(1/CXMainScale);
    }];
    
    
    [self.view addSubview:self.registerBtn];
    [_registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).mas_offset(20);
        make.right.mas_equalTo(self.view.mas_right).mas_offset(-30);
        make.height.mas_equalTo(40);
        make.top.mas_equalTo(_passwordFiled.mas_bottom).mas_offset(30);
    }];
 
    
  
    
    CGSize infoSize = [@"点击「注册」表示您已阅读并同意用户协议" boundingRectWithSize:CGSizeMake(CXScreenWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:CXSystemFont(13)} context:nil].size;
    CGFloat labelWidth = infoSize.width;
    
    UILabel *leftInfoLabel = [[UILabel alloc] init];
    leftInfoLabel.font = CXSystemFont(13);
    leftInfoLabel.text = @"点击「注册」表示您已阅读并同意";
    [self.view addSubview:leftInfoLabel];
    [leftInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).mas_offset((CXScreenWidth-labelWidth)/2);
        make.top.mas_equalTo(_registerBtn.mas_bottom).mas_equalTo(25);
        make.height.mas_equalTo(13);
    }];
    
    UILabel *rightInfoLabel = [[UILabel alloc] init];
    rightInfoLabel.font = CXSystemFont(13);
    rightInfoLabel.textColor = CXHexColor(0x63B8FF);
    rightInfoLabel.text = @"用户协议";
    rightInfoLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapProtocol = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(userProtocol)];
    [rightInfoLabel addGestureRecognizer:tapProtocol];
    [self.view addSubview:rightInfoLabel];
    [rightInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(leftInfoLabel.mas_right);
        make.top.mas_equalTo(_registerBtn.mas_bottom).mas_equalTo(25);
        make.height.mas_equalTo(13);
    }];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - getter / setter

- (UIImageView *)iconImageView{
    if(!_iconImageView){
        
        NSString *iconName = [CXUserDefaults instance].iconName;
        if([iconName isEqualToString:@"AppIcon"]){
            NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
            //获取app中所有icon名字数组
            NSArray *iconsArr = infoDict[@"CFBundleIcons"][@"CFBundlePrimaryIcon"][@"CFBundleIconFiles"];
            iconName = [iconsArr lastObject];
        }
        
        _iconImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:iconName]];
        _iconImageView.layer.cornerRadius = 12;
        _iconImageView.layer.masksToBounds = YES;        
        _iconImageView.contentMode = UIViewContentModeScaleToFill;
    }
    return _iconImageView;
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
        _userNameField.leftViewMode=UITextFieldViewModeAlways; //此处用来设置leftview现实时机
    }
    return _userNameField;
}

- (UITextField  *)nickFiled{
    if(!_nickFiled){
        _nickFiled = [[UITextField alloc] init];
        _nickFiled.placeholder = @"用户昵称";
        _nickFiled.backgroundColor = CXWhiteColor;
        _nickFiled.returnKeyType = UIReturnKeyDone;
        _nickFiled.clearButtonMode = UITextFieldViewModeWhileEditing;
        
        [_nickFiled setFont:CXSystemFont(16)];
        [_nickFiled setTextColor:CXLightGrayColor];
        _nickFiled.delegate = self;
        
        UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 33, 17)];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_nick"]];
        imageView.frame = CGRectMake(6, 0, 17, 17);
        [leftView addSubview:imageView];
        
        _nickFiled.leftView = leftView;
        _nickFiled.leftViewMode=UITextFieldViewModeAlways; //此处用来设置leftview现实时机

    }
    return _nickFiled;
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


- (UIButton *)registerBtn{
    if(!_registerBtn){
        _registerBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
        [_registerBtn setTitle:@"注 册" forState:UIControlStateNormal];
        [_registerBtn setTitleColor:CXWhiteColor forState:UIControlStateNormal];
        [_registerBtn setBackgroundColor:CXMainColor];
        _registerBtn.layer.cornerRadius = 20;
        [_registerBtn setClipsToBounds:YES];
        [_registerBtn addTarget:self action:@selector(userRegister) forControlEvents:UIControlEventTouchUpInside];
    }
    return  _registerBtn;
}

#pragma mark - private method

- (void)userRegister{
    if([self check]){
        [ToastView show];
        [CXNetwork userRegister:_userNameField.text password:_passwordFiled.text nickname:_nickFiled.text success:^(NSObject *obj) {
            [ToastView showBlackSuccessWithStaus:@"注册成功" delay:1];

            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
        } failure:^(NSError *error) {
            if(error.code == CXResponseCodeUserRepeat){
                [ToastView showBlackSuccessWithStaus:@"该账号已经被注册" delay:1];

            }else{
                [ToastView showBlackSuccessWithStaus:@"注册失败" delay:1];
            }
            
        }];
    }
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
    
    if([_nickFiled.text length] > 0){
        
    }else{
        [ToastView showErrorWithStaus:@"请输入昵称"];
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

-(void)userProtocol{
    CXBaseWebViewController *webViewController = [CXBaseWebViewController controller];
    webViewController.title = @"用户协议";
    webViewController.hideShareBtn = YES;
    webViewController.url = CXUserProtocolUrl;
    [self.navigationController pushViewController:webViewController animated:YES];
    
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if(textField == _userNameField){
        [_passwordFiled becomeFirstResponder];
    }else{
        [self.view endEditing:YES];
        [self userRegister];
    }
    return YES;
    
}

@end
