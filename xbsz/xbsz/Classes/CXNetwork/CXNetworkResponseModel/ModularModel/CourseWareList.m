//
//  CourseWareList.m
//  xbsz
//
//  Created by lotus on 2017/5/12.
//  Copyright © 2017年 lotus. All rights reserved.
//

#import "CourseWareList.h"

@implementation CourseWareList

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"courseWare":@"courseware"};
}

+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{
             @"courseWare":CourseWare.class
             };
}

@end
