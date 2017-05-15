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

@property (nonatomic, strong) UIView *topLineView;

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
    self.backButton.frame = CGRectMake(3, 20, 44, 44);
    self.backButton.imageEdgeInsets = UIEdgeInsetsMake(12, 12, 12, 12);
    [self.backButton setImage:[UIImage imageNamed:@"back_arrow_black"] forState:UIControlStateNormal];
//     [self.backButton setImage:[UIImage imageNamed:@"common_back_white"] forState:UIControlStateHighlighted];
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
    
    [self autoTheme];
}

- (void)showTopLineView{
    NSInteger type = [CXUserDefaults instance].themeType;
    if(type == 2){
        _topLineView.hidden = NO;
    }else{
        _topLineView.hidden = YES;
    }
}

- (void)autoTheme{
    NSInteger type = [CXUserDefaults instance].themeType;
    self.titleLabel.textColor = [CXUserDefaults instance].textColor;
    self.customNavBarView.backgroundColor = [CXUserDefaults instance].mainColor;
    _topBgView.backgroundColor = [CXUserDefaults instance].mainColor;
    if(type == 2){
        [self.backButton setImage:[UIImage imageNamed:@"back_arrow_black"] forState:UIControlStateNormal];
    }else{
        [self.backButton setImage:[UIImage imageNamed:@"back_arrow_white"] forState:UIControlStateNormal];
    }
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
