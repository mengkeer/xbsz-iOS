//
//  SystemInform.h
//  xbsz
//
//  Created by lotus on 2017/5/16.
//  Copyright © 2017年 lotus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SystemInform : NSObject

@property (nonatomic, copy) NSString *content;

@property (nonatomic, assign) NSInteger isNew;

@property (nonatomic, strong) NSDate *time;

@end
