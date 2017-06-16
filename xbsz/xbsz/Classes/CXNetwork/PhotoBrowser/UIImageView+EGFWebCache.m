//
//  UIImageView+EGFWebCache.m
//  EGameForum
//
//  Created by huangd on 16/11/30.
//  Copyright © 2016年 huangd. All rights reserved.
//

#import "UIImageView+EGFWebCache.h"
#import "UIImageView+WebCache.h"

@implementation UIImageView (EGFWebCache)

- (void)egf_setImageWithURL:(NSURL *)url {
    [self egf_setImageWithURL:url placeholderImage:nil options:EGFWebImageRetryFailed progress:nil completed:nil];
}

- (void)egf_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder {
    [self egf_setImageWithURL:url placeholderImage:placeholder options:EGFWebImageRetryFailed progress:nil completed:nil];
}

- (void)egf_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(EGFWebImageOptions)options {
    [self egf_setImageWithURL:url placeholderImage:placeholder options:options progress:nil completed:nil];
}

- (void)egf_setImageWithURL:(NSURL *)url completed:(EGFWebImageCompletionBlock)completedBlock {
    [self egf_setImageWithURL:url placeholderImage:nil options:EGFWebImageRetryFailed progress:nil completed:completedBlock];
}

- (void)egf_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder completed:(EGFWebImageCompletionBlock)completedBlock {
    [self egf_setImageWithURL:url placeholderImage:placeholder options:EGFWebImageRetryFailed progress:nil completed:completedBlock];
}

- (void)egf_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(EGFWebImageOptions)options completed:(EGFWebImageCompletionBlock)completedBlock {
    [self egf_setImageWithURL:url placeholderImage:placeholder options:options progress:nil completed:completedBlock];
}

- (void)egf_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(EGFWebImageOptions)options progress:(EGFWebImageDownloaderProgressBlock)progressBlock completed:(EGFWebImageCompletionBlock)completedBlock {
    [self sd_setImageWithURL:url placeholderImage:placeholder options:(SDWebImageOptions)options progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        if (progressBlock) {
            progressBlock(receivedSize, expectedSize);
        }
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (completedBlock) {
            completedBlock(image, error, (EGFImageCacheType)cacheType, imageURL);
        }
    }];
}

@end
