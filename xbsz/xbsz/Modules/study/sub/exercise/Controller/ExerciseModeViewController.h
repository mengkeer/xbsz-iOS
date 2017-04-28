//
//  ExerciseModeViewController.h
//  xbsz
//
//  Created by lotus on 2017/4/28.
//  Copyright © 2017年 lotus. All rights reserved.
//

#import "CXWhitePushViewController.h"
#import "ExerciseMode.h"

@interface ExerciseModeViewController : CXWhitePushViewController

@property (nonatomic, assign) ExerciseType type;

@property (nonatomic, strong) UIViewController *beforePeekedViewConreoller;

@end


@interface  ExerciseModeCollectionViewCell: UICollectionViewCell

@property (nonatomic, strong) UILabel *modeTitle;

@property (nonatomic, strong) UIImageView *modeImageView;

- (void)updateUIByQuestionIndex:(NSInteger)index;

//是否是当前焦点，根据跳转过来时的index判断
- (void)updateUIByQuestionIndex:(NSInteger)index;


@end
