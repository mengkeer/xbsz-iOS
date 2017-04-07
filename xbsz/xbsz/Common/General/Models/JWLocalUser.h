//
//  JWLocalUser.h
//  xbsz
//
//  Created by lotus on 2017/4/7.
//  Copyright © 2017年 lotus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JWLocalUser : NSObject

//教务网账号
@property (nonatomic, copy) NSString *JWUserName;
//教务网明文密码
@property (nonatomic, copy) NSString *JWPassword;
//教务网加密后的密码
@property (nonatomic, copy) NSString *JWEncryptPassword;
//教务网CASTGC
@property (nonatomic, copy) NSString *JWCastgc;
//Session
@property (nonatomic, copy) NSString *JWSessionID;
//上次授权时间
@property (nonatomic, copy) NSString *time;

//单例
+ (JWLocalUser *)instance;

//读取用户信息
+ (id)read;

//保存用户信息
- (BOOL)save;

//重置用户信息，登出
- (void)reset;

//是否登录
- (BOOL)isAuthorized;

@end
