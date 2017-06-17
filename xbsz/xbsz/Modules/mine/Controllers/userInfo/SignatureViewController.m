//
//  SignatureViewController.m
//  xbsz
//
//  Created by lotus on 2017/4/24.
//  Copyright © 2017年 lotus. All rights reserved.
//

#import "SignatureViewController.h"
#import "CXNetwork+User.h"

#define maxTextLength (40)

@interface SignatureViewController () <UITextViewDelegate>

@property (nonatomic, strong) UIButton *saveBtn;
@property (nonatomic, strong) UITextView *signatureTextView;
@property (nonatomic, strong) UILabel *placeholderLabel;
@property (nonatomic, strong) UILabel *countLabel;

@end

@implementation SignatureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"个性签名";
    [self.customNavBarView addSubview:self.saveBtn];
    [self.view addSubview:self.signatureTextView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

#pragma mark - getter/setter

- (UIButton *)saveBtn{
    if (!_saveBtn) {
        _saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        NSString *title = NSLocalizedString(@"保存", nil);
        [_saveBtn setTitle:title forState:UIControlStateNormal];
        [_saveBtn setTitleColor:CXHexColor(0Xc6c9d2) forState:UIControlStateNormal];
        UIFont *font = [UIFont boldSystemFontOfSize:15];
        _saveBtn.titleLabel.font = font;
        CGFloat width = [title sizeWithAttributes:@{NSFontAttributeName:font}].width;
        _saveBtn.frame = CGRectMake(CXScreenWidth-10-width, 20, width, 44);
        [_saveBtn addTarget:self action:@selector(saveSignature) forControlEvents:UIControlEventTouchUpInside];
        [_saveBtn setEnabled:NO];
    }
    return _saveBtn;
}

- (UITextView *)signatureTextView{
    if (!_signatureTextView) {
        _signatureTextView = [[UITextView alloc] initWithFrame:CGRectMake(0, [self getStartOriginY]+15, CXScreenWidth, 100)];
        _signatureTextView.textContainerInset = UIEdgeInsetsMake(15, 10, 15, 10);
        _signatureTextView.backgroundColor = [UIColor whiteColor];
        _signatureTextView.font = [UIFont systemFontOfSize:15];
        _signatureTextView.textColor = CXHexColor(0x272b3c);
        _signatureTextView.returnKeyType = UIReturnKeyDone;
        _signatureTextView.delegate = self;
//        [_signatureTextView limitTextLength:maxTextLength];
        [_signatureTextView addSubview:self.placeholderLabel];
        [_signatureTextView addSubview:self.countLabel];
    }
    return _signatureTextView;
}

- (UILabel *)placeholderLabel{
    if (!_placeholderLabel) {
        _placeholderLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 13, 100, 15)];
        _placeholderLabel.text = [NSString stringWithFormat:@"请输入签名,限%d字",maxTextLength];
        [_placeholderLabel sizeToFit];
        _placeholderLabel.textColor = CXHexColor(0xc6c9d2);
        _placeholderLabel.font = [UIFont systemFontOfSize:15];
    }
    return _placeholderLabel;
}

- (UILabel *)countLabel{
    if (!_countLabel) {
        _countLabel = [[UILabel alloc] initWithFrame:CGRectMake(CXScreenWidth-100, 100-13-15, 80, 15)];
        _countLabel.textColor = CXHexColor(0xc6c9d2);
        _countLabel.font = [UIFont systemFontOfSize:15];
        _countLabel.textAlignment = NSTextAlignmentRight;
        _countLabel.text = [@(maxTextLength) stringValue];
    }
    return _countLabel;
}

#pragma mark -- UITextViewDelegate

- (void)textViewDidChange:(UITextView *)textView{
    if ([textView.text length] > 0) {
        self.placeholderLabel.hidden = YES;
    }else{
        self.placeholderLabel.hidden = NO;
    }
    if([textView.text length] > maxTextLength){
        textView.text = [textView.text substringToIndex:maxTextLength];
    }
    if ([textView.text length] >= maxTextLength) {
        self.countLabel.text = [NSString stringWithFormat:@"限%d字", maxTextLength];
    } else {
        self.countLabel.text = [@(maxTextLength - [textView.text length]) stringValue];
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{

    if(text.length == 1 && range.location == maxTextLength && range.length == 0){
        return NO;
    }
    
    [self.saveBtn setTitleColor:CXHexColor(0xfab82b) forState:UIControlStateNormal];
    [self.saveBtn setEnabled:YES];
    
    if ([@"\n" isEqualToString:text]) {
        return NO;
    }
    return YES;
}

#pragma mark - private method

- (void)saveSignature{
    if([[_signatureTextView.text stringByTrim] length] == 0){
        [ToastView showErrorWithStaus:@"请输入个性签名"];
        return;
    }
    NSString *token = [CXLocalUser instance].token;
    NSMutableDictionary *paremeters = [NSMutableDictionary dictionaryWithObjectsAndKeys:[_signatureTextView.text stringByTrim],@"signature", nil];
    [CXNetwork updateUserInfo:token parameters:paremeters success:^(NSObject *obj) {
        [ToastView showSuccessWithStaus:@"修改成功"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.lcNavigationController popViewController];
        });
    } failure:^(NSError *error) {
        [ToastView showErrorWithStaus:@"修改失败"];
    }];
}




@end
