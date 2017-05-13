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
@property (nonatomic, copy) NSString *sizeDescription;          //字体描述  小号 中号 大号

@end
