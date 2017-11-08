//
//  CXLaunchViewController.h
//  idemo
//
//  Created by lotus on 06/12/2016.
//  Copyright © 2016 lotus. All rights reserved.
//

#import "CXLaunchViewController.h"
#import "CXTabBarController.h"
#import "DownloadManager.h"
#import "CXNetworkMonitoring.h"

#import "AppUtil.h"

@import GoogleMobileAds;



@interface CXLaunchViewController () <GADInterstitialDelegate>

@property(nonatomic, strong) GADInterstitial *interstitial;

@end

@implementation CXLaunchViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}


- (void)viewDidLoad{
    [super viewDidLoad];
    [self createUI];
    
    self.interstitial = [[GADInterstitial alloc] initWithAdUnitID:@"ca-app-pub-7139153640152838/7024508708"];
    self.interstitial.delegate = self;
//
//    GADRequest *request = [GADRequest request];
//    // Requests test ads on test devices.
//    request.testDevices =   @[ kGADSimulatorID ];
//    [self.interstitial loadRequest:request];
}

- (void)createUI{
    UIStoryboard *board = [UIStoryboard storyboardWithName: @"LaunchScreen" bundle: nil];
    
    UIViewController *vc = [board instantiateViewControllerWithIdentifier: @"LaunchScreen"];
    [self addChildViewController:vc];
    [self.view addSubview:vc.view];
    [vc.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(self.view);
    }];
    
    self.splashImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bilibili_splash_default"]];
    self.splashImageView.hidden = YES;
    self.splashImageView.layer.anchorPoint = CGPointMake(0.5, 0.8);
    [self.view addSubview:self.splashImageView];
    
    [self.splashImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.and.width.mas_equalTo(0);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.centerY.mas_equalTo(self.view.mas_centerY);
    }];
    
    NSString *launchTimes = [CXStandardUserDefaults objectForKey:APPFirstLaunchTime];
    

    @weakify(self);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        @strongify(self);
        [self launchWithAnimate];
    });
    //第一次启动应用
    if(![launchTimes isNotBlank]){
        if ([CXNetworkMonitoring canReachable] == YES) { // 有网状态
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
    [UIView animateWithDuration:1.5f delay:1.0f usingSpringWithDamping:0.2f initialSpringVelocity:8.0f options:0 animations:^{
        @strongify(self);
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        // 切换根控制器
        NSString *launchTime  = [CXStandardUserDefaults objectForKey:APPFirstLaunchTime];
        if(launchTime == nil)   [CXStandardUserDefaults setObject:[[NSDate date] stringWithFormat:@"yyyy-MM-dd HH-mm-ss"]  forKey:APPFirstLaunchTime];
        
        //App不是第一次启动
        if([launchTime isNotBlank]){
            if ([self.interstitial isReady] && [AppUtil showAD]) {
                [self.interstitial presentFromRootViewController:self];
            }else{
                [self gotoRootViewController];
            }
        }else{
            [self gotoRootViewController];
        }
            
      
        
//      [[UIApplication sharedApplication].keyWindow sendSubviewToBack:[UIApplication sharedApplication].keyWindow.rootViewController.view];

    }];

}

- (void)loadLaunchDataWhenAppFirstOpen{
    if(![DownloadManager isTikuExists]){
        [[DownloadManager manager] downloadTikuFromServer];
    }
}

- (void)gotoRootViewController{
    CATransition *anim = [CATransition animation];
    
    anim.type = @"rippleEffect";
    
    anim.duration = 1.0f;
    
    [CXApplication.keyWindow.layer addAnimation:anim forKey:nil];
    
    LCNavigationController *navC = [[LCNavigationController alloc] initWithRootViewController:[CXTabBarController controller]];

    CXApplication.keyWindow.rootViewController = navC;
}


#pragma mark  - 广告代理事件

- (void)interstitialWillDismissScreen:(GADInterstitial *)ad {
    [self gotoRootViewController];
}
@end
