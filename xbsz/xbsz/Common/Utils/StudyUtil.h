//
//  StudyUtil.h
//  xbsz
//
//  Created by lotus on 2017/5/17.
//  Copyright © 2017年 lotus. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger , QuestionType){
    QuestionTypeSingle,       //单选
    QuestionTypeMuti,     //多选
    QuestionTypeJudge,
    QuestionTypeBlank,        //填空
    QuestionTypeUnknown       //未知题型 做保留字段
};

@interface StudyUtil : NSObject

+ (instancetype)instance;

//根据option字符窜分离出来 各个选项  
+ (NSArray *)getOptionsByString:(NSString *)optionStr type:(NSString *)typeStr;

+ (QuestionType)getQuestionTypeByString:(NSString *)str;

//是否是单选  将单选和判断 都看成单选
+ (BOOL)isSingle:(NSString *)typeStr;

@end
