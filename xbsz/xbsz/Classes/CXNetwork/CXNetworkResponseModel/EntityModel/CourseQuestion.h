//
//  CourseQuestion.h
//  xbsz
//
//  Created by lotus on 2017/5/16.
//  Copyright © 2017年 lotus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CourseQuestion : NSObject


@property (nonatomic, assign) NSInteger queID;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *options;

@property (nonatomic, copy) NSString *answer;

@property (nonatomic, copy) NSString *type;

@end
