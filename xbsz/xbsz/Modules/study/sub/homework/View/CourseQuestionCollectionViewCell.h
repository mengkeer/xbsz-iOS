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

- (void)updateUIByQuestion:(CourseQuestion *)question allowSelect:(BOOL)allowSelect;

- (BOOL)showMutiPracticeAnswer:(NSString *)selectIndexs;     //在显示做题的结果     返回答案是对还是错

- (void)setTemporarySelected:(NSString *)selectedIndexs;

@property (nonatomic, weak) id<CourseQuestionOptionDelegate> baseDelegate;

@end


@protocol  BlankTextViewDelegate <NSObject>

@optional
- (void)blankTextEntered:(NSString *)text;

@end

@interface BlankCollectionViewCell : UICollectionViewCell

- (void)updateUIByQuestion:(CourseQuestion *)question;

- (void)updateUIByQuestion:(CourseQuestion *)question allowEdit:(BOOL)allowEdit;

- (void)showTemporaryText:(NSString *)text;

- (BOOL)showPracticeAnswer:(NSString *)text;

@property (nonatomic, weak) id<BlankTextViewDelegate> baseDelegate;


@end
