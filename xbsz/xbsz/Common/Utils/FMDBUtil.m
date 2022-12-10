//
//  FMDBUtil.m
//  xbsz
//
//  Created by lotus on 2017/4/25.
//  Copyright © 2017年 lotus. All rights reserved.
//

#import "FMDBUtil.h"
#import "FMDB.h"
#import "ExerciseQuestion.h"


@implementation FMDBUtil

+ (instancetype)instance{
    static FMDBUtil *_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[FMDBUtil alloc] init];
    });
    return _instance;
}


+ (FMDatabase *)getDefaultDB{
    static FMDatabase *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *localPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        // 要检查的文件目录
        NSString *filePath = [localPath  stringByAppendingPathComponent:@"tiku.db"];
        instance = [FMDatabase databaseWithPath:filePath];
    });
    return instance;
}


+ (ExerciseType)indexToExerciseType:(NSInteger)index{
    ExerciseType type ;
    if(index == 5){
        type = ExerciseTypeNetworkSecurity;
    }else if(index == 6){
        type = ExerciseTypePassword;
    }else if(index == 7){
        type = ExerciseTypeSystemSecurity;
    }else if(index == 0){
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
    }else if(type == ExerciseTypeNetworkSecurity){
        return @"网络安全";
    }else if(type == ExerciseTypePassword){
        return @"密码学";
    }else if(type == ExerciseTypeSystemSecurity){
        return @"系统安全";
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
    }else if(type == ExerciseTypeNetworkSecurity){
        return @"network";
    }else if(type == ExerciseTypePassword){
        return @"password";
    }else if(type == ExerciseTypeSystemSecurity){
        return @"system";
    }else{
        return @"unknown";
    }
}

+ (NSInteger)getQuestionsTotalByType:(ExerciseType)type{
    NSString *table_name = [self exerciseTypeToTableName:type];
    FMDatabase *db = [self getDefaultDB];
    if ([db open])  {
        NSString *sql = [NSString stringWithFormat:@"select count(*) from %@ where id != 0",table_name];
        FMResultSet *rs = [db executeQuery:sql];
        while ([rs next]) {
            NSInteger total  = [rs longForColumnIndex:0];
            return total;
        }
        
    }
    return 0;
}

+ (NSInteger)getQuestionsTotalByType:(ExerciseType)type isWrong:(BOOL)isWrong{
    NSString *table_name = [self exerciseTypeToTableName:type];
    FMDatabase *db = [self getDefaultDB];
    if ([db open])  {
        NSString *sql = [NSString stringWithFormat:@"select count(*) from %@ where id != 0 and flag = -1",table_name];
        FMResultSet *rs = [db executeQuery:sql];
        while ([rs next]) {
            NSInteger total =  [rs longForColumnIndex:0];
            return total;
        }
        
    }
    return 0;
}

+ (NSInteger)getQuestionsTotalByType:(ExerciseType)type isSingle:(BOOL)isSingle{
    NSString *table_name = [self exerciseTypeToTableName:type];
    FMDatabase *db = [self getDefaultDB];
    if ([db open])  {
        NSString *sql = @"";
        if(isSingle == YES){
            sql = [NSString stringWithFormat:@"select count(*) from %@ where id != 0 and ( type = 1 or type = 3)",table_name];
        }else{
            sql = [NSString stringWithFormat:@"select count(*) from %@ where id != 0 and type = 2",table_name];
        }
        FMResultSet *rs = [db executeQuery:sql];
        while ([rs next]) {
            NSInteger total =  [rs longForColumnIndex:0];
            return total;
        }
        
    }
    return 0;
}

+ (NSInteger)getQuestionsTotalByType:(ExerciseType)type isSingle:(BOOL)isSingle isWrong:(BOOL)isWrong{
    NSString *table_name = [self exerciseTypeToTableName:type];
    FMDatabase *db = [self getDefaultDB];
    if ([db open])  {
        NSString *sql = @"";
        if(isSingle == YES){
            sql = [NSString stringWithFormat:@"select count(*) from %@ where id != 0 and flag = -1 and ( type = 1 or type = 3)",table_name];
        }else{
            sql = [NSString stringWithFormat:@"select count(*) from %@ where id != 0 and flag = -1 and type = 2",table_name];
        }
        FMResultSet *rs = [db executeQuery:sql];
        while ([rs next]) {
            NSInteger total =  [rs longForColumnIndex:0];
            return total;
        }
        
    }
    return 0;
}

