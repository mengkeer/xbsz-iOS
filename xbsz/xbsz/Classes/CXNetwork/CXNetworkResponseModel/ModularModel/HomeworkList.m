//
//  HomeworkList.m
//  xbsz
//
//  Created by lotus on 2017/5/17.
//  Copyright © 2017年 lotus. All rights reserved.
//

#import "HomeworkList.h"
#import "Homework.h"

@implementation HomeworkList

+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{
             @"homeworks":Homework.class
        };
}

@end
