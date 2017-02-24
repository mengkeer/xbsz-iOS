//
//  LocalUser.h
//  xbsz
//
//  Created by 陈鑫 on 17/2/24.
//  Copyright © 2017年 lotus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CXUser.h"

@interface CXLocalUser : CXUser

//Token
@property (nonatomic, copy) NSString *token;

//第三方登录时的openID
@property (nonatomic, copy) NSString *openID;

//记录上次登录防暑
@property (nonatomic, copy) NSString *loginType;



@end
