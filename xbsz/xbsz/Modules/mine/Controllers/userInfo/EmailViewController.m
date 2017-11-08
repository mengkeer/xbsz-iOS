//
//  EmailViewController.m
//  xbsz
//
//  Created by lotus on 2017/4/23.
//  Copyright © 2017年 lotus. All rights reserved.
//

#import "EmailViewController.h"
#import "CXNetwork+User.h"

@interface EmailViewController () <UITextFieldDelegate>

@property (nonatomic, strong) UIButton *saveBtn;

@property (nonatomic, strong) UITextField *emailTextField;


@end

@implementation EmailViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的邮箱";
    
    [self.customNavBarView addSubview:self.saveBtn];
    
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, [self getStartOriginY]+15, CXScreenWidth, 44)];
    bgView.backgroundColor = CXWhiteColor;
    [bgView addSubview:self.emailTextField];
    
    [self.view addSubview:bgView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - getter/setter

- (UIButton *)saveBtn{
    if(!_saveBtn){
        _saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        NSString *title = @"保存";
        [_saveBtn setTitle:title forState:UIControlStateNormal];
        [_saveBtn setTitleColor:CXHexColor(0xc6c9d2) forState:UIControlStateNormal];
        _saveBtn.titleLabel.font = CXSystemBoldFont(15);
        CGFloat width = [title sizeWithAttributes:@{NSFontAttributeName:CXSystemBoldFont(15)}].width;
        _saveBtn.frame = CGRectMake(CXScreenWidth-15-width, CX_PHONE_STATUSBAR_HEIGHT, width, 44);
        [_saveBtn addTarget:self action:@selector(saveEmail) forControlEvents:UIControlEventTouchUpInside];
        [_saveBtn setEnabled:NO];
    }
    return _saveBtn;
}

- (UITextField *)emailTextField{
    if(!_emailTextField){
        _emailTextField = [[UITextField alloc] initWithFrame:CGRectMake(15, 0, CXScreenWidth-15, 44)];
        _emailTextField.backgroundColor = CXWhiteColor;
        _emailTextField.font = CXSystemFont(15);
        _emailTextField.textColor = CXHexColor(0x272b3c);
        _emailTextField.returnKeyType = UIReturnKeyDone;
        _emailTextField.delegate = self;
        _emailTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _emailTextField.placeholder = @"请输入邮箱";
        _emailTextField.text = [CXLocalUser instance].email;
    }
    return _emailTextField;
}


#pragma mark - private method

- (void)saveEmail{
    if([self emailIsLegal]){
        NSString *token = [CXLocalUser instance].token;
        NSMutableDictionary *paremeters = [NSMutableDictionary dictionaryWithObjectsAndKeys:[_emailTextField.text stringByTrim],@"email", nil];
        [CXNetwork updateUserInfo:token parameters:paremeters success:^(NSObject *obj) {
            [ToastView showSuccessWithStaus:@"修改成功"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.lcNavigationController popViewController];
            });
        } failure:^(NSError *error) {
            [ToastView showErrorWithStaus:@"修改失败"];
        }];
    }
}

- (BOOL)emailIsLegal{
    NSString *email = [_emailTextField.text stringByTrim];
    long len = [email length];
    if(len == 0){
        [ToastView showErrorWithStaus:@"请输入邮箱"];
        return NO;
    }else{
        NSString *pattern = @"^[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+(\\.[a-zA-Z0-9_-]+)+$";
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",pattern];
        BOOL isMatched = [pred evaluateWithObject:email];
        if(!isMatched){
            [ToastView showErrorWithStaus:@"非法的邮箱格式"];
            return NO;
        }
    }

    return YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self saveEmail];
    return  YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    [self.saveBtn setTitleColor:CXHexColor(0xfab82b) forState:UIControlStateNormal];
    [self.saveBtn setEnabled:YES];
    
    return YES;
}


@end
