//
//  RateView.h
//  xbsz
//
//  Created by 陈鑫 on 17/3/17.
//  Copyright © 2017年 lotus. All rights reserved.
//

#import <UIKit/UIKit.h>

//用于课程详情星级评分与评论bar   


@protocol RateViewDelegate <NSObject>

- (void)rateView:(CGFloat)scorePoint contnet:(NSString *)content;

@end


@interface RateView : UIView

@property (nonatomic, weak) id<RateViewDelegate> delegate;

+ (instancetype)instance;

- (void)showInView:(UIView *)view;

- (void)dismissInView:(UIView *)view;

@end
