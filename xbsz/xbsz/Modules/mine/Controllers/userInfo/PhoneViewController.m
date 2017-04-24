//
//  PhoneViewController.m
//  xbsz
//
//  Created by lotus on 2017/4/23.
//  Copyright © 2017年 lotus. All rights reserved.
//

#import "PhoneViewController.h"
#import "CXNetwork+User.h"

@interface PhoneViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) UIButton *saveBtn;

@property (nonatomic, strong) UITextField *phoneTextField;

@end

@implementation PhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的手机";
    
    [self.customNavBarView addSubview:self.saveBtn];
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, [self getStartOriginY]+15, CXScreenWidth, 44)];
    bgView.backgroundColor = CXWhiteColor;
    [bgView addSubview:self.phoneTextField];
    
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
        _saveBtn.frame = CGRectMake(CXScreenWidth-15-width, 20, width, 44);
        [_saveBtn addTarget:self action:@selector(savePhoneNumber) forControlEvents:UIControlEventTouchUpInside];
        [_saveBtn setEnabled:NO];
    }
    return _saveBtn;
}

- (UITextField *)phoneTextField{
    if(!_phoneTextField){
        _phoneTextField = [[UITextField alloc] initWithFrame:CGRectMake(15, 0, CXScreenWidth-15, 44)];
        _phoneTextField.backgroundColor = CXWhiteColor;
        _phoneTextField.font = CXSystemFont(15);
        _phoneTextField.textColor = CXHexColor(0x272b3c);
        _phoneTextField.returnKeyType = UIReturnKeyDone;
        _phoneTextField.delegate = self;
        _phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
        _phoneTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _phoneTextField.placeholder = @"请输入手机号";
        _phoneTextField.text = [CXLocalUser instance].mobile;
    }
    return _phoneTextField;
}


#pragma mark - private method

- (void)savePhoneNumber{
    
    if([self phoneIsLegal]){
        NSString *token = [CXLocalUser instance].token;
        NSMutableDictionary *paremeters = [NSMutableDictionary dictionaryWithObjectsAndKeys:_phoneTextField.text,@"mobile", nil];
        [CXNetwork updateUserInfo:token parameters:paremeters success:^(NSObject *obj) {
            [ToastView showSuccessWithStaus:@"修改成功"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
        } failure:^(NSError *error) {
            [ToastView showErrorWithStaus:@"修改失败"];
        }];
    }
}

- (BOOL)phoneIsLegal{
    NSString *phone = [_phoneTextField.text stringByTrim];
    long len = [phone length];
    if(len == 0){
        [ToastView showErrorWithStaus:@"请输入手机号"];
        return NO;
    }else if(len != 11){
        [ToastView showErrorWithStaus:@"请输入正确的手机号"];
        return NO;
    }else{
        NSString *pattern = @"^1[34578]\\d{9}$";
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",pattern];
        BOOL isMatched = [pred evaluateWithObject:phone];
        if(!isMatched){
            [ToastView showErrorWithStaus:@"请输入正确的手机号"];
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
    [self savePhoneNumber];
    return  YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if (string.length == 1 && range.location == 10 && range.length == 0) {
        [self.saveBtn setTitleColor:CXHexColor(0xfab82b) forState:UIControlStateNormal];
        [self.saveBtn.titleLabel setFont:[UIFont fontWithName: @"Helvetica-Bold" size:15]];
        _saveBtn.enabled = YES;
    }else{
        [self.saveBtn setTitleColor:CXHexColor(0Xc6c9d2) forState:UIControlStateNormal];
        _saveBtn.enabled = NO;
    }
    return YES;
}


@end
