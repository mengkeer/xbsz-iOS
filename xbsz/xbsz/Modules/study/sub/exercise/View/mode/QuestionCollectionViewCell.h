//
//  QuestionCollectionViewCell.h
//  xbsz
//
//  Created by lotus on 2017/4/25.
//  Copyright © 2017年 lotus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ExerciseQuestion.h"
#import "ExerciseMode.h"

@interface QuestionCollectionViewCell : UICollectionViewCell

- (void)updateUIByQuestion:(ExerciseQuestion *)question mode:(ExerciseMode)mode;

@end
