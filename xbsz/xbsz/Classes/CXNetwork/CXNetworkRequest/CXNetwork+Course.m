//
//  CXNetwork+Course.m
//  xbsz
//
//  Created by lotus on 2017/4/24.
//  Copyright © 2017年 lotus. All rights reserved.
//

#import "CXNetwork+Course.h"

@implementation CXNetwork (Course)

+ (void)getCoursesByStatus:(NSInteger)status
                   success:(CXNetworkSuccessBlock)success
                   failure:(CXNetworkFailureBlock)failure{
    NSDictionary *parameters = nil;
    if(status >= 0){
         parameters = @{@"status": [NSString stringWithFormat:@"%ld",status]};
    }
    
    [self invokePostRequest:CXGetCoursesUrl parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        CXBaseResponseModel *rsp = [CXBaseResponseModel yy_modelWithDictionary:(NSDictionary *)responseObject];
        CallbackRsp(rsp);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [[CXLocalUser instance] reset];
        InvokeFailure(error);
    }];
}
@end
