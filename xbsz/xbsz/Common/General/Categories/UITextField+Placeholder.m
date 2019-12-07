//
//  UITextField+Placeholder.m
//  xbsz
//
//  Created by lotus on 2019/12/7.
//  Copyright © 2019 lotus. All rights reserved.
//

#import "UITextField+Placeholder.h"

@implementation UITextField (Placeholder)

- (void)setPlaceholderColor:(UIColor *)color{
    Ivar ivar =  class_getInstanceVariable([UITextField class], "_placeholderLabel");
    UILabel *placeholderLabel = object_getIvar(self, ivar);
    placeholderLabel.textColor = color;
}

@end
