//
//  CommonAPPViewController.m
//  xbsz
//
//  Created by 陈鑫 on 17/3/24.
//  Copyright © 2017年 lotus. All rights reserved.
//

#import "CommonAPPViewController.h"
#import <WebKit/WKWebView.h>

@interface CommonAPPViewController ()

@property (nonatomic, strong) WKWebView *webView;

@end

@implementation CommonAPPViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.customNavBarView.backgroundColor = CXBackGroundColor;
    
    WKWebView *webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, CXScreenWidth, CXScreenHeight)];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_url]]];
    [self.view addSubview:webView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
