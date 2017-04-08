//
//  CXNetwork+User.h
//  xbsz
//
//  Created by lotus on 2017/4/7.
//  Copyright © 2017年 lotus. All rights reserved.
//

#import "CXNetwork.h"
#import "CXNetwork.h"

@interface CXNetwork (User)

+ (void)JWLogin:(NSString *)username
       password:(NSString *)password
        success:(CXNetWorkSuccessBlock)success
        failure:(CXNetWorkFailureBlock)failure;
//注：该url不是必须  可置为nil  此处只是为了对称而已
+ (void)JWRefreshLogin:(NSString *)url
               success:(CXNetWorkSuccessBlock)success
               failure:(CXNetWorkFailureBlock)failure;

@end
