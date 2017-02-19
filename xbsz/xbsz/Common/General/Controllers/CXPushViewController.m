//
//  CXPushViewController.m
//  xbsz
//
//  Created by lotus on 2016/12/13.
//  Copyright © 2016年 lotus. All rights reserved.
//

#import "CXPushViewController.h"

@interface CXPushViewController ()

@property (nonatomic,strong) UIButton *backButton;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, assign) BOOL cusNavBarHidden;

@property (nonatomic,strong) UIView *topBgView;


@end

@implementation CXPushViewController

- (instancetype)init{
    self = [super init];
    if (self) {
        [self setHidesBottomBarWhenPushed:YES];
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initCustomNavBar];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.view bringSubviewToFront:self.customNavBarView];
}


- (void)initCustomNavBar {
    self.customNavBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CXScreenWidth, 64)];
    self.customNavBarView.backgroundColor = CXMainColor;
    [self.view addSubview:self.customNavBarView];
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(75, 20, CXScreenWidth-150, 44)];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font = CXSystemBoldFont(16);
    self.titleLabel.textColor = CXWhiteColor;
    [self.customNavBarView addSubview:self.titleLabel];
    [self.titleLabel setText:self.title];
    
    self.backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.backButton.frame = CGRectMake(0, 20, 40, 44);
    [self.backButton setImage:[UIImage imageNamed:@"common_back_white"] forState:UIControlStateNormal];
     [self.backButton setImage:[UIImage imageNamed:@"common_back_white"] forState:UIControlStateHighlighted];
    [self.backButton addTarget:self action:@selector(popFromCurrentViewController) forControlEvents:UIControlEventTouchUpInside];
    [self.customNavBarView addSubview:self.backButton];
    
    
    
    _topBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, CXScreenWidth,CXTopCornerRadius)];
    _topBgView.backgroundColor = CXMainColor;
    [self.view addSubview:_topBgView];
    
    _contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, CXScreenWidth, CXScreenHeight-64)];
    _contentView.backgroundColor = CXBackGroundColor;
    [self.view addSubview:_contentView];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, CXScreenWidth, _contentView.height) byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(CXTopCornerRadius, CXTopCornerRadius)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = CGRectMake(0, 0, CXScreenWidth, _contentView.height);
    maskLayer.path = maskPath.CGPath;
    _contentView.layer.mask = maskLayer;
    
}

- (void)popFromCurrentViewController
{
    [self.navigationController popViewControllerAnimated:YES];//回退到上一个页面；
}



- (void)setTitle:(NSString *)title{
    //    [super setTitle:title];
    self.titleLabel.text = title;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (float)getStartOriginY
{
    return self.cusNavBarHidden?0.0f:64.f; // navigationBar ＋ statusBar
}

- (float)getContentViewHeight
{
    return self.cusNavBarHidden?CXScreenHeight:(CXScreenHeight - 64.f);
}

- (void)setCustomNavBarHidden:(BOOL)hidden {
    self.cusNavBarHidden = hidden;
    self.customNavBarView.hidden = hidden;
}

- (void)setShowTopRadius:(BOOL)showTopRadius{
    if(showTopRadius == NO){
        [_topBgView removeFromSuperview];
        [_contentView removeFromSuperview];
    }
}


@end
