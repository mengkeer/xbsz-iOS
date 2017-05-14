//
//  CXBaseDisplayViewController.m
//  xbsz
//
//  Created by lotus on 2016/12/30.
//  Copyright © 2016年 lotus. All rights reserved.
//

#import "CXBaseDisplayViewController.h"

@interface CXBaseDisplayViewController ()

@property (nonatomic, strong) UIView *topBackView;

@end

@implementation CXBaseDisplayViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    _topBackView.backgroundColor = [CXUserDefaults instance].mainColor;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _topBackView = [[UIView alloc ]initWithFrame:CGRectMake(0, 0, CXScreenWidth, CXTopCornerRadius)];
    
    _contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CXScreenWidth,CXScreenHeight-CXStatusBarHeight-CXDisplayTitleHeight)];
    _contentView.backgroundColor = CXWhiteColor;
    

    [self.view addSubview:_topBackView];
    [self.view addSubview:_contentView];
    
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, CXScreenWidth, _contentView.height) byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(CXTopCornerRadius, CXTopCornerRadius)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = CGRectMake(0, 0, CXScreenWidth, _contentView.height);
    maskLayer.path = maskPath.CGPath;
    _contentView.layer.mask = maskLayer;

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
