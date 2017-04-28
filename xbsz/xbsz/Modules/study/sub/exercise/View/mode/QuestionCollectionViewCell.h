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

@protocol  QuestionOptionDelegate <NSObject>

@optional
- (void)selectOption:(NSInteger)selectedIndex;

@end

@interface QuestionCollectionViewCell : UICollectionViewCell

- (void)updateUIByQuestion:(ExerciseQuestion *)question;

- (void)updateUIByQuestion:(ExerciseQuestion *)question allowSelect:(BOOL)allowSelect;

- (void)updateUIByQuestion:(ExerciseQuestion *)question showRightAnswer:(BOOL)showRgihtAnswer;

- (BOOL)showSinglePracticeAnswer:(NSInteger)selectIndex;     //在练习模式下显示单选做题的结果

- (BOOL)showMutiPracticeAnswer:(NSString *)selectIndexs;     //在练习模式下显示多做题的结果

- (void)setTemporarySelected:(NSString *)selectedIndexs;    //设置临时选中  用于练习模式下的多选题

@property (nonatomic, weak) id<QuestionOptionDelegate> baseDelegate;

@end
