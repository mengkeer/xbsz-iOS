//
//  CXBaseDisplayViewController.m
//  xbsz
//
//  Created by lotus on 2016/12/30.
//  Copyright © 2016年 lotus. All rights reserved.
//

#import "CXBaseDisplayViewController.h"

@interface CXBaseDisplayViewController ()

@end

@implementation CXBaseDisplayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *topBackView = [[UIView alloc ]initWithFrame:CGRectMake(0, 0, CXScreenWidth, CXTopCornerRadius)];
    topBackView.backgroundColor = CXMainColor;
    
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CXScreenWidth,CXScreenHeight-CXTabbarHeight-CXStatusBarHeight-CXDisplayTitleHeight)];
    contentView.backgroundColor = CXWhiteColor;
    
    
    
    [self.view addSubview:topBackView];
    [self.view addSubview:contentView];
    
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, CXScreenWidth, contentView.height) byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(CXTopCornerRadius, CXTopCornerRadius)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = CGRectMake(0, 0, CXScreenWidth, contentView.height);
    maskLayer.path = maskPath.CGPath;
    contentView.layer.mask = maskLayer;

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
