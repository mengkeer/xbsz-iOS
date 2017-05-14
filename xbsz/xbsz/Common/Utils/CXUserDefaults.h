//
//  CXUserDefaults.h
//  xbsz
//
//  Created by lotus on 2017/4/29.
//  Copyright © 2017年 lotus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CXUserDefaults : NSObject

+ (instancetype)instance;

+ (void)setDefaultspreference;

@property (nonatomic, assign) BOOL isAudioOpen;

@property (nonatomic, assign) BOOL isShakeOpen;

@property (nonatomic, assign) NSInteger questionFontSize;           //做题时默认字体
@property (nonatomic, copy) NSString *sizeDescription;          //字体描述  小号 中号 大号    不保存到本地

@property (nonatomic, assign) NSInteger themeType;
@property (nonatomic, copy) NSString *themeDescription;         // 不保存到本地
@property (nonatomic, strong) UIColor *centerColor;     // 不保存到本地
@property (nonatomic, strong) UIColor *mainColor;                    //不保存到本地
@property (nonatomic, strong) UIColor *textColor;


@property (nonatomic, assign) NSInteger bgType;
@property (nonatomic, copy) NSString *bgDescription;
@property (nonatomic, strong) UIColor *bgColor;


@end
