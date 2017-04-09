//
//  CourseList.m
//  xbsz
//
//  Created by 陈鑫 on 17/3/13.
//  Copyright © 2017年 lotus. All rights reserved.
//

#import "CourseList.h"

@implementation CourseList

+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{
             @"courses":Course.class
             };
}


@end
