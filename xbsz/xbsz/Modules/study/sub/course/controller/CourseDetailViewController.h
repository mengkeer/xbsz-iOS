//
//  CourseDetailViewController.h
//  xbsz
//
//  Created by lotus on 14/03/2017.
//  Copyright © 2017 lotus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CXWhitePushViewController.h"
#import "Course.h"


@interface CourseDetailViewController : CXWhitePushViewController

@property (nonatomic, strong) Course *course;

@end
