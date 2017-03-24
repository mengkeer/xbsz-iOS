//
//  CommonAPPViewController.m
//  xbsz
//
//  Created by 陈鑫 on 17/3/24.
//  Copyright © 2017年 lotus. All rights reserved.
//

#import "CommonAPPViewController.h"

@interface CommonAPPViewController ()

@property (nonatomic, strong) UIWebView *webView;

@end

@implementation CommonAPPViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.customNavBarView.backgroundColor = CXBackGroundColor;
    
    
    
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, CXScreenWidth, CXScreenHeight-64)];
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:_url]];
    [self.view addSubview: self.webView];
    [self.webView loadRequest:request];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
