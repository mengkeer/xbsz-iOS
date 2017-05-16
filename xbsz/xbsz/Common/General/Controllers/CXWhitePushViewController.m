//
//  CXWhitePushViewController.m
//  xbsz
//
//  Created by lotus on 14/03/2017.
//  Copyright © 2017 lotus. All rights reserved.
//

#import "CXWhitePushViewController.h"

@interface CXWhitePushViewController ()

@property (nonatomic,strong) UIButton *backButton;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, assign) BOOL cusNavBarHidden;

@property (nonatomic, strong) UIView *topLineView;

@end

@implementation CXWhitePushViewController

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
    self.customNavBarView.backgroundColor = CXWhiteColor;
    [self.view addSubview:self.customNavBarView];
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(75, 20, CXScreenWidth-150, 44)];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font = CXSystemFont(16);
    self.titleLabel.textColor = CXBlackColor;
    [self.customNavBarView addSubview:self.titleLabel];
    [self.titleLabel setText:self.title];
    
    self.backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.backButton.frame = CGRectMake(3, 20, 44, 44);
    [self.backButton setImageEdgeInsets:UIEdgeInsetsMake(0, 12, 0, 12)];
    [self.backButton setImage:[UIImage imageNamed:@"common_back_black"] forState:UIControlStateNormal];
    [self.backButton setImage:[UIImage imageNamed:@"common_back_black"] forState:UIControlStateHighlighted];
    [self.backButton addTarget:self action:@selector(popFromCurrentViewController) forControlEvents:UIControlEventTouchUpInside];
    [self.customNavBarView addSubview:self.backButton];
    
    
    _topLineView = [[UIView alloc] init];
    _topLineView.backgroundColor = CXLineColor;
    [self.customNavBarView addSubview:_topLineView];
    [_topLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.customNavBarView.mas_bottom);
        make.height.mas_equalTo(1/CXMainScale);
    }];
    [_topLineView setHidden:YES];
    
    
}

- (void)showTopLineView{
    _topLineView.hidden = NO;
}

- (void)popFromCurrentViewController
{
    [self.navigationController popViewControllerAnimated:YES];//回退到上一个页面；
}



- (void)setTitle:(NSString *)title{
    [super setTitle:title];
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


@end
