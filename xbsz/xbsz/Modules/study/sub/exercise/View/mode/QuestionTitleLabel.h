//
//  QuestionTitleLabel.h
//  xbsz
//
//  Created by lotus on 2017/4/26.
//  Copyright © 2017年 lotus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuestionTitleLabel : UILabel

@property(nonatomic) UIEdgeInsets insets;

- (instancetype)initWithFrame:(CGRect)frame andInsets: (UIEdgeInsets) insets;

- (instancetype)initWithInsets: (UIEdgeInsets) insets;

@end
