//
//  MajorViewController.m
//  xbsz
//
//  Created by lotus on 2017/4/24.
//  Copyright © 2017年 lotus. All rights reserved.
//

#import "MajorViewController.h"
#import "CXNetwork+User.h"

@interface MajorViewController () <UITextFieldDelegate>

@property (nonatomic, strong) UIButton *saveBtn;

@property (nonatomic, strong) UITextField *majorTextField;

@end

@implementation MajorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的专业";
    
    [self.customNavBarView addSubview:self.saveBtn];
    
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, [self getStartOriginY]+15, CXScreenWidth, 44)];
    bgView.backgroundColor = CXWhiteColor;
    [bgView addSubview:self.majorTextField];
    
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

- (UITextField *)majorTextField{
    if(!_majorTextField){
        _majorTextField = [[UITextField alloc] initWithFrame:CGRectMake(15, 0, CXScreenWidth-15, 44)];
        _majorTextField.backgroundColor = CXWhiteColor;
        _majorTextField.font = CXSystemFont(15);
        _majorTextField.textColor = CXHexColor(0x272b3c);
        _majorTextField.returnKeyType = UIReturnKeyDone;
        _majorTextField.delegate = self;
        _majorTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _majorTextField.placeholder = @"请输入专业";
        _majorTextField.text = [CXLocalUser instance].major;
    }
    return _majorTextField;
}


#pragma mark - private method

- (void)saveNickname{
    
    NSString *nickname = [_majorTextField.text stringByTrim];
    long len = [nickname length];
    if(len == 0){
        [ToastView showErrorWithStaus:@"请输入专业名"];
        return;
    }else if(len < 2 || len > 12){
        [ToastView showErrorWithStaus:@"限2~12个字符"];
        return;
    }else{
        NSString *token = [CXLocalUser instance].token;
        NSMutableDictionary *paremeters = [NSMutableDictionary dictionaryWithObjectsAndKeys:[_majorTextField.text stringByTrim],@"major", nil];
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
