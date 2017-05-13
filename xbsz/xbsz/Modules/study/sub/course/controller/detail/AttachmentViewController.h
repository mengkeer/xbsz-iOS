//
//  AttachmentViewController.h
//  xbsz
//
//  Created by lotus on 2017/4/17.
//  Copyright © 2017年 lotus. All rights reserved.
//

//显示附件  支持word Excel ppt  PDF  txt等文件  zip等压缩文件 音频 视频不支持

#import <Foundation/Foundation.h>
#import "CXWhitePushViewController.h"
#import <WebKit/WKWebView.h>
#import <WebKit/WKNavigationDelegate.h>
#import <WebKit/WKFrameInfo.h>
#import <WebKit/WKUIDelegate.h>


@interface AttachmentViewController : CXWhitePushViewController

@property (nonatomic, copy) NSString *path;

@end
