//
//  CXStudyViewController.m
//  xbsz
//
//  Created by lotus on 2017/2/19.
//  Copyright © 2017年 lotus. All rights reserved.
//

#import "CXStudyViewController.h"
#import "ExerciseViewController.h"
#import "YZDisplayTitleLabel.h"
#import "AppUtil.h"

@import GoogleMobileAds;

@interface CXStudyViewController ()<GADBannerViewDelegate>

@property (nonatomic, strong) GADBannerView *bannerView;

@end

@implementation CXStudyViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    [self.navigationController.view sendSubviewToBack:self.navigationController.navigationBar];
    [self.navigationController.navigationBar setHidden:YES];        //词条语句可控制tarbar透明
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    GADRequest *request = [GADRequest request];
    request.testDevices = @[ kGADSimulatorID ];
    if([AppUtil showAD])    [self.bannerView loadRequest:request];
}

- (void)autoTheme{
    self.titleScrollViewColor = [CXUserDefaults instance].mainColor;
    self.contentView.backgroundColor = [CXUserDefaults instance].mainColor;
    self.view.backgroundColor = [CXUserDefaults instance].mainColor;

    NSInteger themeType = [CXUserDefaults instance].themeType;
    if(themeType == 2){
        self.norColor =  [CXUserDefaults instance].textColor;
        self.selColor = CXMainColor;
        self.underLineColor = CXMainColor;
    }else{
        self.norColor = CXHexAlphaColor(0xFFFFFF, 0.6);
        self.selColor = CXWhiteColor;
        self.underLineColor = CXWhiteColor;
    }
    [self refreshDisplay];
}

- (void)viewWillDisappear:(BOOL)animated{
    [self.navigationController.view bringSubviewToFront:self.navigationController.navigationBar];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleScrollViewColor = [CXUserDefaults instance].mainColor;
    self.contentView.backgroundColor = [CXUserDefaults instance].mainColor;
    self.view.backgroundColor = [CXUserDefaults instance].mainColor;
    /**
     如果_isfullScreen = Yes，这个方法就不好使。
     
     设置整体内容的frame,包含（标题滚动视图和内容滚动视图）
     */
    [self setUpContentViewFrame:^(UIView *contentView) {
        contentView.frame = CGRectMake(0, CX_PHONE_STATUSBAR_HEIGHT, CXScreenWidth, CXScreenHeight - CX_PHONE_STATUSBAR_HEIGHT);
        contentView.backgroundColor = CXMainColor;
    }];
    
    // 添加所有子控制器
    [self setUpAllViewController];
    
    [self setUpTitleEffect:^(UIColor *__autoreleasing *titleScrollViewColor, UIColor *__autoreleasing *norColor, UIColor *__autoreleasing *selColor, UIFont *__autoreleasing *titleFont, CGFloat *titleHeight, CGFloat *titleWidth){
        *titleScrollViewColor = CXMainColor;
        NSInteger themeType = [CXUserDefaults instance].themeType;
        if(themeType == 2){
            *norColor =  [CXUserDefaults instance].textColor;
            *selColor = CXMainColor;
        }else{
            *norColor = CXHexAlphaColor(0xFFFFFF, 0.6);
            *selColor = CXWhiteColor;
        }
        *titleWidth = 75;;
        *titleFont = CXSystemFont(16);
        *titleHeight = CXDisplayTitleHeight;
    }];
    
    // 标题渐变
    // *推荐方式(设置标题渐变)
    [self setUpTitleGradient:^(YZTitleColorGradientStyle *titleColorGradientStyle, UIColor *__autoreleasing *norColor, UIColor *__autoreleasing *selColor) {
        //        titleColorGradientStyle = YZTitleColorGradientStyleFill;
    }];
    
    [self setUpUnderLineEffect:^(BOOL *isUnderLineDelayScroll, CGFloat *underLineH, UIColor *__autoreleasing *underLineColor,BOOL *isUnderLineEqualTitleWidth) {
        
        //        *isUnderLineDelayScroll = YES;
        NSInteger themeType = [CXUserDefaults instance].themeType;
        if(themeType == 2){
            *underLineColor = CXMainColor;
        }else{
            *underLineColor = CXWhiteColor;
        }
        *isUnderLineEqualTitleWidth = YES;
        *underLineH = 2;
    }];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(autoTheme) name:NotificationThemeChanged object:nil];
    
    self.selectIndex = 0;
    
    
//    //添加广告
//    self.bannerView = [[GADBannerView alloc] initWithAdSize:kGADAdSizeSmartBannerPortrait];
//    self.bannerView.adUnitID = @"ca-app-pub-7139153640152838/2557283100";
//    self.bannerView.rootViewController = self;
//
//    [self.view addSubview:self.bannerView];
//    [self.bannerView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.width.mas_equalTo(320);
//        make.height.mas_equalTo(50);
//        make.centerX.mas_equalTo(self.view.mas_centerX);
//        make.bottom.mas_equalTo(self.view.mas_bottom).mas_offset(-CXTabbarHeight);
//    }];
//
//    self.bannerView.delegate = self;
    
    [AppUtil checkUpdate:self];     //检查更新
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Private
// 添加所有子控制器
- (void)setUpAllViewController{
    //题库
    ExerciseViewController *vc3 = [ExerciseViewController controller];
    vc3.title = @"题库";
    [self addChildViewController:vc3];
}

#pragma mark - 广告代理事件

//- (void)adViewDidReceiveAd:(GADBannerView *)bannerView {
//    bannerView.hidden = NO;
//}
//
//- (void)adView:(GADBannerView *)adView didFailToReceiveAdWithError:(GADRequestError *)error {
//    NSLog(@"adView:didFailToReceiveAdWithError: %@", error.localizedDescription);
//}

@end
