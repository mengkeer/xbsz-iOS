//
//  Homework.h
//  xbsz
//
//  Created by lotus on 2017/5/17.
//  Copyright © 2017年 lotus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Homework.h"
#import "Course.h"

@interface Homework : NSObject

@property (nonatomic, copy) NSString *exerciseID;

@property (nonatomic, copy) NSString *courseID;


@property (nonatomic, copy) NSString *title;            //课程的title

@property (nonatomic, assign) NSInteger status;            //课程状态   未开启  未到时间  已经开始  人数已满   已经结束

@property (nonatomic, assign) NSUInteger max;             //最大学生人数

@property (nonatomic, strong) NSDate *startTime;            //练习开启日期

@property (nonatomic, strong) NSDate *endTime;             //练习结束日期

@property (nonatomic, assign) NSInteger num;             //题目总数

@property (nonatomic, copy) NSString *brief;            //练习简介  保留字段

@property (nonatomic, strong) Course *course;

@end
