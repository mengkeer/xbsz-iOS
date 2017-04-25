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

- (void)updateUIWithIndex:(NSInteger)index question:(ExerciseQuestion *)question;

@end
