//
//  QuestionTitleLabel.m
//  xbsz
//
//  Created by lotus on 2017/4/26.
//  Copyright © 2017年 lotus. All rights reserved.
//

#import "QuestionTitleLabel.h"

@implementation QuestionTitleLabel

- (instancetype)initWithFrame:(CGRect)frame andInsets:(UIEdgeInsets)insets {
    self = [super initWithFrame:frame];
    if(self){
        self.insets = insets;
    }
    return self;
}

- (instancetype)initWithInsets:(UIEdgeInsets)insets {
    self = [super init];
    if(self){
        self.insets = insets;
    }
    return self;
}

- (instancetype)init{
    return [self initWithInsets:UIEdgeInsetsMake(2, 5, 2, 2)];
}


- (void)drawTextInRect:(CGRect)rect {
    return [super drawTextInRect:UIEdgeInsetsInsetRect(rect, self.insets)];
}


@end
