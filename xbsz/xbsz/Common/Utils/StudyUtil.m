//
//  StudyUtil.m
//  xbsz
//
//  Created by lotus on 2017/4/25.
//  Copyright © 2017年 lotus. All rights reserved.
//

#import "StudyUtil.h"
#import "FMDB.h"


@implementation StudyUtil

+ (instancetype)instance{
    static StudyUtil *_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[StudyUtil alloc] init];
    });
    return _instance;
}


+ (FMDatabase *)getDefaultDB{
    static FMDatabase *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *path = [[NSBundle mainBundle] pathForResource:@"tiku" ofType:@"db"];
        instance = [FMDatabase databaseWithPath:path];
    });
    return instance;
}


+ (ExerciseType)indexToExerciseType:(NSInteger)index{
    ExerciseType type ;
    if(index == 0){
        type = ExerciseTypeMarx;
    }else if(index == 1){
        type = ExerciseTypeHistory;
    }else if(index == 2){
        type = ExerciseTypeThought;
    }else if(index == 3){
        type = ExerciseTypeMao1;
    }else if(index == 4){
        type = ExerciseTypeMao2;
    }else{
        type = ExerciseTypeUnknown;
    }
    return type;
}

+ (NSString *)exerciseTypeToExerciseName:(ExerciseType)type{
    if(type == ExerciseTypeMao1){
        return @"毛概1";
    }else if(type == ExerciseTypeMao2){
        return @"毛概2";
    }else if(type == ExerciseTypeMarx){
        return @"马克思";
    }else if(type == ExerciseTypeHistory){
        return @"近代史";
    }else if(type == ExerciseTypeThought){
        return @"思修";
    }else{
        return @"未知课程";
    }
}

+ (NSString *)exerciseTypeToTableName:(ExerciseType)type{
    if(type == ExerciseTypeMao1){
        return @"mao1";
    }else if(type == ExerciseTypeMao2){
        return @"mao2";
    }else if(type == ExerciseTypeMarx){
        return @"marx";
    }else if(type == ExerciseTypeHistory){
        return @"history";
    }else if(type == ExerciseTypeThought){
        return @"thought";
    }else{
        return @"unknown";
    }
}

+ (NSInteger)getQuestionsTotalByType:(ExerciseType)type{
    NSString *table_name = [self exerciseTypeToTableName:type];
    FMDatabase *db = [self getDefaultDB];
    if ([db open])  {
        NSString *sql = [NSString stringWithFormat:@"select * from %@ where id = 0",table_name];
        FMResultSet *rs = [db executeQuery:sql];
        while ([rs next]) {
            NSInteger total = [rs longForColumn:@"qid"];
            return total;
        }
        
    }
    return 0;
}

+ (NSArray *)getChapterIndex:(ExerciseType)type{
    NSString *table_name = [self exerciseTypeToTableName:type];
    FMDatabase *db = [self getDefaultDB];
    if ([db open])  {
        NSString *sql = [NSString stringWithFormat:@"select * from %@ where id = 0",table_name];
        FMResultSet *rs = [db executeQuery:sql];
        while ([rs next]) {
            NSString *option = [rs stringForColumn:@"option"];
            return [option componentsSeparatedByString:@","];
        }
        
    }
    return [NSArray array];
}

+ (NSArray *)getChapterNums:(ExerciseType)type{
    NSString *table_name = [self exerciseTypeToTableName:type];
    FMDatabase *db = [self getDefaultDB];
    if ([db open])  {
        NSString *sql = [NSString stringWithFormat:@"select * from %@ where id = 0",table_name];
        FMResultSet *rs = [db executeQuery:sql];
        while ([rs next]) {
            NSString *option = [rs stringForColumn:@"answer"];
            NSArray *arr = [option componentsSeparatedByString:@";"];
            NSMutableArray *ans = [NSMutableArray array];
            [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                NSArray *temp = [(obj) componentsSeparatedByString:@","];
                [ans addObject:temp];
            }];
            return [ans copy];
        }
        
    }
    return [NSArray array];
}

+ (void)closeDB{
    FMDatabase *db = [self getDefaultDB];
    [db close];
}


@end
