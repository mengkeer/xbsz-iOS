//
//  CourseCatalogViewController.h
//  xbsz
//
//  Created by 陈鑫 on 17/3/21.
//  Copyright © 2017年 lotus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Course.h"

@interface CourseCatalogViewController : UIViewController

@property (nonatomic, strong) Course *course;

@property (nonatomic, weak) id<UIScrollViewDelegate> delegate;

@end
