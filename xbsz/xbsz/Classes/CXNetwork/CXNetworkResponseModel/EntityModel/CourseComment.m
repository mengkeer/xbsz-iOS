//
//  CourseComment.m
//  xbsz
//
//  Created by lotus on 2017/4/20.
//  Copyright © 2017年 lotus. All rights reserved.
//

#import "CourseComment.h"

@implementation CourseComment

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"time":@"createdAt",@"avatar":@"userInfo.avatar",@"nickname":@"userInfo.nickname"};
}


@end
