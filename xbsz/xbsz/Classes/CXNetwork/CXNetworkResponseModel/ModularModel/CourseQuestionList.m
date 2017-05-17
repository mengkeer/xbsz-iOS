//
//  CourseQuestionList.m
//  xbsz
//
//  Created by lotus on 2017/5/16.
//  Copyright © 2017年 lotus. All rights reserved.
//

#import "CourseQuestionList.h"
#import "CourseQuestion.h"

@implementation CourseQuestionList

+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{
             @"questions":CourseQuestion.class
    };
}

@end
