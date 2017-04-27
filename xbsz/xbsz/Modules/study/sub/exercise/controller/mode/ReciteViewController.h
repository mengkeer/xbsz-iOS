//
//  ExerciseQuestionViewController.h
//  xbsz
//
//  Created by lotus on 2017/4/25.
//  Copyright © 2017年 lotus. All rights reserved.
//

#import "CXWhitePushViewController.h"
#import "ExerciseMode.h"

@interface ReciteViewController : CXWhitePushViewController

@property (nonatomic, assign) ExerciseMode mode;                //做题模式

@property (nonatomic, assign) BOOL isSingle;         //是否是单选

@property (nonatomic, assign) ExerciseType type;

@property (nonatomic, assign) NSInteger chapterIndex;       //文章索引

@end
