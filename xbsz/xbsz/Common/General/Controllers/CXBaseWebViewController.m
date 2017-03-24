//
//  CXBaseWebViewController.m
//  xbsz
//
//  Created by 陈鑫 on 17/3/24.
//  Copyright © 2017年 lotus. All rights reserved.
//

#import "CXBaseWebViewController.h"
#import "NJKWebViewProgress.h"
#import "NJKWebViewProgressView.h"
#import "ShareToolBarView.h"
#import "ToastView.h"

@interface CXBaseWebViewController ()<WKNavigationDelegate,WKUIDelegate>

@property (nonatomic, strong) NJKWebViewProgressView *progressView;

@property (nonatomic, strong) UIButton *closeBtn;
@property (nonatomic, strong) UIButton *shareBtn;

@end

@implementation CXBaseWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.customNavBarView.backgroundColor = CXBackGroundColor;
    
    [self.customNavBarView addSubview:self.closeBtn];
    
     [self.customNavBarView addSubview:self.shareBtn];
    
    CGFloat progressBarHeight = 2.f;
    CGRect navigationBarBounds = self.customNavBarView.bounds;
    CGRect barFrame = CGRectMake(0, navigationBarBounds.size.height - progressBarHeight, navigationBarBounds.size.width, progressBarHeight);
    _progressView = [[NJKWebViewProgressView alloc] initWithFrame:barFrame];
    [_progressView setProgress:0 animated:YES];
    _progressView.hidden = YES;
    _progressView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    [self.customNavBarView addSubview:_progressView];

    _webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, [self getStartOriginY], CXScreenWidth, [self getContentViewHeight])];
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:_url]];
    [_webView loadRequest:request];
    _webView.navigationDelegate = self;
    _webView.UIDelegate = self;
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
    if ([self.webView canGoBack]) {
        [self.webView goBack];
    }else{
        [super popFromCurrentViewController];
    }
}

#pragma  mark - getter/setter

- (UIButton *)closeBtn{
    if(!_closeBtn){
        _closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_closeBtn setImage:[UIImage imageNamed:@"blackClose"] forState:UIControlStateNormal];
        _closeBtn.hidden = YES;
        _closeBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        _closeBtn.frame = CGRectMake(30, 20, 44, 44);
        [_closeBtn addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeBtn;
}

- (UIButton *)shareBtn{
    if(!_shareBtn){
        _shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _shareBtn.frame = CGRectMake(CXScreenWidth - 35, 20, 20, 44);
        [_shareBtn setImage:[UIImage imageNamed:@"course_share"] forState:UIControlStateNormal];
        [_shareBtn setImage:[UIImage imageNamed:@"course_share"] forState:UIControlStateHighlighted];
        [_shareBtn addTarget:self action:@selector(showShareBar) forControlEvents:UIControlEventTouchUpInside];
    }
    return _shareBtn;
}



- (void)close{
    [super popFromCurrentViewController];
}

- (void)showShareBar{
    [[ShareToolBarView instance] updateUIWithModel:nil action:^(ShareToolBarActionTyep actionType) {
        [self handleShareAction:actionType];
    }];
    [[ShareToolBarView instance] showInView:self.view.window];
}

- (void)handleShareAction:(ShareToolBarActionTyep) actionType{
    switch (actionType) {
        case ShareToolBarActionTyepPYQ:
            [ToastView showSuccessWithStaus:@"朋友圈分享"];
            break;
        case ShareToolBarActionTyepWechat:
            [ToastView showSuccessWithStaus:@"微信分享"];
            break;
        case ShareToolBarActionTyepQQ:
            [ToastView showSuccessWithStaus:@"QQ分享"];
            break;
        case ShareToolBarActionTyepQzone:
            [ToastView showSuccessWithStaus:@"QQ控件分享"];
            break;
        case ShareToolBarActionTyepWeibo:
            [ToastView showSuccessWithStaus:@"微博分享"];
            break;
        case ShareToolBarActionTyepSystem:
            [ToastView showSuccessWithStaus:@"系统分享"];
            break;
        case ShareToolBarActionTyepCancel:
            [[ShareToolBarView instance] dismissInView:self.view.window];
            break;
        default:
            break;
    }
}

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        CGFloat newProgress = [[change objectForKey:NSKeyValueChangeNewKey] doubleValue];
        CXLog(@"%lf",newProgress);
        if (newProgress == 1) {
            [self.progressView setProgress:newProgress animated:YES];
            // 之后0.3秒延迟隐藏
            __weak typeof(self) weakSelf = self;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.3 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                weakSelf.progressView.hidden = YES;
                [weakSelf.progressView setProgress:0 animated:NO];
            });
            
        }else {
            self.progressView.hidden = NO;
            [self.progressView setProgress:newProgress animated:YES];
        }
    }else{
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

#pragma  mark - WKNavigationDelegate

// 内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    if (self.webView.canGoBack) {
        self.closeBtn.hidden = NO;
    }else{
        self.closeBtn.hidden = YES;
    }
}

#pragma mark - UIDelegate

- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:message?:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:([UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
    }])];
    [self presentViewController:alertController animated:YES completion:nil];
    
}

- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler{
    //    DLOG(@"msg = %@ frmae = %@",message,frame);
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:message?:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:([UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(NO);
    }])];
    [alertController addAction:([UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(YES);
    }])];
    [self presentViewController:alertController animated:YES completion:nil];
}
- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable))completionHandler{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:prompt message:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.text = defaultText;
    }];
    [alertController addAction:([UIAlertAction actionWithTitle:@"完成" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(alertController.textFields[0].text?:@"");
    }])];
    
    [self presentViewController:alertController animated:YES completion:nil];
}


@end
