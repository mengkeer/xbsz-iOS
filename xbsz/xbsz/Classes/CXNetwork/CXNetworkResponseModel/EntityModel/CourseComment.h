//
//  CourseComment.h
//  xbsz
//
//  Created by lotus on 2017/4/20.
//  Copyright © 2017年 lotus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CXUser.h"

@interface CourseComment : NSObject

@property (nonatomic, copy) NSString *courseID;

@property (nonatomic, copy) NSString *userID;

@property (nonatomic, copy) NSString *avatar;

@property (nonatomic, copy) NSString *nickname;

@property (nonatomic, copy) NSString *content;

@property (nonatomic, assign) NSInteger status;

@property (nonatomic, assign) CGFloat point;

@property (nonatomic, strong) NSDate *time;

//@property (nonatomic, strong) CXUser *userInfo;

@end
