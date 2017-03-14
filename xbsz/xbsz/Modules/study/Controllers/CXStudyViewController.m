//
//  CXStudyViewController.m
//  xbsz
//
//  Created by lotus on 2017/2/19.
//  Copyright © 2017年 lotus. All rights reserved.
//

#import "CXStudyViewController.h"
#import "CourseViewController.h"
#import "ExerciseViewController.h"

@interface CXStudyViewController ()

@end

@implementation CXStudyViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.view sendSubviewToBack:self.navigationController.navigationBar];
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)viewWillDisappear:(BOOL)animated{
    [self.navigationController.view bringSubviewToFront:self.navigationController.navigationBar];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor = CXMainColor;
    
    /**
     如果_isfullScreen = Yes，这个方法就不好使。
     
     设置整体内容的frame,包含（标题滚动视图和内容滚动视图）
     */
    [self setUpContentViewFrame:^(UIView *contentView) {
        contentView.frame = CGRectMake(0, 20, CXScreenWidth, CXScreenHeight - CXStatusBarHeight);
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
    
    //课程
    CourseViewController  *vc1 = [CourseViewController controller];
    vc1.title = @"课程";
    [self addChildViewController:vc1];
    
    //训练
    ExerciseViewController *vc2 = [ExerciseViewController controller];
    vc2.title = @"练习";
    [self addChildViewController:vc2];
    
    
    
    
    
}
@end
