//
//  ExerciseDetailViewController.h
//  xbsz
//
//  Created by lotus on 18/03/2017.
//  Copyright © 2017 lotus. All rights reserved.
//

#import "CXWhitePushViewController.h"
#import "Exercise.h"

@interface ExerciseDetailViewController : CXWhitePushViewController

- (void)updateDetailWithCourse:(Exercise *)exercise;

@end
