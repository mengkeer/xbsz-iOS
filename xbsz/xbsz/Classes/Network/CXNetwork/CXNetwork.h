//
//  CXNetwork.h
//  xbsz
//
//  Created by lotus on 2017/4/7.
//  Copyright © 2017年 lotus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CXBaseResponseModel.h"

typedef void (^CXRequestSuccessBlock)(NSURLSessionDataTask * task, id responseObject);
typedef void (^CXRequestFailureBlock)(NSURLSessionDataTask *task, NSError *error);

typedef void (^CXNetworkSuccessBlock)(NSObject *obj);
typedef void (^CXNetworkFailureBlock)(NSError *error);

#define DefaultPageSize     (20) //默认分页大小

#define InvokeSuccess(e)    {if(success) dispatch_async(dispatch_get_main_queue(), ^{success(e);});}
#define InvokeFailure(e)    {if(failure) dispatch_async(dispatch_get_main_queue(), ^{failure(e);});}
#define CallbackRsp(rsp)  { \
        if (!rsp) { \
            NSDictionary * userInfo = [NSDictionary dictionaryWithObject:@"rsp = nil" forKey:NSLocalizedDescriptionKey]; \
            NSError * err = [[NSError alloc] initWithDomain:@"CXNetWorkError" code:-1 userInfo:userInfo]; \
            InvokeFailure(err); \
            return ; \
        }\
        if (rsp.code == 200) { \
            InvokeSuccess(rsp.data); \
        }else { \
            NSError * err = [CXNetwork netWorkErrorWithCode:rsp.code message:rsp.errMsg];\
            InvokeFailure(err); \
        } \
    }


@interface CXNetwork : NSObject

+ (void)invokePostRequest:(NSString *)url
               parameters:(NSDictionary *)parameters
                  success:(CXRequestSuccessBlock)success
                  failure:(CXRequestFailureBlock)failure;

+ (void)invokeUnsafePOSTRequest:(NSString *)url
                     parameters:(NSDictionary *)parameters
                        success:(CXRequestSuccessBlock)success
                        failure:(CXRequestFailureBlock)failure;

+ (void)invokeUnsafePOSTRequest:(NSString *)url
                     parameters:(NSDictionary *)parameters
                      cookieStr:(NSString *)cookieStr
                        success:(CXRequestSuccessBlock)success
                        failure:(CXRequestFailureBlock)failure;

+ (NSError *)netWorkErrorWithCode:(NSInteger)code message:(NSString *)message;

@end
