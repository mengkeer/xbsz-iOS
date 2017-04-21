//
//  CourseCommentList.m
//  xbsz
//
//  Created by lotus on 2017/4/21.
//  Copyright © 2017年 lotus. All rights reserved.
//

#import "CourseCommentList.h"
#import "CourseComment.h"

@implementation CourseCommentList

+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{
             @"comments":CourseComment.class
    };
}


@end
