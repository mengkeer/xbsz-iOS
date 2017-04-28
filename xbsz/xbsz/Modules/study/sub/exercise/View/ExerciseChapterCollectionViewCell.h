//
//  ExerciseChapterCollectionViewCell.h
//  xbsz
//
//  Created by lotus on 2017/4/24.
//  Copyright © 2017年 lotus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Exercise.h"
#import "ExerciseMode.h"

@protocol ExerciseChapterTableViewDelegate <NSObject>

@required
//返回点击的章节索引  注：不是cell索引
- (void)selectChapter:(NSInteger)index;

@end

@interface ExerciseChapterCollectionViewCell : UICollectionViewCell

- (void)upadteUIByType:(ExerciseType)type mode:(ExerciseMode)mode isSingle:(BOOL)isSingle;

@property (nonatomic, weak) id<ExerciseChapterTableViewDelegate> selectDelegate;

@end
