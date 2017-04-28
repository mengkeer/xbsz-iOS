//
//  PracticeViewController.h
//  xbsz
//
//  Created by lotus on 2017/4/28.
//  Copyright © 2017年 lotus. All rights reserved.
//

#import "CXWhitePushViewController.h"
#import "ExerciseMode.h"

@interface SinglePracticeViewController : CXWhitePushViewController

@property (nonatomic, assign) ExerciseMode mode;        //判断是随机出题还是顺序出题

@property (nonatomic, assign) ExerciseType type;

@property (nonatomic, assign) NSInteger chapterIndex;       //文章索引

- (void)updateData:(ExerciseMode)mode
              type:(ExerciseType)type
           chapter:(NSInteger)chapterIndex;

@end
