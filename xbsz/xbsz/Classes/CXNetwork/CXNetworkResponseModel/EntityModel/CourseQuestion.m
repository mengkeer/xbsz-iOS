//
//  CourseQuestion.m
//  xbsz
//
//  Created by lotus on 2017/5/16.
//  Copyright © 2017年 lotus. All rights reserved.
//

#import "CourseQuestion.h"

@implementation CourseQuestion

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"queID":@"queId",@"title":@"question",@"options":@"choices"};
}


@end
