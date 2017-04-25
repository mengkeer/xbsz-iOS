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

- (void)selectChapter:(NSInteger)index;

@end

@interface ExerciseChapterCollectionViewCell : UICollectionViewCell

- (void)upadteUIByType:(ExerciseType)type isSingle:(BOOL)isSingle;

@property (nonatomic, weak) id<ExerciseChapterTableViewDelegate> selectDelegate;

@end
