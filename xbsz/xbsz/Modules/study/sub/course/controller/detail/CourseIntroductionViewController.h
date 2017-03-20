//
//  CourseIntroductionController.h
//  xbsz
//
//  Created by 陈鑫 on 17/3/17.
//  Copyright © 2017年 lotus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Course.h"

@interface CourseIntroductionViewController : UIViewController

@property (nonatomic, strong) Course *course;

@property (nonatomic, weak) id<UIScrollViewDelegate> delegate;

@end
