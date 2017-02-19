//
//  UIView+CXAdd.m
//  xbsz
//
//  Created by lotus on 2016/12/13.
//  Copyright © 2016年 lotus. All rights reserved.
//

#import "UIView+CXAdd.h"

@implementation UIView (CXAdd)

- (void)cornerRadius:(CGFloat)radius borderWidth:(CGFloat)width borderColor:(UIColor*)color{
    CALayer* layer = [self layer];
    [layer setMasksToBounds:YES];
    [layer setCornerRadius:radius];
    [layer setBorderWidth:width];
    [layer setBorderColor:color.CGColor];
}

@end
