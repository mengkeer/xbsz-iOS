//
//  CXNetwork+User.h
//  xbsz
//
//  Created by lotus on 2017/4/7.
//  Copyright © 2017年 lotus. All rights reserved.
//

#import "CXNetwork.h"

@interface CXNetwork (User)

+ (void)userLogin:(NSString *)username
         password:(NSString *)password
          success:(CXNetworkSuccessBlock)success
          failure:(CXNetworkFailureBlock)failure;

+ (void)userRegister:(NSString *)username
            password:(NSString *)password
            nickname:(NSString *)nickname
             success:(CXNetworkSuccessBlock)success
             failure:(CXNetworkFailureBlock)failure;

+ (void)getUserInfo:(NSString *)token
            success:(CXNetworkSuccessBlock)success
            failure:(CXNetworkFailureBlock)failure;

+ (void)updateUserInfo:(NSString *)token
           parameters:(NSMutableDictionary *)parameters
              success:(CXNetworkSuccessBlock)success
              failure:(CXNetworkFailureBlock)failure;

+ (void)updateUserAvatar:(UIImage *)image
                 success:(CXNetworkSuccessBlock)success
                 failure:(CXNetworkFailureBlock)failure;

+ (void)JWLogin:(NSString *)username
       password:(NSString *)password
        success:(CXNetworkSuccessBlock)success
        failure:(CXNetworkFailureBlock)failure;
//注：该url不是必须  可置为nil  此处只是为了对称而已
+ (void)JWRefreshLogin:(NSString *)url
               success:(CXNetworkSuccessBlock)success
               failure:(CXNetworkFailureBlock)failure;

@end