+ (NSArray *)getChapterIndex:(ExerciseType)type isSingle:(BOOL)isSingle{
    NSString *table_name = [self exerciseTypeToTableName:type];
    FMDatabase *db = [self getDefaultDB];
    NSMutableArray *ans = [[NSMutableArray alloc] init];
    if ([db open])  {
        NSString *sql = @"";
        if(isSingle == YES){
            sql = [NSString stringWithFormat:@"select pid from %@ where id != 0 and ( type = 1 or type = 3)",table_name];
        }else{
            sql = [NSString stringWithFormat:@"select pid from %@ where id != 0 and type = 2",table_name];
        }
        FMResultSet *rs = [db executeQuery:sql];
        while ([rs next]) {
            NSInteger pid = [rs longForColumn:@"pid"];
            NSString *val = [NSString stringWithFormat:@"%ld",pid];
            if(![ans containsObject:val]){
                [ans addObject:val];
            }
        }
        return  [ans sortedArrayUsingComparator:^NSComparisonResult(NSString *obj1, NSString *obj2) {
            return [obj1 integerValue] > [obj2 integerValue];
        }];
    }
    return [NSArray array];
}

+ (NSArray *)getChapterIndex:(ExerciseType)type isSingle:(BOOL)isSingle isWrong:(BOOL)isWrong{
    NSString *table_name = [self exerciseTypeToTableName:type];
    FMDatabase *db = [self getDefaultDB];
    NSMutableArray *ans = [[NSMutableArray alloc] init];
    if ([db open])  {
        NSString *sql = @"";
        if(isSingle == YES){
            sql = [NSString stringWithFormat:@"select pid from %@ where id != 0 and flag = -1 and ( type = 1 or type = 3)",table_name];
        }else{
             sql = [NSString stringWithFormat:@"select pid from %@ where id != 0 and flag = -1 and type = 2",table_name];
        }
        FMResultSet *rs = [db executeQuery:sql];
        while ([rs next]) {
            NSInteger pid = [rs longForColumn:@"pid"];
            NSString *val = [NSString stringWithFormat:@"%ld",pid];
            if(![ans containsObject:val]){
                [ans addObject:val];
            }
        }
        return  [ans sortedArrayUsingComparator:^NSComparisonResult(NSString *obj1, NSString *obj2) {
            return [obj1 compare:obj2];
        }];
    }
    return [NSArray array];
}

+ (NSArray *)getChapterNums:(ExerciseType)type isSingle:(BOOL)isSingle{
    NSString *table_name = [self exerciseTypeToTableName:type];
    FMDatabase *db = [self getDefaultDB];
    if ([db open])  {
        
        NSString *sql = @"";
        if(isSingle == YES){
            sql = [NSString stringWithFormat:@"select pid from %@ where id != 0 and ( type = 1 or type = 3)",table_name];
        }else{
            sql = [NSString stringWithFormat:@"select pid from %@ where id != 0 and type = 2",table_name];
        }
        FMResultSet *rs = [db executeQuery:sql];
        NSMutableDictionary *temp = [[NSMutableDictionary alloc] init];
        while ([rs next]) {
            NSInteger pid = [rs longForColumn:@"pid"];
            NSString *key = [NSString stringWithFormat:@"%ld",pid];
            if([temp containsObjectForKey:key]){
                NSInteger val = [[temp valueForKey:key] integerValue];
                [temp setValue:[NSString stringWithFormat:@"%ld",val+1] forKey:key];
            }else{
                [temp setValue:@"1" forKey:key];
            }
        }
        
        NSArray *keys = [temp allKeys];
        keys = [keys sortedArrayUsingComparator:^NSComparisonResult(NSString *obj1, NSString *obj2) {
            return [obj1 integerValue] > [obj2 integerValue];
        }];
        
        NSMutableArray *ans = [NSMutableArray array];
        for(NSString *key in keys){
            [ans addObject:[temp valueForKey:key]];
        }
        return ans;
    }
    return [NSArray array];
}

