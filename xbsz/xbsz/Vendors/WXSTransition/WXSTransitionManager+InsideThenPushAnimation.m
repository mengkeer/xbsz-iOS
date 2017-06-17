//
//  WXSTransitionManager+InsideThenPushAnimation.m
//  WXSTransition
//
//  Created by AlanWang on 16/9/22.
//  Copyright © 2016年 王小树. All rights reserved.
//

#import "WXSTransitionManager+InsideThenPushAnimation.h"

@implementation WXSTransitionManager (InsideThenPushAnimation)


-(void)insideThenPushNextAnimationWithContext:(id<UIViewControllerContextTransitioning>)transitionContext{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    
    UIView *fromView = fromVC.view;
    UIView *toView = toVC.view;
    [containerView addSubview:fromView];
    [containerView addSubview:toView];
    [containerView setBackgroundColor:CXBlackColor];        //自定义
    
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    
    toView.layer.transform = CATransform3DMakeTranslation(screenWidth,0,0);
    [UIView animateWithDuration:self.animationTime animations:^{
        
        fromView.layer.transform = CATransform3DMakeScale(0.95,0.95,1);
        toView.layer.transform = CATransform3DIdentity;
        
    } completion:^(BOOL finished){
        
        if ([transitionContext transitionWasCancelled]) {
            [transitionContext completeTransition:NO];
            fromView.layer.transform = CATransform3DIdentity;
            
        }else{
            [transitionContext completeTransition:YES];
            fromView.layer.transform = CATransform3DIdentity;
        }
    }];
}

-(void)insideThenPushBackAnimationWithContext:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    
    UIView *tempToView = [toVC.view snapshotViewAfterScreenUpdates:YES];
    UIView *tempFromView = [fromVC.view snapshotViewAfterScreenUpdates:YES];
    
    UIView *fromView = fromVC.view;
    UIView *toView = toVC.view;
    
    [containerView addSubview:toView];
    [containerView addSubview:fromView];
    [containerView setBackgroundColor:CXBlackColor];        //自定义n
    
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    toView.layer.transform = CATransform3DMakeScale(0.95,0.95,1);
    fromView.layer.transform = CATransform3DIdentity;
    [UIView animateWithDuration:self.animationTime animations:^{
        toView.layer.transform = CATransform3DIdentity;
        fromView.layer.transform = CATransform3DMakeTranslation(screenWidth,0,0);
        
    } completion:^(BOOL finished){
        
        NSLog(@"导航动画完成");
        
        [tempToView removeFromSuperview];
        toView.hidden = NO;
        [tempFromView removeFromSuperview];
        toView.layer.transform = CATransform3DIdentity;
        if ([transitionContext transitionWasCancelled]) {
            [transitionContext completeTransition:NO];
        }else{
            [transitionContext completeTransition:YES];
        }
    }];
    
    self.willEndInteractiveBlock = ^(BOOL success) {
        NSLog(@"%d",success);
        if (success) {
            toView.layer.transform = CATransform3DIdentity;
            [containerView addSubview:tempToView];
            fromView.hidden = YES;
        }else {
            fromView.hidden = NO;
            toView.layer.transform = CATransform3DIdentity;
            
            [tempToView removeFromSuperview];
            [containerView addSubview:tempFromView];

            
        }
        
    };
    
}

@end
