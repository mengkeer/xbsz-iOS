//
//  CXNetwork.m
//  xbsz
//
//  Created by lotus on 2017/4/7.
//  Copyright © 2017年 lotus. All rights reserved.
//

#import "CXNetwork.h"

static id _instance = nil;

@implementation CXNetwork

+ (instancetype)instance{
    static CXNetwork *_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[CXNetwork alloc] init];
    });
    return _instance;
}


+ (AFHTTPSessionManager *)manager{
    static AFHTTPSessionManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [AFHTTPSessionManager manager];
        instance.requestSerializer.timeoutInterval = 10.f;
    });
    return instance;
}

+ (AFHTTPSessionManager *)unsafeManager{
    static AFHTTPSessionManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [AFHTTPSessionManager manager];
        instance.securityPolicy.allowInvalidCertificates = YES; // not recommended for production
        instance.securityPolicy.validatesDomainName = NO;//不验证证书的域名
        instance.requestSerializer.timeoutInterval = 10.f;
    });
    return instance;
}

+ (void)invokePostRequest:(NSString *)url
               parameters:(NSDictionary *)parameters
                  success:(CXRequestSuccessBlock)success
                  failure:(CXRequestFailureBlock)failure{
    AFHTTPSessionManager *manager = [self manager];
    
    [manager POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nullable task, id _Nullable responseObject) {
        if(success){
            success(task,responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if(failure){
            failure(task,error);
        }
    }];
}


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
    AFHTTPSessionManager *manager = [self unsafeManager];
    if(cookieStr != nil)    [manager.requestSerializer setValue:cookieStr forHTTPHeaderField:@"Cookie"];
    
    [manager POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nullable task, id _Nullable responseObject) {
        if(success){
            success(task,responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if(failure){
           failure(task,error);
        }
    }];
}

+(NSError*) netWorkErrorWithCode:(NSInteger) code message:(NSString*) message{
    
    if(code == CXResponseCodeTokenIsExpired){
        [[CXLocalUser instance] reset];
    }
    NSError *newError = [NSError errorWithDomain:@"CXNetWorkResponseError" code:code userInfo:[NSDictionary dictionaryWithObject:message?message:@"" forKey:NSLocalizedDescriptionKey]];
    return newError;
}

@end