+ (NSArray *)getChapterNums:(ExerciseType)type isSingle:(BOOL)isSingle isWrong:(BOOL)isWrong{
    NSString *table_name = [self exerciseTypeToTableName:type];
    FMDatabase *db = [self getDefaultDB];
    if ([db open])  {
        NSString *sql = @"";
        if(isSingle == YES){
            sql = [NSString stringWithFormat:@"select pid from %@ where id != 0 and flag = -1 and ( type = 1 or type = 3)",table_name];
        }else{
            sql = [NSString stringWithFormat:@"select pid from %@ where id != 0 and flag = -1 and type = 2",table_name];
        }
        FMResultSet *rs = [db executeQuery:sql];
        NSMutableDictionary *temp = [[NSMutableDictionary alloc] init];
        while ([rs next]) {
            NSInteger pid = [rs longForColumn:@"pid"];
            NSString *key = [NSString stringWithFormat:@"%ld",pid];
            if([temp containsObjectForKey:key]){
                NSInteger val = [[temp valueForKey:key] integerValue];
                [temp setValue:[NSString stringWithFormat:@"%ld",val+1] forKey:key];
            }else{
                [temp setValue:@"1" forKey:key];
            }
        }
        
        NSArray *ans = [temp allValuesSortedByKeys];
        return ans;
    }
    return [NSArray array];
}

+ (NSArray *)getQuestions:(ExerciseType)type isSingle:(BOOL)isSingle chapterIndex:(NSInteger)index{
    NSString *table_name = [self exerciseTypeToTableName:type];
    FMDatabase *db = [self getDefaultDB];
    if ([db open])  {
        NSString *sql = nil;
        if(isSingle == YES){
            sql = [NSString stringWithFormat:@"select * from %@ where id != 0 and pid = %ld and ( type = 1 or type = 3) ",table_name,index];
        }else{
            sql = [NSString stringWithFormat:@"select * from %@ where id != 0 and pid = %ld and type = 2 ",table_name,index];
        }
        NSMutableArray *ans = [NSMutableArray array];
        FMResultSet *rs = [db executeQuery:sql];
        while ([rs next]) {
            ExerciseQuestion *temp = [[ExerciseQuestion alloc] init];
            temp.question_id = [rs intForColumn:@"id"];
            temp.pid = [rs intForColumn:@"pid"];
            temp.qid = [rs intForColumn:@"qid"];
            temp.type = [rs intForColumn:@"type"];
            temp.title = [rs stringForColumn:@"title"];
            temp.option = [rs stringForColumn:@"option"];
            temp.answer = [rs stringForColumn:@"answer"];
            temp.flag = [rs intForColumn:@"flag"];
            [ans addObject:temp];
        }
        return [ans copy];
        
    }
    return [NSArray array];
}

+ (NSArray *)getQuestions:(ExerciseType)type isSingle:(BOOL)isSingle isWrong:(NSInteger)isWrong chapterIndex:(NSInteger)index{
    NSString *table_name = [self exerciseTypeToTableName:type];
    FMDatabase *db = [self getDefaultDB];
    if ([db open])  {
        NSString *sql = nil;
        if(isSingle == YES){
            sql = [NSString stringWithFormat:@"select * from %@ where id != 0 and pid = %ld and flag = -1 and ( type = 1 or type = 3) ",table_name,index];
        }else{
            sql = [NSString stringWithFormat:@"select * from %@ where id != 0 and pid = %ld and flag = -1 and type = 2 ",table_name,index];
        }
        NSMutableArray *ans = [NSMutableArray array];
        FMResultSet *rs = [db executeQuery:sql];
        while ([rs next]) {
            ExerciseQuestion *temp = [[ExerciseQuestion alloc] init];
            temp.question_id = [rs intForColumn:@"id"];
            temp.pid = [rs intForColumn:@"pid"];
            temp.qid = [rs intForColumn:@"qid"];
            temp.type = [rs intForColumn:@"type"];
            temp.title = [rs stringForColumn:@"title"];
            temp.option = [rs stringForColumn:@"option"];
            temp.answer = [rs stringForColumn:@"answer"];
            temp.flag = [rs intForColumn:@"flag"];
            [ans addObject:temp];
        }
        return [ans copy];
        
    }
    return [NSArray array];
}

//+ (NSArray *)getOptionsByString:(NSString *)optionStr type:(NSInteger)type{
//    
//    NSMutableArray *ans = [NSMutableArray array];
//    if(type == 3){
//        [ans addObject:@"对"];
//        [ans addObject:@"错"];
//        return ans;
//    }
//    
//    NSString *temp = @"";
//    for (size_t i = 0; i < [optionStr length]; i++) {
//        unichar ch = [optionStr characterAtIndex:i];
//        if (ch <= 'F' && ch >= 'A') {
//            temp = [NSString stringWithFormat:@"%C",ch];
//            ch = [optionStr characterAtIndex:++i];
//            while (ch < 'A' || ch > 'F') {
//                temp = [temp stringByAppendingString:[NSString stringWithFormat:@"%C",ch]];
//                if (i >= [optionStr length] - 1)
//                    break;
//                ch = [optionStr characterAtIndex:++i];
//            }
//            [ans addObject:[self getSubstring:temp]];
//            --i;
//        }
//        
//    }
//    return ans;
//}

