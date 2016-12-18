//
//  CXLaunchViewController.h
//  idemo
//
//  Created by lotus on 06/12/2016.
//  Copyright © 2016 lotus. All rights reserved.
//

#import "CXLaunchViewController.h"
#import "CXTabBarController.h"
//#import "UIImageView+WebCache.h"
////#import "YPTabBarController.h"
//#import "CXLaunchRealmModel.h"
//#import "CXLaunchViewModel.h"
//#import "CXAlertView.h"


@implementation CXLaunchViewController


- (void)viewDidLoad{
    [super viewDidLoad];
    [self createUI];
}

- (void)createUI{
    
    self.bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"launchBg"]];
    self.bgImageView.frame = self.view.frame;
    [self.view addSubview:self.bgImageView];
    
    self.splashImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bilibili_splash_default"]];
    self.splashImageView.hidden = YES;
    self.splashImageView.layer.anchorPoint = CGPointMake(0.5, 0.8);
    [self.view addSubview:self.splashImageView];
    
    [self.splashImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.and.width.mas_equalTo(0);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.centerY.mas_equalTo(self.view.mas_centerY);
    }];
    
    NSString *launchTimes = [CXUserDefaults objectForKey:AppLaunchTimes];
    
    //App不是第一次启动
    if([launchTimes isNotBlank]){
        
        //以背景图片加载 如果有的话  现在暂时取消  以动画形式加载
        @weakify(self);
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            @strongify(self);
            [self launchWithAnimate];
        });
        
    }else{
        //App第一次启动
        @weakify(self);
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            @strongify(self);
            [self launchWithAnimate];
        });
        
        /**
         *  动画加载之后如果有网要进行网络请求缓存图片，
         *  如果没有网络那么不必开启计数器，因此计数器要放在网络请求成功之后开启
         */
        
        if ([YYReachability reachability].status != YYReachabilityStatusNone) { // 有网状态
            [self loadLaunchDataWhenAppFirstOpen];
        }
        
    }
    
}

- (void)launchWithAnimate{
    
    self.splashImageView.hidden = NO;
  
    [self.splashImageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(320);
        make.height.mas_equalTo(420);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.centerY.mas_equalTo(self.view.mas_centerY);
    }];
    
    
    @weakify(self);
    [UIView animateWithDuration:1.5f delay:0.5f usingSpringWithDamping:0.2f initialSpringVelocity:8.0f options:0 animations:^{
        @strongify(self);
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        // 切换根控制器
        
        CATransition *anim = [CATransition animation];
        
        anim.type = @"rippleEffect";
        
        anim.duration = 1.0f;
        
        [[UIApplication sharedApplication].keyWindow.layer addAnimation:anim forKey:nil];
        
        [UIApplication sharedApplication].keyWindow.rootViewController = [CXTabBarController controller];
//        [[UIApplication sharedApplication].keyWindow sendSubviewToBack:[UIApplication sharedApplication].keyWindow.rootViewController.view];
//
    }];

}

- (void)loadLaunchDataWhenAppFirstOpen{
    
    
}

@end






































