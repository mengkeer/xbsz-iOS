//
//  CourseQuestionCollectionViewCell.h
//  xbsz
//
//  Created by lotus on 2017/4/25.
//  Copyright © 2017年 lotus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CourseQuestion.h"

@protocol  CourseQuestionOptionDelegate <NSObject>

@optional
- (void)selectOption:(NSInteger)selectedIndex;

@end

@interface CourseQuestionCollectionViewCell : UICollectionViewCell

- (void)updateUIByQuestion:(CourseQuestion *)question;

@property (nonatomic, weak) id<CourseQuestionOptionDelegate> baseDelegate;

@end
