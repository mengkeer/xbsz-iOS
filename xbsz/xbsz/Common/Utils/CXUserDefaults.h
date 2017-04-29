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

@end
