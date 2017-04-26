//
//  QuestionTableViewCell.h
//  xbsz
//
//  Created by lotus on 2017/4/25.
//  Copyright © 2017年 lotus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ExerciseQuestion.h"

@interface QuestionTableViewCell : UITableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier
                     isSingle:(BOOL)isSingle;

- (void)updateUIWithIndex:(NSInteger)index option:(NSString *)option;

//根据答案将题目标亮  指预览模式
- (void)showRightAnswer:(NSInteger)index answer:(NSString *)answer;

@end
