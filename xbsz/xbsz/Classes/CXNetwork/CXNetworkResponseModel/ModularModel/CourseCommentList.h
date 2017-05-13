//
//  CourseCommentList.h
//  xbsz
//
//  Created by lotus on 2017/4/21.
//  Copyright © 2017年 lotus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CXPage.h"

@interface CourseCommentList : NSObject

@property (nonatomic, strong) NSMutableArray *comments;

@property (nonatomic, strong)  CXPage *pageInfo;
@end
