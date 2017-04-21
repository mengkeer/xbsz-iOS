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
//300表示请求成功  不要问我为什么  是后端要这么做的  他不喜欢200这个数字
#define CallbackRsp(rsp)  { \
        if (!rsp) { \
            NSError * err = [CXNetwork netWorkErrorWithCode:rsp.code message:@"返回数据为空"];\
            InvokeFailure(err); \
            return ; \
        }\
        if(rsp.code == 300) { \
            InvokeSuccess(rsp.data); \
        }else { \
            NSError * err = [CXNetwork netWorkErrorWithCode:rsp.code message:rsp.errMsg];\
            InvokeFailure(err); \
        } \
    }


@interface CXNetwork : NSObject

+ (instancetype)instance;

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
