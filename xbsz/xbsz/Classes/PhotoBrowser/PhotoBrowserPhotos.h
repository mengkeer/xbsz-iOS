//
//  PhotoBrowserPhotos.h
//  SuperM
//
//  Created by hanx on 16/8/29.
//  Copyright © 2016年 hanx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PhotoBrowserPhotos : NSObject
/// 选中照片索引
@property (nonatomic) NSInteger selectedIndex;
/// 照片 url 字符串数组
@property (nonatomic) NSArray<NSString *> *urls;
/// 父视图图像视图数组，便于交互转场
@property (nonatomic) NSArray<UIImageView *> *parentImageViews;
@end
