//
//  ModifyPasswordViewController.m
//  xbsz
//
//  Created by lotus on 2017/5/16.
//  Copyright © 2017年 lotus. All rights reserved.
//

#import "ModifyPasswordViewController.h"
#import "IQKeyboardManager.h"
#import "CXNetwork+User.h"
#import "LoginViewController.h"

@interface ModifyPasswordViewController () <UITextFieldDelegate>

@property (nonatomic, strong) UIImageView *iconImageView;

@property (nonatomic, strong) UITextField *oldTextField;
@property (nonatomic, strong) UITextField *pwdTextField;

@property (nonatomic, strong) UIButton *resetBtn;

@end

@implementation ModifyPasswordViewController

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [IQKeyboardManager sharedManager].enable = YES;
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"修改密码";
    [self showTopLineView];
    
    
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
    
    
    
    [scrollView addSubview:self.oldTextField];
    [_oldTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_iconImageView.mas_bottom).mas_equalTo(30);
        make.left.mas_equalTo(self.view).mas_offset(30);
        make.right.mas_equalTo(self.view).mas_offset(-30);
        make.height.mas_equalTo(60);
    }];
    
    UIView *lineView1 = [[UIView alloc] init];
    lineView1.backgroundColor = CXLineColor;
    [scrollView addSubview:lineView1];
    [lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(_oldTextField.mas_bottom);
        make.left.mas_equalTo(self.view).mas_offset(30);
        make.right.mas_equalTo(self.view).mas_offset(-30);
        make.height.mas_equalTo(1/CXMainScale);
    }];
    
    
    [scrollView addSubview:self.pwdTextField];
    [_pwdTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_oldTextField.mas_bottom);
        make.left.mas_equalTo(self.view).mas_offset(30);
        make.right.mas_equalTo(self.view).mas_offset(-30);
        make.height.mas_equalTo(60);
    }];
    
    UIView *lineView2 = [[UIView alloc] init];
    lineView2.backgroundColor = CXLineColor;
    [scrollView addSubview:lineView2];
    [lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(_pwdTextField.mas_bottom);
        make.left.mas_equalTo(self.view).mas_offset(30);
        make.right.mas_equalTo(self.view).mas_offset(-30);
        make.height.mas_equalTo(1/CXMainScale);
    }];
  
    
    [scrollView addSubview:self.resetBtn];
    [_resetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_pwdTextField.mas_bottom).mas_offset(30);
        make.left.mas_equalTo(self.view).mas_offset(30);
        make.right.mas_equalTo(self.view).mas_offset(-30);
        make.height.mas_equalTo(40);
    }];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (UITextField *)oldTextField{
    if(!_oldTextField){
        _oldTextField = [[UITextField alloc] init];
        _oldTextField.backgroundColor = [UIColor whiteColor];
        _oldTextField.placeholder = @"旧密码";
        _oldTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _oldTextField.delegate = self;
        _oldTextField.secureTextEntry = YES;
        _oldTextField.returnKeyType = UIReturnKeyNext;
    }
    return _oldTextField;
}

- (UITextField *)pwdTextField{
    if(!_pwdTextField){
        _pwdTextField = [[UITextField alloc] init];
        _pwdTextField.backgroundColor = [UIColor whiteColor];
        _pwdTextField.placeholder = @"新密码";
        _pwdTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _pwdTextField.delegate = self;
        _pwdTextField.secureTextEntry = YES;
        _pwdTextField.returnKeyType = UIReturnKeyDone;
    }
    return _pwdTextField;
}

- (UIButton *)resetBtn{
    if(!_resetBtn){
        _resetBtn = [[UIButton alloc] init];
        [_resetBtn addTarget:self action:@selector(resetBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [_resetBtn setTitle:@"修改密码" forState:UIControlStateNormal];
        [_resetBtn setBackgroundColor:CXMainColor];
        [_resetBtn setTitleColor:CXHexColor(0xFFFFFF) forState:UIControlStateNormal];
        _resetBtn.layer.cornerRadius = 20;
        [_resetBtn clipsToBounds];
    }
    return _resetBtn;
}

#pragma mark - UITextFieldDelegate


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField == _oldTextField) {
        [_pwdTextField becomeFirstResponder];
    }else{
        [self resetBtnClick];
    }
    return YES;
}

- (void)resetBtnClick{
    [self modifyPassword];
}


- (void)modifyPassword{
    if([self check]){
        [ToastView show];
        [CXNetwork modiyfPassword:_pwdTextField.text oldPassword:_oldTextField.text success:^(NSObject *obj) {
            [[CXLocalUser instance] reset];     //清空本地用户数据
            [ToastView showSuccessWithStaus:@"修改成功,重新登录"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController presentViewController:[LoginViewController controller] animated:YES completion:nil];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self.navigationController popToRootViewControllerAnimated:YES];
                });
            });
            
        } failure:^(NSError *error) {
            if(error.code == CXResponseCodeOldPasswordError){
                [ToastView showErrorWithStaus:@"旧密码错误"];
            }else{
                [ToastView showErrorWithStaus:@"修改失败"];
            }
        }];
    }
}



- (BOOL)check{
    
    if([_oldTextField.text length] > 0 && [_pwdTextField.text length]){
        NSString *pattern = @"^[a-zA-Z0-9]{6,20}$";
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",pattern];
        BOOL isMatched = [pred evaluateWithObject:_oldTextField.text] && [pred evaluateWithObject:_pwdTextField.text];
        if(!isMatched){
            [ToastView showErrorWithStaus:@"密码错误(6-20位字母或数字)"];
            return NO;
        }
        if([_oldTextField.text isEqualToString:_pwdTextField.text]){
            [ToastView showErrorWithStaus:@"新密码不能与旧密码相同"];
            return NO;
        }
    }else{
        [ToastView showErrorWithStaus:@"请输入密码"];
        return NO;
    }
    
    return YES;
}

@end
