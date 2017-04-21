//
//  CourseCommentViewController.h
//  xbsz
//
//  Created by lotus on 2017/4/20.
//  Copyright © 2017年 lotus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Course.h"

@interface CourseCommentViewController : UIViewController

@property (nonatomic, strong) Course *course;

@property (nonatomic, weak) id<UIScrollViewDelegate> baseDelegate;

@end
