//
//  CXUserDefaults.m
//  xbsz
//
//  Created by lotus on 2017/4/29.
//  Copyright © 2017年 lotus. All rights reserved.
//

#import "CXUserDefaults.h"

static CXUserDefaults *sharedObj;

@implementation CXUserDefaults

+ (instancetype)instance{
    @synchronized (self){
        if (sharedObj == nil){
            if (sharedObj == nil)
                sharedObj = [[CXUserDefaults alloc] init];
        }
    }
    return sharedObj;
}

+ (void)setDefaultspreference{
    [CXStandardUserDefaults setBool:YES forKey:@"isAudioOpen"];
    [CXStandardUserDefaults setBool:NO forKey:@"isShakeOpen"];
    [CXStandardUserDefaults setInteger:15 forKey:@"questionFontSize"];
}

- (BOOL)isAudioOpen{
    BOOL isOpen = [CXStandardUserDefaults boolForKey:@"isAudioOpen"];
    return isOpen;
}

- (void)setIsAudioOpen:(BOOL)isAudioOpen{
    [CXStandardUserDefaults setBool:isAudioOpen forKey:@"isAudioOpen"];
}

- (BOOL)isShakeOpen{
    BOOL isOpen = [CXStandardUserDefaults boolForKey:@"isShakeOpen"];
    return isOpen;
}

- (void)setIsShakeOpen:(BOOL)isShakeOpen{
    [CXStandardUserDefaults setBool:isShakeOpen forKey:@"isShakeOpen"];
}

- (NSInteger)questionFontSize{
    NSInteger size = [CXStandardUserDefaults integerForKey:@"questionFontSize"];
    return size;
}

- (void)setQuestionFontSize:(NSInteger)questionFontSize{
    [CXStandardUserDefaults setInteger:questionFontSize forKey:@"questionFontSize"];
}

- (NSString *)sizeDescription{
    if([CXStandardUserDefaults integerForKey:@"questionFontSize"] == 12){
        return @"小";
    }else if([CXStandardUserDefaults integerForKey:@"questionFontSize"] == 15){
        return @"中";
    }else if([CXStandardUserDefaults integerForKey:@"questionFontSize"] == 18){
        return @"大";
    }else{
        return @"未知";
    }
}

@end