+ (NSArray *)getOptionsByString:(NSString *)optionStr type:(NSInteger)type {
    
    NSMutableArray *ans = [NSMutableArray array];
    if(type == 3){
        [ans addObject:@"对"];
        [ans addObject:@"错"];
        return ans;
    }
    
    NSString *temp = @"";
    unichar lastSymbol = 'A';
    for (size_t i = 0; i < [optionStr length]; i++) {
        unichar ch = [optionStr characterAtIndex:i];
        if (ch <= 'F' && ch >= 'A' && ch == lastSymbol) {
            temp = [NSString stringWithFormat:@"%C",ch];
            ch = [optionStr characterAtIndex:++i];
            while (ch < 'A' || ch > 'F' || ch != lastSymbol + 1) {
                temp = [temp stringByAppendingString:[NSString stringWithFormat:@"%C",ch]];
                if (i >= [optionStr length] - 1)
                    break;
                ch = [optionStr characterAtIndex:++i];
            }
            [ans addObject:[self getSubstring:temp]];
            lastSymbol = lastSymbol + 1;
            --i;
        }
        
    }
    return ans;
}

//从第一个汉字或数字开始  去除前面非汉字
+ (NSString *)getSubstring:(NSString *)option{
    NSInteger index = 0;
    for(size_t i = 1;i < [option length];i++){
        unichar ch = [option characterAtIndex:i];
        if([self isOptionStart:ch]){
            index = i;
            break;
        }
    }
    return [option substringFromIndex:index];
}

+ (BOOL)isOptionStart:(unichar)ch{
    if((ch >= 0x4e00&& ch <=0x9fff) || (ch >= '0' && ch<= '9')){
        return YES;
    }
    // 《 ( （这三个符号
    if( ch == 0x300a || ch == 0x0028 || ch == 0xff08){
        return YES;
    }
    //①②③④⑤...
    if(ch == 0x2460 || ch == 0x2461 || ch == 0x2462 || ch == 0x2463 || ch == 0x2464 || ch == 0x2465 || ch == 0x2466){
        return YES;
    }
    
    if((ch >= 'A' && ch <= 'Z') || (ch >= 'a' && ch <= 'z')){
        return YES;
    }
    if (ch == 0x201c) return YES; // for (unichar) ch = U+201c u'“'
    
    return NO;
}

+ (NSString *)getPureTitle:(NSString *)title{
    NSInteger index = 0;
    for(size_t i = 0;i < [title length];i++){
        unichar ch = [title characterAtIndex:i];
        if(ch >= '0' && ch<= '9'){
            
            while (ch >= '0' && ch <= '9') {
                ch = [title characterAtIndex:++i];
                index = i;
            }
            break;
        }
    }
    title = [title substringFromIndex:index];
    return [self getSubstring:title];
}

+ (BOOL)isSingleRightAnswer:(NSInteger)index answer:(NSString *)answer{
    NSString *symbol = [self indexConvertToSymbol:index];
    NSString *minSymbol = [self indexConvertToMinSymbol:index];
    NSString *chinaSymbol = [self indexToChinaSymbol:index];
    if([answer containsString:symbol] || [answer containsString:minSymbol] || [answer containsString:chinaSymbol]){
        return YES;
    }else{
        return NO;
    }
}

+ (BOOL)isMutiRightAnswer:(NSString *)selectedIndexs answer:(NSString *)answer{
    for(NSInteger i = 0;i<[selectedIndexs length];i++){
        NSInteger index = [[NSString stringWithFormat:@"%c",[selectedIndexs characterAtIndex:i]] integerValue];
        if(![self isSingleRightAnswer:index answer:answer]){
            return NO;
        }
    }
    return [selectedIndexs length] == [[answer stringByTrim] length];
}

+ (void)setQuestionFlag:(ExerciseType)type quesionID:(NSInteger)quesionID isWrong:(BOOL)isWrong{
    NSString *table_name = [self exerciseTypeToTableName:type];
    FMDatabase *db = [self getDefaultDB];
    
    if ([db open]){
        if(isWrong == YES){
            NSString *sql = [NSString stringWithFormat:@"update %@ set flag = ? where id = ?",table_name];
            [db executeUpdate:sql,@(-1),@(quesionID)];
        }else{
            NSString *sql = [NSString stringWithFormat:@"update %@ set flag = 0 where id = %ld",table_name,quesionID];
            [db executeUpdate:sql];
        }
    }
}

