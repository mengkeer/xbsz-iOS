//
//  CXNetwork+System.h
//  xbsz
//
//  Created by lotus on 2017/5/16.
//  Copyright © 2017年 lotus. All rights reserved.
//

#import "CXNetwork.h"

@interface CXNetwork (System)

//status  做保留字段 暂时没用
+ (void)getInforms:(NSInteger)status
                   success:(CXNetworkSuccessBlock)success
                   failure:(CXNetworkFailureBlock)failure;

@end
