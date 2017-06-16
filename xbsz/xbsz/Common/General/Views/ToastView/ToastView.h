//
//  ToastView.h
//  xbsz
//
//  Created by 陈鑫 on 17/3/23.
//  Copyright © 2017年 lotus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ToastView : NSObject

+ (void)show;

+ (void)showProgressBar:(NSString *)status;

+ (void)dismiss;

+ (void)showStatus:(NSString *)status;

+ (void)showStatus:(NSString *)status delay:(NSInteger)delay;

+ (void)showErrorWithStaus:(NSString *)status;

+ (void)showErrorWithStaus:(NSString *)status delay:(NSInteger)delay;

+ (void)showSuccessWithStaus:(NSString *)status;

+ (void)showBlackSuccessWithStaus:(NSString *)status;

+ (void)showSuccessWithStaus:(NSString *)status delay:(NSInteger)delay;

+ (void)showBlackSuccessWithStaus:(NSString *)status delay:(NSInteger)delay;

@end
