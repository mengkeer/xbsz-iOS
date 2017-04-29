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

#pragma mark - 所有模式公共接口
+ (ExerciseType)indexToExerciseType:(NSInteger)index;
//根据题库类型转换为对应的table name
+ (NSString *)exerciseTypeToExerciseName:(ExerciseType )type;
//获取题库题目总数
+ (NSInteger)getQuestionsTotalByType:(ExerciseType )type;

//根据是否是错题获取题目总数
+ (NSInteger)getQuestionsTotalByType:(ExerciseType )type isWrong:(BOOL)isWrong;
//根据是否是单选获取题目总数
+ (NSInteger)getQuestionsTotalByType:(ExerciseType )type isSingle:(BOOL)isSingle;

//根据单选多选 是否是错题获取题目总数
+ (NSInteger)getQuestionsTotalByType:(ExerciseType )type isSingle:(BOOL)isSingle isWrong:(BOOL)isWrong;


//获取章节索引
+ (NSArray *)getChapterIndex:(ExerciseType)type isSingle:(BOOL)isSingle;

+ (NSArray *)getChapterIndex:(ExerciseType)type isSingle:(BOOL)isSingle isWrong:(BOOL)isWrong;

//获取每章的题目数构成的数组
+ (NSArray *)getChapterNums:(ExerciseType)type isSingle:(BOOL)isSingle;

+ (NSArray *)getChapterNums:(ExerciseType)type isSingle:(BOOL)isSingle isWrong:(BOOL)isWrong;

//根据type 是否单选 章节数获取具体的章节题目数
+ (NSArray *)getQuestions:(ExerciseType)type isSingle:(BOOL)isSingle chapterIndex:(NSInteger)index;

+ (NSArray *)getQuestions:(ExerciseType)type isSingle:(BOOL)isSingle isWrong:(NSInteger)isWrong chapterIndex:(NSInteger)index;

//根据option字符窜分离出来 各个选项
+ (NSArray *)getOptionsByString:(NSString *)optionStr type:(NSInteger)type;
//获取纯净的题干内容  去除前面的题号索引
+ (NSString *)getPureTitle:(NSString *)title;

+ (NSString *)indexConvertToSymbol:(NSInteger)index;

#pragma mark - 搜索模式接口
//根据关键字获取查询结果 最多显示前20条数据
+ (NSMutableArray *)getSearchResultsBySearchText:(NSString *)text type:(ExerciseType)type;

+ (BOOL)isSingleRightAnswer:(NSInteger)index answer:(NSString *)answer;       //单选

+ (BOOL)isMutiRightAnswer:(NSString *)selectedIndexs answer:(NSString *)answer;


#pragma mark - 错题集接口

+ (void)setQuestionFlag:(ExerciseType)type quesionID:(NSInteger)quesionID isWrong:(BOOL)isWrong;
#pragma mark - 考试模式接口
//随机获取模拟考试题目数据
+ (NSArray *)getExamQuestionsByType:(ExerciseType)type;

+ (void)closeDB;

@end