+ (NSString *)indexConvertToSymbol:(NSInteger)index{
    if(index == 0){
        return @"A";
    }else if(index == 1){
        return @"B";
    }else if(index == 2){
        return @"C";
    }else if(index == 3){
        return @"D";
    }else if(index == 4){
        return @"E";
    }else if(index == 5){
        return @"F";
    }else if(index == 6){
        return @"G";
    }else{
        return @"X";
    }
}

+ (NSString *)indexConvertToMinSymbol:(NSInteger)index{
    if(index == 0){
        return @"a";
    }else if(index == 1){
        return @"b";
    }else if(index == 2){
        return @"c";
    }else if(index == 3){
        return @"d";
    }else if(index == 4){
        return @"e";
    }else if(index == 5){
        return @"f";
    }else if(index == 6){
        return @"g";
    }else{
        return @"x";
    }
}

+ (NSString *)indexToChinaSymbol:(NSInteger)index{
    if(index == 0){
        return @"对";
    }else if(index == 1){
        return @"错";
    }else{
        return @"未知";
    }
}

+ (NSMutableArray *)getSearchResultsBySearchText:(NSString *)text type:(ExerciseType)type{
    
    FMDatabase *db = [self getDefaultDB];
    if([db open]){
        NSString *tableName = [self exerciseTypeToTableName:type];
        NSString *sql = [NSString stringWithFormat:@"select * from %@ where id != 0 and ( title like '%%%@%%' or option like '%%%@\%%')",tableName,text,text];
        NSMutableArray *ans = [NSMutableArray array];
        FMResultSet *rs = [db executeQuery:sql];
        while ([rs next]) {
            ExerciseQuestion *temp = [[ExerciseQuestion alloc] init];
            temp.question_id = [rs intForColumn:@"id"];
            temp.pid = [rs intForColumn:@"pid"];
            temp.qid = [rs intForColumn:@"qid"];
            temp.type = [rs intForColumn:@"type"];
            temp.title = [rs stringForColumn:@"title"];
            temp.option = [rs stringForColumn:@"option"];
            temp.answer = [rs stringForColumn:@"answer"];
            temp.flag = [rs intForColumn:@"flag"];
            [ans addObject:temp];
            if([ans count] >=21)    break;
        }
        return ans;
    }
    
    return [NSMutableArray array];
}

+ (NSArray *)getExamQuestionsByType:(ExerciseType)type{
    FMDatabase *db = [self getDefaultDB];
    if([db open]){
        NSString *tableName = [self exerciseTypeToTableName:type];
        NSString *sql = [NSString stringWithFormat:@"select * from %@ where id != 0 and (type = 1 or type = 3 ) order by random() limit 60",tableName];
        NSMutableArray *ans = [NSMutableArray array];
        FMResultSet *rs = [db executeQuery:sql];
        while ([rs next]) {
            ExerciseQuestion *temp = [[ExerciseQuestion alloc] init];
            temp.question_id = [rs intForColumn:@"id"];
            temp.pid = [rs intForColumn:@"pid"];
            temp.qid = [rs intForColumn:@"qid"];
            temp.type = [rs intForColumn:@"type"];
            temp.title = [rs stringForColumn:@"title"];
            temp.option = [rs stringForColumn:@"option"];
            temp.answer = [rs stringForColumn:@"answer"];
            temp.flag = [rs intForColumn:@"flag"];
            [ans addObject:temp];
        }
        
        sql = [NSString stringWithFormat:@"select * from %@ where id != 0 and type = 2 order by random() limit 20",tableName];
        rs = [db executeQuery:sql];
        while ([rs next]) {
            ExerciseQuestion *temp = [[ExerciseQuestion alloc] init];
            temp.question_id = [rs intForColumn:@"id"];
            temp.pid = [rs intForColumn:@"pid"];
            temp.qid = [rs intForColumn:@"qid"];
            temp.type = [rs intForColumn:@"type"];
            temp.title = [rs stringForColumn:@"title"];
            temp.option = [rs stringForColumn:@"option"];
            temp.answer = [rs stringForColumn:@"answer"];
            temp.flag = [rs intForColumn:@"flag"];
            [ans addObject:temp];
        }
        return ans;
    }
    
    return [NSMutableArray array];
}

+ (void)closeDB{
    FMDatabase *db = [self getDefaultDB];
    [db close];
}


@end
