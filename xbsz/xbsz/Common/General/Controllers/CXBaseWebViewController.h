//
//  CXBaseWebViewController.h
//  xbsz
//
//  Created by 陈鑫 on 17/3/24.
//  Copyright © 2017年 lotus. All rights reserved.
//

#import "CXWhitePushViewController.h"
#import <WebKit/WKWebView.h>
#import <WebKit/WKNavigationDelegate.h>
#import <WebKit/WKFrameInfo.h>
#import <WebKit/WKUIDelegate.h>

@interface CXBaseWebViewController : CXWhitePushViewController

@property (nonatomic, assign) BOOL hideShareBtn;

@property (nonatomic, strong) WKWebView *webView;

@property (nonatomic, copy) NSString *url;

@end
