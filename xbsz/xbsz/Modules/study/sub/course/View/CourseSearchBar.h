//
//  CourseSearchBar.h
//  xbsz
//
//  Created by 陈鑫 on 17/3/13.
//  Copyright © 2017年 lotus. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void (^SearchBarActionBlock)();

@interface CourseSearchBar : UIView

- (void)setClicked:(SearchBarActionBlock)action;

@end
