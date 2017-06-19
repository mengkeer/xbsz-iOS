//
//  UIImageView+EGFWebCache.m
//  EGameForum
//
//  Created by huangd on 16/11/30.
//  Copyright © 2016年 huangd. All rights reserved.
//

#import "UIImageView+EGFWebCache.h"

@implementation UIImageView (EGFWebCache)

- (void)egf_setImageWithURL:(NSURL *)url {
    [self egf_setImageWithURL:url placeholderImage:nil options:YYWebImageOptionIgnoreFailedURL progress:nil completed:nil];
}

- (void)egf_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder {
    [self egf_setImageWithURL:url placeholderImage:placeholder options:YYWebImageOptionIgnoreFailedURL progress:nil completed:nil];
}

- (void)egf_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(YYWebImageOptions)options {
    [self egf_setImageWithURL:url placeholderImage:placeholder options:options progress:nil completed:nil];
}

- (void)egf_setImageWithURL:(NSURL *)url completed:(EGFWebImageCompletionBlock)completedBlock {
    [self egf_setImageWithURL:url placeholderImage:nil options:YYWebImageOptionIgnoreFailedURL progress:nil completed:completedBlock];
}

- (void)egf_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder completed:(EGFWebImageCompletionBlock)completedBlock {
    [self egf_setImageWithURL:url placeholderImage:placeholder options:YYWebImageOptionIgnoreFailedURL progress:nil completed:completedBlock];
}

- (void)egf_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(YYWebImageOptions)options completed:(EGFWebImageCompletionBlock)completedBlock {
    [self egf_setImageWithURL:url placeholderImage:placeholder options:options progress:nil completed:completedBlock];
}

- (void)egf_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(YYWebImageOptions)options progress:(EGFWebImageDownloaderProgressBlock)progressBlock completed:(EGFWebImageCompletionBlock)completedBlock {
    [self yy_setImageWithURL:url placeholder:placeholder options:(YYWebImageOptions)options progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        if (progressBlock) {
            progressBlock(receivedSize, expectedSize);
        }
    } transform:nil completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
        if (completedBlock) {
            completedBlock(image, error, from, url);
        }
    }];
}

@end
