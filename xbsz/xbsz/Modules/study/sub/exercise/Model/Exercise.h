//
//  Exercise.h
//  xbsz
//
//  Created by lotus on 18/03/2017.
//  Copyright © 2017 lotus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CXUser.h"

@interface Exercise : NSObject

@property (nonatomic, copy) NSString *exerciseID;

@property (nonatomic, copy) NSString *version;      //题库版本   特指马克思 毛概 思修等管理员创建的题库  该类型题库需要每学期持续更新

@property (nonatomic, copy) NSString *userID;           //课程创建者的用户id

@property (nonatomic, copy) NSString *icon;              //课程icon图标地址

@property (nonatomic, copy) NSString *title;            //练习题的title

@property (nonatomic, assign) NSInteger status;            //联系开启状态   0 未开启  1 开启  2 关闭

@property (nonatomic, assign) NSUInteger type;              //课程类型   计算机 ？ 纺织 ？ 机械 ？ 大学基础 ？

@property (nonatomic, copy) NSString *startTime;            //练习开启日期

@property (nonatomic, copy) NSString *endTime;             //练习结束日期

@property (nonatomic, copy) NSString *semester;             //学期

@property (nonatomic, assign) NSUInteger total;             //当前参与的学生的人数

@property (nonatomic, copy) NSString *brief;                //练习简介

@property (nonatomic, strong) CXUser *user;                     //练习创建者   分admin与教师两种类型

@end
