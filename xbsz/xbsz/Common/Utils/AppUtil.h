//
//  AppUtil.h
//  xbsz
// 和App相关的一些工具类
//  Created by lotus on 2017/5/13.
//  Copyright © 2017年 lotus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppUtil : NSObject

// 是否在广告时间节点之后  设置安装一天后显示广告
+ (BOOL)isAfterAdTimeNode;
// 是否在App上架时间节点之后
+ (BOOL)isAfterAppUpperTimeNode;

+ (BOOL)showAD;

+ (NSInteger)getCacheSize;

+ (void) cleanCache;

@end
