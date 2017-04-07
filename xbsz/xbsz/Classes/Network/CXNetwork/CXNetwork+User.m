//
//  CXNetwork+User.m
//  xbsz
//
//  Created by lotus on 2017/4/7.
//  Copyright © 2017年 lotus. All rights reserved.
//

#import "CXNetwork+User.h"

@implementation CXNetwork (User)

+ (void)JWRefreshLogin{
    JWLocalUser *user = [JWLocalUser instance];
    if(![user isAuthorized])    return;
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.securityPolicy.allowInvalidCertificates = YES; // not recommended for production
    manager.securityPolicy.validatesDomainName = NO;//不验证证书的域名
    //设置Cookie
    NSString *cookieStr = [NSString stringWithFormat:@"JSESSIONID=%@;CASTGC=%@",[JWLocalUser instance].JWSessionID,[JWLocalUser instance].JWCastgc];
    [manager.requestSerializer setValue:cookieStr forHTTPHeaderField:@"Cookie"];
    
    NSDictionary *parameters = @{@"username": user.JWUserName, @"password":user.JWEncryptPassword,
                                @"serialNo":JWSerialNo};

    
    [manager POST:JWRefreshLoginURL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        // 获取所有数据报头信息
        NSHTTPURLResponse *HTTPResponse = (NSHTTPURLResponse *)task.response;
        NSDictionary *fields = [HTTPResponse allHeaderFields];// 原生NSURLConnection写法
        CXLog(@"fields = %@", [fields description]);
        
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
   
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        CXLog(@"重新获取CASTGC失效");
    }];
    

}

@end
