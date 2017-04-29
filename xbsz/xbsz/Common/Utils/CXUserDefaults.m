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

@end
