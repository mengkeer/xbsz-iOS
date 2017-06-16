//
//  CourseQuestionList.h
//  xbsz
//
//  Created by lotus on 2017/5/16.
//  Copyright © 2017年 lotus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Homework.h"

@interface CourseQuestionList : NSObject

@property (nonatomic, strong) NSMutableArray *questions;

@property (nonatomic, strong) Homework *homework;

@end
