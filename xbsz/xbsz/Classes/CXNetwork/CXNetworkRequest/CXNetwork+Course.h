//
//  CXNetwork+Course.h
//  xbsz
//
//  Created by lotus on 2017/4/24.
//  Copyright © 2017年 lotus. All rights reserved.
//

#import "CXNetwork.h"

@interface CXNetwork (Course)

//status: 课程的状态，不传为全部课程，0：未开启，1：已过时间，2：已开始，3：人数已满
+ (void)getCoursesByStatus:(NSInteger)status
                   success:(CXNetworkSuccessBlock)success
                   failure:(CXNetworkFailureBlock)failure;


+ (void)getCourseComments:(NSString *)courseID
                   offset:(NSInteger)offset
                    limit:(NSInteger)limit
                  success:(CXNetworkSuccessBlock)success
                  failure:(CXNetworkFailureBlock)failure;

+ (void)addCourseComment:(NSString *)courseID
                 content:(NSString *)content
                   point:(NSInteger)point
                 success:(CXNetworkSuccessBlock)success
                 failure:(CXNetworkFailureBlock)failure;

+ (void)getCourseWare:(NSString *)courseID
              success:(CXNetworkSuccessBlock)success
              failure:(CXNetworkFailureBlock)failure;

@end
