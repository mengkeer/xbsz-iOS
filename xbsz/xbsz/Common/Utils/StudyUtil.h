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

+ (ExerciseType)indexToExerciseType:(NSInteger)index;
//根据题库类型转换为对应的table name
+ (NSString *)exerciseTypeToExerciseName:(ExerciseType )type;
//获取题库题目总数
+ (NSInteger)getQuestionsTotalByType:(ExerciseType )type;
//获取章节索引
+ (NSArray *)getChapterIndex:(ExerciseType)type;

//获取每章的题目数构成的数组
+ (NSArray *)getChapterNums:(ExerciseType)type;

//根据type 是否单选 章节数获取具体的章节题目数
+ (NSArray *)getQuestions:(ExerciseType)type isSingle:(BOOL)isSingle chapterIndex:(NSInteger)index;

//根据option字符窜分离出来 各个选项
+ (NSArray *)getOptionsByString:(NSString *)optionStr type:(NSInteger)type;
//获取纯净的题干内容  去除前面的题号索引
+ (NSString *)getPureTitle:(NSString *)title;

//根据关键字获取查询结果 最多显示前20条数据
+ (NSMutableArray *)getSearchResultsBySearchText:(NSString *)text type:(ExerciseType)type;

+ (void)closeDB;

@end
