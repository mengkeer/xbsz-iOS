//
//  CXNetwork+System.m
//  xbsz
//
//  Created by lotus on 2017/5/16.
//  Copyright © 2017年 lotus. All rights reserved.
//

#import "CXNetwork+System.h"

@implementation CXNetwork (System)

+ (void)getInforms:(NSInteger)status
           success:(CXNetworkSuccessBlock)success
           failure:(CXNetworkFailureBlock)failure{
    
    [self invokePostRequest:CXGetSystemInforms parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        CXBaseResponseModel *rsp = [CXBaseResponseModel yy_modelWithDictionary:(NSDictionary *)responseObject];
        CallbackRsp(rsp);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [[CXLocalUser instance] reset];
        InvokeFailure(error);
    }];
    
    
}

@end
