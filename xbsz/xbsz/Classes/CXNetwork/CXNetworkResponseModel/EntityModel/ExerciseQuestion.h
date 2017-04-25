//
//  ExerciseQuestion.h
//  xbsz
//
//  Created by lotus on 2017/4/25.
//  Copyright © 2017年 lotus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ExerciseQuestion : NSObject

@property (nonatomic, assign) NSInteger question_id;

@property (nonatomic, assign) NSInteger pid;

@property (nonatomic, assign) NSInteger qid;

@property (nonatomic, assign) NSInteger type;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *option;

@property (nonatomic, copy) NSString *answer;

@property (nonatomic, assign) NSInteger flag;

@end
