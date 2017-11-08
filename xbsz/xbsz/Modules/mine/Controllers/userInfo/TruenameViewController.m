//
//  TruenameViewController.m
//  xbsz
//
//  Created by lotus on 2017/4/23.
//  Copyright © 2017年 lotus. All rights reserved.
//

#import "TruenameViewController.h"
#import "CXNetwork+User.h"

@interface TruenameViewController () <UITextFieldDelegate>

@property (nonatomic, strong) UIButton *saveBtn;

@property (nonatomic, strong) UITextField *truenameTextField;

@end

@implementation TruenameViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"真实姓名";
    
    [self.customNavBarView addSubview:self.saveBtn];
    
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, [self getStartOriginY]+15, CXScreenWidth, 44)];
    bgView.backgroundColor = CXWhiteColor;
    [bgView addSubview:self.truenameTextField];
    
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
        [_saveBtn addTarget:self action:@selector(saveNickname) forControlEvents:UIControlEventTouchUpInside];
        [_saveBtn setEnabled:NO];
    }
    return _saveBtn;
}

- (UITextField *)truenameTextField{
    if(!_truenameTextField){
        _truenameTextField = [[UITextField alloc] initWithFrame:CGRectMake(15, 0, CXScreenWidth-15, 44)];
        _truenameTextField.backgroundColor = CXWhiteColor;
        _truenameTextField.font = CXSystemFont(15);
        _truenameTextField.textColor = CXHexColor(0x272b3c);
        _truenameTextField.returnKeyType = UIReturnKeyDone;
        _truenameTextField.delegate = self;
        _truenameTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _truenameTextField.placeholder = @"请输入姓名";
        _truenameTextField.text = [CXLocalUser instance].truename;
    }
    return _truenameTextField;
}


#pragma mark - private method

- (void)saveNickname{
    
    NSString *nickname = [_truenameTextField.text stringByTrim];
    long len = [nickname length];
    if(len == 0){
        [ToastView showErrorWithStaus:@"请输入姓名"];
        return;
    }else if(len < 2 || len > 5){
        [ToastView showErrorWithStaus:@"昵称限2~5个字符"];
        return;
    }else{
        NSString *token = [CXLocalUser instance].token;
        NSMutableDictionary *paremeters = [NSMutableDictionary dictionaryWithObjectsAndKeys:[_truenameTextField.text stringByTrim],@"trueName", nil];
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

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self saveNickname];
    return  YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    [self.saveBtn setTitleColor:CXHexColor(0xfab82b) forState:UIControlStateNormal];
    [self.saveBtn setEnabled:YES];

    return YES;
}


@end
