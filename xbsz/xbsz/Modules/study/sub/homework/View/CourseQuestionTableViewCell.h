//
//  CourseQuestionTableViewCell.h
//  xbsz
//
//  Created by lotus on 2017/4/25.
//  Copyright © 2017年 lotus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CourseQuestion.h"

typedef NS_ENUM(NSInteger,QuestionStatus){
    QuestionStatusSingleDefault,        //单选的默认状态
    QuestionStatusSingleRight,              //单选选中时的状态
    QuestionStatusSingleWrong,              //单选选错时的状态
    QuestionStatusMutiDefault,         //多选默认状态
    QuestionStatusMutiSelected,         //多选选中是的状态
    QuestionStatusMutiRight,            //多选选项完全正取时的状态
    QuestionStatusMutiWrong,            //多选选项错误时的状态
    QuestionStatusMutiRightWrong           //多选部分正确时选项
};

@interface CourseQuestionTableViewCell : UITableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier
                     isSingle:(BOOL)isSingle;

- (void)updateUIWithIndex:(NSInteger)index option:(NSString *)option isSingle:(BOOL)isSingle;

////根据答案将题目标亮  指预览模式
//- (void)showSingleRightAnswer:(NSInteger)index answer:(NSString *)answer;
//
//- (void)showSinglePracticeResult:(NSInteger)index
//                   selectedIndex:(NSInteger)selectedIndex
//                          answer:(NSString *)answer;
//
- (void)showMutiPracticeResult:(NSInteger)index
                 selectedIndex:(NSString *)selectedIndexs
                        answer:(NSString *)answer;



- (void)setTemporarySelected:(NSInteger)index
              selectedIndexs:(NSString *)selectedIndexs;


@end
