//
//  CXNetwork.m
//  xbsz
//
//  Created by lotus on 2017/4/7.
//  Copyright © 2017年 lotus. All rights reserved.
//

#import "CXNetwork.h"

@implementation CXNetwork

+ (void)invokeUnsafePOSTRequest:(NSString *)url
                     parameters:(NSDictionary *)parameters
                        success:(CXRequestSuccessBlock)success
                        failure:(CXRequestFailureBlock)failure{
    [self invokeUnsafePOSTRequest:url parameters:parameters cookieStr:nil success:success failure:failure];
}
//Base Resquest Method   不验证网站证书与域名 例如12306等网站 
+ (void)invokeUnsafePOSTRequest:(NSString *)url
                     parameters:(NSDictionary *)parameters
                      cookieStr:(NSString *)cookieStr
                        success:(CXRequestSuccessBlock)success
                        failure:(CXRequestFailureBlock)failure{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.securityPolicy.allowInvalidCertificates = YES; // not recommended for production
    manager.securityPolicy.validatesDomainName = NO;//不验证证书的域名
    if(cookieStr != nil)    [manager.requestSerializer setValue:cookieStr forHTTPHeaderField:@"Cookie"];
    
    [manager POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nullable task, id _Nullable responseObject) {
        if(success){
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                success(task,responseObject);
            });
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if(failure){
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                failure(task,error);
            });
        }
    }];
}


@end
