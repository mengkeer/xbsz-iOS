//
//  AttachmentViewController.m
//  xbsz
//
//  Created by lotus on 2017/4/17.
//  Copyright © 2017年 lotus. All rights reserved.
//

#import "AttachmentViewController.h"
#import "NJKWebViewProgressView.h"

//static CGFloat lastY = -0x3f3f3f3f ;

@interface AttachmentViewController ()<WKNavigationDelegate,UIScrollViewDelegate>

@property (nonatomic, strong) WKWebView *webView;

@property (nonatomic, strong) NJKWebViewProgressView *progressView;

@end

@implementation AttachmentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    _path = @"http://www.slotus.cc/word.";
    self.customNavBarView.backgroundColor = CXBackGroundColor;
    
    CGFloat progressBarHeight = 2.f;
    CGRect navigationBarBounds = self.customNavBarView.bounds;
    CGRect barFrame = CGRectMake(0, navigationBarBounds.size.height - progressBarHeight, navigationBarBounds.size.width, progressBarHeight);
    _progressView = [[NJKWebViewProgressView alloc] initWithFrame:barFrame];
    [_progressView setProgress:0 animated:YES];
    _progressView.hidden = YES;
    _progressView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    [self.customNavBarView addSubview:_progressView];
    
 
    
    _webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, 0, CXScreenWidth, CXScreenHeight)];
//    NSMutableURLRequest *request =[NSMutableURLRequest requestWithURL:[NSURL URLWithString:_path]];
    [_webView loadFileURL:[NSURL fileURLWithPath:_path] allowingReadAccessToURL:[NSURL fileURLWithPath:_path]];
    _webView.navigationDelegate = self;
    _webView.scrollView.delegate = self;
    [self.view addSubview:_webView];
    
    [_webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc{
    [_webView removeObserver:self forKeyPath:@"estimatedProgress"];
}

- (void)popFromCurrentViewController{
    [super popFromCurrentViewController];
}


#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        CGFloat newProgress = [[change objectForKey:NSKeyValueChangeNewKey] doubleValue];
        if (newProgress == 1) {
            [self.progressView setProgress:newProgress animated:YES];
            // 之后0.3秒延迟隐藏
            __weak typeof(self) weakSelf = self;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.3 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                weakSelf.progressView.hidden = YES;
                [weakSelf.progressView setProgress:0 animated:YES];
            });
            
        }else {
            self.progressView.hidden = NO;
            [self.progressView setProgress:newProgress animated:YES];
        }
    }else{
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    CGPoint point = scrollView.contentOffset;
//    if(lastY == -0x3f3f3f3f){
//        lastY = point.y;
//        return;
//    }
//    
//    if(point.y > lastY && point.y != 0.f){
//        self.customNavBarView.hidden = YES;
//    }else{
//        self.customNavBarView.hidden = NO;
//    }
//    
//    lastY = point.y;
}

#pragma  mark - WKNavigationDelegate

// 内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
   
}

// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
   
}

// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation {
  
}

@end
