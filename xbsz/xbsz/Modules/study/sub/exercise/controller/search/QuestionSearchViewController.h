//
//  SearchViewController.h
//  xbsz
//
//  Created by lotus on 2017/4/27.
//  Copyright © 2017年 lotus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ExerciseMode.h"
#import "CXWhitePushViewController.h"

@interface QuestionSearchViewController : CXWhitePushViewController

@property (nonatomic, assign) ExerciseType type;

@property (nonatomic, copy) NSString *searchText;

@end


@interface QuestionSearchTableViewCell : UITableViewCell

- (void)updateUIWithIndex:(NSInteger)index content:(NSString *)text;

@end
