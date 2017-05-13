//
//  AppUtil.h
//  xbsz
// 和App相关的一些工具类
//  Created by lotus on 2017/5/13.
//  Copyright © 2017年 lotus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppUtil : NSObject

// 是否在时间节点之后  根据上架前后改变某些功能 如好评  友情赞赏
+ (BOOL)isAfterTimeNode;

@end
