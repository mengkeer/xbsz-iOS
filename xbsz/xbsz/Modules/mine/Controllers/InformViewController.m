//
//  InformViewController.m
//  xbsz
//
//  Created by lotus on 2016/12/18.
//  Copyright © 2016年 lotus. All rights reserved.
//

#import "InformViewController.h"

@interface InformViewController ()

@property (nonatomic,strong) UIButton *btnInform;
@property (nonatomic,strong) UIButton *btnLetter;

@end

@implementation InformViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.view sendSubviewToBack:self.customNavBarView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = CXBackGroundColor;
    
    self.title = @"";
    
    CGSize rect= [@"通知" boundingRectWithSize:CGSizeMake(100, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16.0]} context:nil].size;
    
    CGFloat labelWidth = rect.width;
    
    CGFloat startX = (CXScreenWidth-2*labelWidth - 20)/2;
    
    _btnInform = [UIButton buttonWithType:UIButtonTypeCustom];
    _btnInform.titleLabel.font = CXSystemFont(16);
    _btnInform.tag = 1;
    _btnInform.frame = CGRectMake(startX , 34, labelWidth, 16);
    [_btnInform setTitle:@"通知" forState:UIControlStateNormal];
    [_btnInform setTitleColor:CXHexAlphaColor(0xFFFFFF, 0.7) forState:UIControlStateNormal];
    [_btnInform setTitleColor:CXWhiteColor forState:UIControlStateSelected];
    [_btnInform addTarget:self action:@selector(clickChange:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btnInform];
    
    [_btnInform setSelected:YES];
    
    
    
    _btnLetter = [UIButton buttonWithType:UIButtonTypeCustom];
    _btnLetter.titleLabel.font = CXSystemFont(16);
    _btnLetter.tag = 2;
    _btnLetter.frame = CGRectMake(startX+20+labelWidth, 34, labelWidth, 16);
    [_btnLetter setTitle:@"私信" forState:UIControlStateNormal];
    [_btnLetter setTitleColor:CXWhiteColor forState:UIControlStateSelected];
    [_btnLetter addTarget:self action:@selector(clickChange:) forControlEvents:UIControlEventTouchUpInside];
    [_btnLetter setTitleColor:CXHexAlphaColor(0xFFFFFF, 0.7) forState:UIControlStateNormal];
    [self.view addSubview:_btnLetter];
    
    
    
    
    
    
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - getter/setter



#pragma mark - privateb method

- (void)clickChange:(UIButton *)btn{
    if(btn.isSelected)  return;
    if(btn.tag == 1){
        [_btnInform setSelected:YES];
        [_btnLetter setSelected:NO];
    }else{
        [_btnLetter setSelected:YES];
        [_btnInform setSelected:NO];
    }
}


@end
