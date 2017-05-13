//
//  NSString+CXAdd.h
//  xbsz
//
//  Created by 陈鑫 on 17/3/7.
//  Copyright © 2017年 lotus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (CXAdd)

- (NSString *)convertToLocalTime;

//JSON数组类型的字符串 转化为  数组
- (id)JSONValue;

+ (NSString *)getAvatarUrl:(NSString *)imagename;

@end
