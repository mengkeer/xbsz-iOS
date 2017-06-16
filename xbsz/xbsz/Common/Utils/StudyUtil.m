//
//  StudyUtil.m
//  xbsz
//
//  Created by lotus on 2017/5/17.
//  Copyright © 2017年 lotus. All rights reserved.
//

#import "StudyUtil.h"

@implementation StudyUtil

+ (instancetype)instance{
    static StudyUtil *_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[StudyUtil alloc] init];
    });
    return _instance;
}

+ (QuestionType)getQuestionTypeByString:(NSString *)str{
    if([str isEqualToString:@"choice"]){
        return QuestionTypeSingle;
    }else if([str isEqualToString:@"choice"]){
        return QuestionTypeMuti;
    }else if([str isEqualToString:@"choice"]){
        return QuestionTypeJudge;
    }else if([str isEqualToString:@"answer"]){
        return QuestionTypeBlank;
    }else{
        return QuestionTypeUnknown;
    }
}

+ (BOOL)isSingle:(NSString *)typeStr{
    QuestionType type = [self getQuestionTypeByString:typeStr];
    if(type == QuestionTypeSingle || type == QuestionTypeJudge){
        return YES;
    }else{
        return NO;
    }
}

// ccc代表判断  以后要改

//+ (NSArray *)getOptionsByString:(NSString *)optionStr type:(NSString *)typeStr{
//    
//    NSMutableArray *ans = [NSMutableArray array];
//    QuestionType type = [self getQuestionTypeByString:typeStr];
//    if(type == QuestionTypeJudge){
//        [ans addObject:@"对"];
//        [ans addObject:@"错"];
//        return ans;
//    }
//    
//    if(type != QuestionTypeSingle && type != QuestionTypeMuti)  return ans;
//    
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
//                break;
//                ch = [optionStr characterAtIndex:++i];
//            }
//            [ans addObject:[self getSubstring:temp]];
//            --i;
//        }
//        
//    }
//    return ans;
//}

+ (NSArray *)getOptionsByString:(NSString *)optionStr type:(NSString *)typeStr{
    
    NSMutableArray *ans = [NSMutableArray array];
    QuestionType type = [self getQuestionTypeByString:typeStr];
    if(type == QuestionTypeJudge){
        [ans addObject:@"对"];
        [ans addObject:@"错"];
        return ans;
    }
    
    if(type != QuestionTypeSingle && type != QuestionTypeMuti)  return ans;
    
    NSArray *arr = [optionStr componentsSeparatedByString:@"￥"] ;
    for(NSInteger i = 0;i<[arr count]-1;i++){
        NSString *option = [arr objectAtIndex:i];
        [ans addObject:[self getSubstring:[option substringFromIndex:1]]];
    }
    
    
//    NSString *temp = @"";
//    unichar lastSymbol = 'A';
//    for (size_t i = 0; i < [optionStr length]; i++) {
//        unichar ch = [optionStr characterAtIndex:i];
//        if (ch <= 'F' && ch >= 'A' && ch == lastSymbol) {
//            temp = [NSString stringWithFormat:@"%C",ch];
//            ch = [optionStr characterAtIndex:++i];
//            while (ch != lastSymbol + 1) {
//                temp = [temp stringByAppendingString:[NSString stringWithFormat:@"%C",ch]];
//                if (i >= [optionStr length] - 1)
//                    break;
//                ch = [optionStr characterAtIndex:++i];
//            }
//            [ans addObject:[self getSubstring:temp]];
//            lastSymbol = lastSymbol + 1;
//            --i;
//        }
//        
//    }
    
    return ans;
}

//从第一个汉字或数字开始  去除前面非汉字
+ (NSString *)getSubstring:(NSString *)option{
    NSInteger index = 0;
    for(size_t i = 0;i < [option length];i++){
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
    
    return NO;
}


@end
