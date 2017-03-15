//
//  Course.h
//  xbsz
//
//  Created by 陈鑫 on 17/3/13.
//  Copyright © 2017年 lotus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Course : NSObject

@property (nonatomic, copy) NSString *courseID;

@property (nonatomic, copy) NSString *userID;           //课程创建者的用户id

@property (nonatomic, copy) NSString *icon;              //课程icon图标地址

@property (nonatomic, copy) NSString *title;            //课程的title

@property (nonatomic, assign) NSInteger status;            //课程状态   未开启  未到时间  已经开始  人数已满   已经结束

@property (nonatomic, assign) NSUInteger type;              //课程类型   计算机 ？ 纺织 ？ 机械 ？ 大学基础 ？

@property (nonatomic, assign) NSUInteger max;             //最大学生人数

@property (nonatomic, copy) NSString *startTime;            //课程开启日期

@property (nonatomic, copy) NSString *endTime;             //课程结束日期

@property (nonatomic, copy) NSString *semester;             //学期

@property (nonatomic, copy) NSString *image;




@end
