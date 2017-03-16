//
//  CourseInfoViewController.m
//  xbsz
//
//  Created by lotus on 16/03/2017.
//  Copyright © 2017 lotus. All rights reserved.
//

#import "CourseInfoViewController.h"
#import "CourseViewController.h"
#import "ExerciseViewController.h"

@interface CourseInfoViewController ()

@end

@implementation CourseInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor = CXWhiteColor;
    
    /**
     如果_isfullScreen = Yes，这个方法就不好使。
     
     设置整体内容的frame,包含（标题滚动视图和内容滚动视图）
     */
    [self setUpContentViewFrame:^(UIView *contentView) {
        contentView.frame = CGRectMake(0, 0, CXScreenWidth, CXScreenHeight - CXStatusBarHeight - CXNavigationBarHeight -200);
        contentView.backgroundColor = CXWhiteColor;
    }];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = CXLineColor;
    [self.view addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(1/CXMainScale);
        make.bottom.mas_equalTo(self.view.mas_top).mas_offset(CXDisplayTitleHeight);
    }];
    
    // 添加所有子控制器
    [self setUpAllViewController];
    
    [self setUpTitleEffect:^(UIColor *__autoreleasing *titleScrollViewColor, UIColor *__autoreleasing *norColor, UIColor *__autoreleasing *selColor, UIFont *__autoreleasing *titleFont, CGFloat *titleHeight, CGFloat *titleWidth){
        *titleScrollViewColor = CXWhiteColor;
        *norColor = CXBlackColor;
        *selColor = CXGreenColor;
        *titleWidth = 50;
        *titleFont = CXSystemFont(14);
        *titleHeight = CXDisplayTitleHeight;
    }];
    
    // 标题渐变
    // *推荐方式(设置标题渐变)
    [self setUpTitleGradient:^(YZTitleColorGradientStyle *titleColorGradientStyle, UIColor *__autoreleasing *norColor, UIColor *__autoreleasing *selColor) {
        //        titleColorGradientStyle = YZTitleColorGradientStyleFill;
    }];
    
    [self setUpUnderLineEffect:^(BOOL *isUnderLineDelayScroll, CGFloat *underLineH, UIColor *__autoreleasing *underLineColor,BOOL *isUnderLineEqualTitleWidth) {
        
//        *isUnderLineDelayScroll = YES;      //此时修改起1/2
        *underLineColor = CXGreenColor;
//        *isUnderLineEqualTitleWidth = YES;
        *underLineH = 1;
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
    ExerciseViewController  *vc1 = [ExerciseViewController controller];
    vc1.title = @"介绍";
    [self addChildViewController:vc1];
    
    //训练
    ExerciseViewController *vc2 = [ExerciseViewController controller];
    vc2.title = @"目录";
    [self addChildViewController:vc2];
    
    //训练
    ExerciseViewController *vc3 = [ExerciseViewController controller];
    vc3.title = @"评价";
    [self addChildViewController:vc3];
    
}

@end
