//
//  CXNetwork+User.m
//  xbsz
//
//  Created by lotus on 2017/4/7.
//  Copyright © 2017年 lotus. All rights reserved.
//

#import "CXNetwork+User.h"

@implementation CXNetwork (User)

//登录成功则保存token  失败则重置本地用户
+ (void)userLogin:(NSString *)username
         password:(NSString *)password
          success:(CXNetworkSuccessBlock)success
          failure:(CXNetworkFailureBlock)failure{
    
    NSDictionary *parameters = @{@"userName": username, @"password":password};
    [self invokePostRequest:CXLoginUrl parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        CXBaseResponseModel *rsp = [CXBaseResponseModel yy_modelWithDictionary:(NSDictionary *)responseObject];
        [self saveToken:rsp.data];
        CallbackRsp(rsp);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [[CXLocalUser instance] reset];
        InvokeFailure(error);
    }];
}

+ (void)userRegister:(NSString *)username
            password:(NSString *)password
            nickname:(NSString *)nickname
             success:(CXNetworkSuccessBlock)success
             failure:(CXNetworkFailureBlock)failure{
    
    NSDictionary *parameters = @{@"userName":username,@"password":password,@"nickname":nickname};
    [self invokePostRequest:CXRegisterUrl parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        CXBaseResponseModel *rsp = [CXBaseResponseModel yy_modelWithDictionary:responseObject];
        CallbackRsp(rsp);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        InvokeFailure(error);
    }];
}

+ (void)getUserInfo:(NSString *)token
            success:(CXNetworkSuccessBlock)success
            failure:(CXNetworkFailureBlock)failure{
    
    NSDictionary *parameters = @{@"token":token};
    [self invokePostRequest:CXGetUserInfoUrl parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        CXBaseResponseModel *rsp = [CXBaseResponseModel yy_modelWithDictionary:responseObject];
        [self saveUserInfo:((NSDictionary *)responseObject)[@"data"]];
        CallbackRsp(rsp);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        InvokeFailure(error);
    }];
}

+ (void)updateUserInfo:(NSString *)token
            parameters:(NSMutableDictionary *)parameters
               success:(CXNetworkSuccessBlock)success
               failure:(CXNetworkFailureBlock)failure{
    [parameters setValue:token forKey:@"token"];
    [self invokePostRequest:CXUpdateUserInfoUrl parameters:[parameters copy] success:^(NSURLSessionDataTask *task, id responseObject) {
        CXBaseResponseModel *rsp = [CXBaseResponseModel yy_modelWithDictionary:responseObject];
        [self saveUserInfo:((NSDictionary *)responseObject)[@"data"]];
        CallbackRsp(rsp);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        InvokeFailure(error);
    }];
}


+ (void)JWLogin:(NSString *)username
       password:(NSString *)password
        success:(CXNetworkSuccessBlock)success
        failure:(CXNetworkFailureBlock)failure{
    NSDictionary *parameters = @{@"username": username, @"password":password,
                                 @"apnsKey":JWAPNSKey,@"serialNo":JWSerialNo};
    
    [self invokeUnsafePOSTRequest:JWLoginUrl parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        // 获取所有数据报头信息
        NSHTTPURLResponse *HTTPResponse = (NSHTTPURLResponse *)task.response;
        NSDictionary *fields = [HTTPResponse allHeaderFields];// 原生NSURLConnection写法
        
        NSString *cookieString = [fields valueForKey:@"ssoCookie"];
        NSArray *arr = [cookieString JSONValue];
        NSString *CASTGC = [[arr objectAtIndex:0] valueForKey:@"cookieValue"];
        NSString *JWSessionID = [fields valueForKey:@"Set-Cookie"];
        JWSessionID = [JWSessionID stringByReplacingOccurrencesOfString:@"JSESSIONID=" withString:@""];
        JWSessionID = [JWSessionID stringByReplacingOccurrencesOfString:@"; Path=/; Secure" withString:@""];
        NSString *userPwd = [fields valueForKey:@"userPwd"];            //获取加密后的密码
        
        JWLocalUser *user = [JWLocalUser instance];
        user.JWUsername = username;
        user.JWPassword = password;             //明文密码
        user.JWEncryptPassword = userPwd;
        user.JWCastgc = CASTGC;
        if(JWSessionID)     user.JWSessionID = JWSessionID;
        user.time = [[NSDate new] stringWithFormat:@"yyyy-MM-dd HH:mm"];
        [user save];
        
        success(task.response);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [[JWLocalUser instance] reset];             //如果登录失败将此前本地教务网账号信息重置
        InvokeFailure(error);
    }];
}

+ (void)JWRefreshLogin:(NSString *)url
               success:(CXNetworkSuccessBlock)success
               failure:(CXNetworkFailureBlock)failure{
    JWLocalUser *user = [JWLocalUser instance];
    if(![user isAuthorized])    return;
    
    //需要注入的Cookie
    NSString *cookieStr;
    if(![JWLocalUser instance].JWSessionID){
        cookieStr = [NSString stringWithFormat:@"CASTGC=%@",[JWLocalUser instance].JWCastgc];
    }else{
        cookieStr = [NSString stringWithFormat:@"JSESSIONID=%@;CASTGC=%@",[JWLocalUser instance].JWSessionID,[JWLocalUser instance].JWCastgc];
    }
    
    NSDictionary *parameters = @{@"username": user.JWUsername, @"password":user.JWEncryptPassword,
                                @"serialNo":JWSerialNo};

    [self invokeUnsafePOSTRequest:JWRefreshLoginURL parameters:parameters cookieStr:cookieStr success:^(NSURLSessionDataTask *task, id responseObject) {
        // 获取所有数据报头信息
        NSHTTPURLResponse *HTTPResponse = (NSHTTPURLResponse *)task.response;
        NSDictionary *fields = [HTTPResponse allHeaderFields];
        
        NSString *cookieString = [fields valueForKey:@"ssoCookie"];
        NSArray *arr = [cookieString JSONValue];
        NSString *CASTGC = [[arr objectAtIndex:0] valueForKey:@"cookieValue"];
        
        NSString *JWSessionID = [fields valueForKey:@"Set-Cookie"];
        JWSessionID = [JWSessionID stringByReplacingOccurrencesOfString:@"JSESSIONID=" withString:@""];
        JWSessionID = [JWSessionID stringByReplacingOccurrencesOfString:@"; Path=/; Secure" withString:@""];
        
        JWLocalUser *user = [JWLocalUser instance];
        user.JWCastgc = CASTGC;
        if(JWSessionID != nil)  user.JWSessionID = JWSessionID;
        [user save];
        success(task.response);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        InvokeFailure(error);
    }];
}

//登录成功则保存token  失败则重置本地用户
+ (void)saveToken:(NSDictionary *)data{
    if(!data){
        [[CXLocalUser instance] reset];
        return;
    }
    if([data containsObjectForKey:@"token"]){
        NSString *token = [data valueForKey:@"token"];
        if([token isEqualToString:@""])     [[CXLocalUser instance] reset];
        [CXLocalUser instance].token = token;
        [[CXLocalUser instance] save];
    }else{
        [[CXLocalUser instance] reset];
    }
}

+ (void)saveUserInfo:(NSDictionary *)data{
    if(data && [data containsObjectForKey:@"userInfo"]){
        CXLocalUser *user = [CXLocalUser yy_modelWithDictionary:data[@"userInfo"]];
        [[CXLocalUser instance] save:user];
    }
}

@end
