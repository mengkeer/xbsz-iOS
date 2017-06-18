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
  
}

- (BOOL)hasAd{
    if([CXStandardUserDefaults objectForKey:@"hasAd"] == nil){
        [CXStandardUserDefaults setBool:YES forKey:@"hasAd"];
        [CXStandardUserDefaults synchronize];
    }
    BOOL hasAd = [CXStandardUserDefaults boolForKey:@"hasAd"];
    return hasAd;
}

- (void)setHasAd:(BOOL)hasAd{
    [CXStandardUserDefaults setBool:hasAd forKey:@"hasAd"];
    [CXStandardUserDefaults synchronize];
}

- (BOOL)hasPurchased{
    if([CXStandardUserDefaults objectForKey:@"hasPurchased"] == nil){
        [CXStandardUserDefaults setBool:NO forKey:@"hasPurchased"];
        [CXStandardUserDefaults synchronize];
    }
    BOOL hasPurchased = [CXStandardUserDefaults boolForKey:@"hasPurchased"];
    return hasPurchased;
}

- (void)setHasPurchased:(BOOL)hasPurchased{
    [CXStandardUserDefaults setBool:hasPurchased forKey:@"hasPurchased"];
    [CXStandardUserDefaults synchronize];
}

- (BOOL)isAudioOpen{
    if([CXStandardUserDefaults objectForKey:@"isAudioOpen"] == nil){
        [CXStandardUserDefaults setBool:YES forKey:@"isAudioOpen"];
        [CXStandardUserDefaults synchronize];
    }
    BOOL isOpen = [CXStandardUserDefaults boolForKey:@"isAudioOpen"];
    return isOpen;
}

- (void)setIsAudioOpen:(BOOL)isAudioOpen{
    [CXStandardUserDefaults setBool:isAudioOpen forKey:@"isAudioOpen"];
    [CXStandardUserDefaults synchronize];
}

- (BOOL)isShakeOpen{
    if([CXStandardUserDefaults objectForKey:@"isShakeOpen"] == nil){
        [CXStandardUserDefaults setBool:NO forKey:@"isShakeOpen"];
        [CXStandardUserDefaults synchronize];
    }
    BOOL isOpen = [CXStandardUserDefaults boolForKey:@"isShakeOpen"];
    return isOpen;
}

- (void)setIsShakeOpen:(BOOL)isShakeOpen{
    [CXStandardUserDefaults setBool:isShakeOpen forKey:@"isShakeOpen"];
    [CXStandardUserDefaults synchronize];
}

#pragma  mark - 字体大小


- (NSInteger)questionFontSize{
    if([CXStandardUserDefaults objectForKey:@"questionFontSize"] == nil){
        [CXStandardUserDefaults setInteger:15 forKey:@"questionFontSize"];
        [CXStandardUserDefaults synchronize];
    }
    NSInteger size = [CXStandardUserDefaults integerForKey:@"questionFontSize"];
    return size;
}

- (void)setQuestionFontSize:(NSInteger)questionFontSize{
    [CXStandardUserDefaults setInteger:questionFontSize forKey:@"questionFontSize"];
    [CXStandardUserDefaults synchronize];
}

- (NSString *)sizeDescription{
    if(self.questionFontSize == 12){
        return @"小";
    }else if(self.questionFontSize == 15){
        return @"中";
    }else if(self.questionFontSize == 18){
        return @"大";
    }else{
        return @"未知";
    }
}

#pragma  mark - 主题类型


- (NSInteger)themeType{
    if([CXStandardUserDefaults objectForKey:@"themeType"] == nil){
        [CXStandardUserDefaults setInteger:2 forKey:@"themeType"];
        [CXStandardUserDefaults synchronize];
    }
    return [CXStandardUserDefaults integerForKey:@"themeType"];
}

- (void)setThemeType:(NSInteger)themeType{
    if([CXStandardUserDefaults objectForKey:@"themeType"] == nil){
        [CXStandardUserDefaults setInteger:1 forKey:@"themeType"];
        [CXStandardUserDefaults synchronize];
    }
    //如果更改了主题  则发出通知
    if([CXStandardUserDefaults integerForKey:@"themeType"] != themeType){
        [CXStandardUserDefaults setInteger:themeType forKey:@"themeType"];
        [CXStandardUserDefaults synchronize];
        [[NSNotificationCenter defaultCenter] postNotificationName:NotificationThemeChanged object:nil];
    }
}

- (NSString *)themeDescription{
    NSInteger type = self.themeType;
    if(type == 1)   return @"樱花粉";
    else if(type == 2){
        return @"简洁白";
    }else if(type == 3){
        return @"水绿色";
    }else{
        return @"橙色";
    }
}

- (UIColor *)centerColor{
    NSInteger type = self.themeType;
    if(type == 1)   return CXMainColor;
    else if(type == 2){
        return CXHexColor(0xf4f4f4);
    }else if(type == 3){
        return CXHexColor(0x14b9c8);
    }else{
        return CXHexColor(0xff8900);
    }
}

- (UIColor *)mainColor{
    NSInteger type = self.themeType;
    if(type == 1)   return CXMainColor;
    else if(type == 2){
        return CXWhiteColor;
    }else if(type == 3){
        return  CXHexColor(0x14b9c8);;
    }else{
        return CXHexColor(0xff8900);
    }
}

- (UIColor *)textColor{
    NSInteger type = self.themeType;
    if(type == 2){           return CXBlackColor2;
    }else{
        return CXWhiteColor;
    }
}
#pragma  mark - 背景颜色
- (NSInteger)bgType{
    if([CXStandardUserDefaults objectForKey:@"bgType"] == nil){
        [CXStandardUserDefaults setInteger:1 forKey:@"bgType"];
        [CXStandardUserDefaults synchronize];
    }
    return [CXStandardUserDefaults integerForKey:@"bgType"];
}

- (void)setBgType:(NSInteger)bgType{
    [CXStandardUserDefaults setInteger:bgType forKey:@"bgType"];
    [CXStandardUserDefaults synchronize];
}

- (NSString *)bgDescription{
    NSInteger type = self.bgType;
    if(type == 1)   return @"纯白";
    else if(type == 2){
        return @"浅灰";
    }else if(type == 3){
        return @"护眼";
    }else{
        return @"淡青";
    }
}

- (UIColor *)bgColor{
    NSInteger type = self.bgType;
    if(type == 1)   return CXWhiteColor;
    else if(type == 2){
        return CXHexColor(0xada99a);
    }else if(type == 3){
        return CXHexColor(0xe9d5b9);
    }else{
        return CXHexColor(0xd1d8c2);
    }
}

- (void)setForbidPopGesture:(BOOL)forbidPopGesture{
    [CXStandardUserDefaults setBool:forbidPopGesture forKey:@"forbidPopGesture"];
    [CXStandardUserDefaults synchronize];
}

- (BOOL)forbidPopGesture{
    if([CXStandardUserDefaults objectForKey:@"forbidPopGesture"] == nil){
        [CXStandardUserDefaults setBool:NO forKey:@"forbidPopGesture"];
        [CXStandardUserDefaults synchronize];
    }
    BOOL forbidPopGesture = [CXStandardUserDefaults boolForKey:@"forbidPopGesture"];
    return forbidPopGesture;
}


@end
