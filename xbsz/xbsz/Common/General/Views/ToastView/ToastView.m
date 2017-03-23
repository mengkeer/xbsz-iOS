//
//  ToastView.m
//  xbsz
//
//  Created by 陈鑫 on 17/3/23.
//  Copyright © 2017年 lotus. All rights reserved.
//

#import "ToastView.h"
#import  "SVProgressHUD.h"

@implementation ToastView

+ (void)showSuccessWithStaus:(NSString *)status{
    [SVProgressHUD dismiss];
    [SVProgressHUD showSuccessWithStatus:status];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

+ (void)showErrorWithStaus:(NSString *)status{
    [SVProgressHUD dismiss];
    [SVProgressHUD showErrorWithStatus:status];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

@end
