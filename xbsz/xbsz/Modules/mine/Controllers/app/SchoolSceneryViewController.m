//
//  SchoolSceneryViewController.m
//  xbsz
//
//  Created by 陈鑫 on 17/3/24.
//  Copyright © 2017年 lotus. All rights reserved.
//

#import "SchoolSceneryViewController.h"
#import <WebKit/WKWebView.h>

@interface SchoolSceneryViewController ()


@end

@implementation SchoolSceneryViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"校园风光";
    self.customNavBarView.backgroundColor = CXHexAlphaColor(0xF6F6F6, 0.5);
    
    self.webView.frame = CGRectMake(0, 0, CXScreenWidth, CXScreenHeight);
    if (@available(iOS 11.0, *)) {
        self.webView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
