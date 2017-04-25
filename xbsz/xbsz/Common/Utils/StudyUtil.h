//
//  StudyUtil.h
//  xbsz
//
//  Created by lotus on 2017/4/25.
//  Copyright © 2017年 lotus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ExerciseMode.h"

@interface StudyUtil : NSObject

+ (instancetype)instance;

//根据题库类型转换为对应的table name
+ (NSString *)exerciseTypeToExerciseName:(ExerciseType )type;
//获取题库题目总数
+ (NSInteger)getQuestionsTotalByType:(ExerciseType )type;
//获取章节索引
+ (NSArray *)getChapterIndex:(ExerciseType)type;
//获取每章的题目数
+ (NSArray *)getChapterNums:(ExerciseType)type;

+ (void)closeDB;

@end
