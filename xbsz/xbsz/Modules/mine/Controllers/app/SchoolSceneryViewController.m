//
//  SchoolSceneryViewController.m
//  xbsz
//
//  Created by 陈鑫 on 17/3/24.
//  Copyright © 2017年 lotus. All rights reserved.
//

#import "SchoolSceneryViewController.h"

@interface SchoolSceneryViewController ()

@property (nonatomic, strong) UIWebView *webView;

@end

@implementation SchoolSceneryViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"校园风光";
    self.customNavBarView.backgroundColor = CXHexAlphaColor(0xF6F6F6, 0.5);
    
    
    
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, CXScreenWidth, CXScreenHeight)];
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:URLSchoolScenery]];
    [self.view addSubview: self.webView];
    [self.webView loadRequest:request];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
