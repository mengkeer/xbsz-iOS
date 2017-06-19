//
//  UIImageView+EGFWebCache.h
//  EGameForum
//
//  Created by huangd on 16/11/30.
//  Copyright © 2016年 huangd. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_OPTIONS(NSUInteger, EGFWebImageOptions) {
    EGFWebImageRetryFailed = 1 << 0,
    EGFWebImageLowPriority = 1 << 1,
    EGFWebImageCacheMemoryOnly = 1 << 2,
    EGFWebImageProgressiveDownload = 1 << 3,
    EGFWebImageRefreshCached = 1 << 4,
    EGFWebImageContinueInBackground = 1 << 5,
    EGFWebImageHandleCookies = 1 << 6,
    EGFWebImageAllowInvalidSSLCertificates = 1 << 7,
    EGFWebImageHighPriority = 1 << 8,
    EGFWebImageDelayPlaceholder = 1 << 9,
    EGFWebImageTransformAnimatedImage = 1 << 10,
    EGFWebImageAvoidAutoSetImage = 1 << 11
};

typedef NS_ENUM(NSInteger, EGFImageCacheType) {
    EGFImageCacheTypeNone,
    EGFImageCacheTypeDisk,
    EGFImageCacheTypeMemory
};

typedef void(^EGFWebImageDownloaderProgressBlock)(NSInteger receivedSize, NSInteger expectedSize);

typedef void(^EGFWebImageCompletionBlock)(UIImage *image, NSError *error, YYWebImageFromType cacheType, NSURL *imageURL);

@interface UIImageView (EGFWebCache)

- (void)egf_setImageWithURL:(NSURL *)url;
- (void)egf_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder;
- (void)egf_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(YYWebImageOptions)options;
- (void)egf_setImageWithURL:(NSURL *)url completed:(EGFWebImageCompletionBlock)completedBlock;
- (void)egf_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder completed:(EGFWebImageCompletionBlock)completedBlock;
- (void)egf_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(YYWebImageOptions)options completed:(EGFWebImageCompletionBlock)completedBlock;
- (void)egf_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(YYWebImageOptions)options progress:(EGFWebImageDownloaderProgressBlock)progressBlock completed:(EGFWebImageCompletionBlock)completedBlock;

@end
