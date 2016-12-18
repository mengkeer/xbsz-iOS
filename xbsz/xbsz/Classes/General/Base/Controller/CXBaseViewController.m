//
//  CXBaseViewController.m
//  xbsz
//
//  Created by lotus on 2016/12/11.
//  Copyright © 2016年 lotus. All rights reserved.
//

#import "CXBaseViewController.h"

@interface CXBaseViewController ()

@end

@implementation CXBaseViewController

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.navigationController.view sendSubviewToBack:self.navigationController.navigationBar];
    //    self.navigationController.navigationBar.hidden = YES;
    self.navigationController.navigationBar.translucent = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    //    [self.navigationController.navigationBar setHidden:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:CXBackGroundColor];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}





@end
