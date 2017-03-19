//
//  CXSectionButton.m
//  xbsz
//
//  Created by 陈鑫 on 16/12/14.
//  Copyright © 2016年 lotus. All rights reserved.
//

#import "CXSectionButton.h"

@implementation CXSectionButton

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.imageView.size = CGSizeMake(30, 30);
    self.titleLabel.width = self.width;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    self.imageView.centerX = self.width * 0.5;
    self.imageView.centerY = self.width * 0.5 - self.imageView.width * 0.5 + 6;
    
    
    self.titleLabel.centerX = self.imageView.centerX;
    self.titleLabel.font = CXSystemFont(14);
    self.titleLabel.height = 15.0f;
    [self setTitleColor:CXBlackColor forState:UIControlStateNormal];
    self.titleLabel.top = self.imageView.bottom + 8;
}

- (instancetype)init:(CGRect)frame andImage:(UIImage *)image andTitle:(NSString *)title{

    self = [super initWithFrame:frame];
    if(self){
        [self setImage:image forState:UIControlStateNormal];
        [self setImage:image forState:UIControlStateHighlighted];
        [self setTitle:title forState:UIControlStateNormal];
    }
    return self;
}

@end
