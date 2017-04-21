//
//  CourseInfoViewController.m
//  xbsz
//
//  Created by lotus on 16/03/2017.
//  Copyright © 2017 lotus. All rights reserved.
//

#import "CourseInfoViewController.h"
#import "CourseViewController.h"
#import "CourseIntroductionViewController.h"
#import "CourseCatalogViewController.h"
#import "CourseCommentViewController.h"

static int _titleHeight  = 40;           //标题导航栏的高度

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
        contentView.frame = CGRectMake(0, 0, CXScreenWidth, CXScreenHeight-CXNavigationBarHeight);
        contentView.backgroundColor = CXWhiteColor;
    }];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = CXLineColor;
    [self.view addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(1/CXMainScale);
        make.bottom.mas_equalTo(self.view.mas_top).mas_offset(_titleHeight);
    }];
    
    // 添加所有子控制器
    [self setUpAllViewController];
    
    [self setUpTitleEffect:^(UIColor *__autoreleasing *titleScrollViewColor, UIColor *__autoreleasing *norColor, UIColor *__autoreleasing *selColor, UIFont *__autoreleasing *titleFont, CGFloat *titleHeight, CGFloat *titleWidth){
        *titleScrollViewColor = CXWhiteColor;
        *norColor = CXBlackColor;
        *selColor = CXHexColor(0x43CD80);
        *titleWidth = CXScreenWidth/3;
        *titleFont = CXSystemFont(15);
        *titleHeight = _titleHeight;
    }];
    
    // 标题渐变
    // *推荐方式(设置标题渐变)
    [self setUpTitleGradient:^(YZTitleColorGradientStyle *titleColorGradientStyle, UIColor *__autoreleasing *norColor, UIColor *__autoreleasing *selColor) {
        //        titleColorGradientStyle = YZTitleColorGradientStyleFill;
    }];
    
    [self setUpUnderLineEffect:^(BOOL *isUnderLineDelayScroll, CGFloat *underLineH, UIColor *__autoreleasing *underLineColor,BOOL *isUnderLineEqualTitleWidth) {
        
        *underLineColor = CXHexColor(0x43CD80);
        *isUnderLineEqualTitleWidth = NO;
        *underLineH = 2;
    }];
    
    self.selectIndex = 0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Private
// 添加所有子控制器
- (void)setUpAllViewController{
    
    CourseIntroductionViewController  *vc1 = [CourseIntroductionViewController controller];
    vc1.title = @"介绍";
    vc1.course = _course;
    vc1.baseDelegate = _delegate;
    [self addChildViewController:vc1];
    
    CourseCatalogViewController *vc2 = [CourseCatalogViewController controller];
    vc2.title = @"目录";
    vc2.course = _course;
    vc2.baseDelegate = _delegate;
    [self addChildViewController:vc2];
    
    CourseCommentViewController *vc3 = [CourseCommentViewController controller];
    vc3.title = @"评价";
    vc3.course = _course;
    vc3.baseDelegate = _delegate;
    [self addChildViewController:vc3];
}

@end
