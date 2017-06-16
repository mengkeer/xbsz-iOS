//
//  PhotoBrowserAnimator.h
//  SuperM
//
//  Created by hanx on 16/8/29.
//  Copyright © 2016年 hanx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PhotoBrowserPhotos.h"

@interface PhotoBrowserAnimator : NSObject <UIViewControllerTransitioningDelegate>
+ (nonnull instancetype)animatorWithPhotos:(PhotoBrowserPhotos * _Nonnull)photos;

/// 解除转场当前显示的图像视图
@property (nonatomic, nonnull) UIImageView *fromImageView;
@end
