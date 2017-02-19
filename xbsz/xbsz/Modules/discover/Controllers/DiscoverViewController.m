//
//  DiscoverViewController.m
//  xbsz
//
//  Created by lotus on 2016/12/14.
//  Copyright © 2016年 lotus. All rights reserved.
//

#import "DiscoverViewController.h"
#import "CommendViewController.h"

@interface DiscoverViewController ()

@end

@implementation DiscoverViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.view.backgroundColor = CXMainColor;
    
    /**
     如果_isfullScreen = Yes，这个方法就不好使。
     
     设置整体内容的frame,包含（标题滚动视图和内容滚动视图）
     */
    [self setUpContentViewFrame:^(UIView *contentView) {
        contentView.frame = CGRectMake(0, 20, CXScreenWidth, CXScreenHeight - CXStatusBarHeight - CXTabbarHeight);
        contentView.backgroundColor = CXMainColor;
    }];
    
    // 添加所有子控制器
    [self setUpAllViewController];
    
    [self setUpTitleEffect:^(UIColor *__autoreleasing *titleScrollViewColor, UIColor *__autoreleasing *norColor, UIColor *__autoreleasing *selColor, UIFont *__autoreleasing *titleFont, CGFloat *titleHeight, CGFloat *titleWidth){
        *titleScrollViewColor = CXMainColor;
        *norColor = CXHexAlphaColor(0xFFFFFF, 0.7);
        *selColor = [UIColor whiteColor];
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
        *underLineColor = CXWhiteColor;
        *isUnderLineEqualTitleWidth = YES;
        *underLineH = 2;
    }];
    
    self.selectIndex = 0;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private
// 添加所有子控制器
- (void)setUpAllViewController
{
    
    //校园
    CommendViewController *vc1 = [CommendViewController controller];
    vc1.title = @"校园";
    [self addChildViewController:vc1];
    
    //推荐
    CommendViewController *vc2 = [CommendViewController controller];
    vc2.title = @"推荐";
    [self addChildViewController:vc2];
    
    
    
    //动态
    CommendViewController *vc3 = [CommendViewController controller];
    vc3.title = @"动态";
    [self addChildViewController:vc3];
    
    
}

@end
