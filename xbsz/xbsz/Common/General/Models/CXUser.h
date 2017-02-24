//
//  CXUser.h
//  xbsz
//
//  Created by 陈鑫 on 17/2/24.
//  Copyright © 2017年 lotus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CXUser : NSObject

@property (nonatomic, copy) NSString *userID;
@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *password;
@property (nonatomic, copy) NSString *avatar;                   //头像
@property (nonatomic, copy) NSString *nickName;
@property (nonatomic, assign) NSInteger gender;
@property (nonatomic, copy) NSString *email;
@property (nonatomic, copy) NSString *mobile;                   //电话
@property (nonatomic, copy) NSString *major;
@property (nonatomic, copy) NSString *birthday;
@property (nonatomic, copy) NSString *brief;
@property (nonatomic, copy) NSString *district;                 //家庭住址

@property (nonatomic, assign) NSInteger fans;       //粉丝数
@property (nonatomic, assign) NSInteger concerns;       //关注数目

@property (nonatomic, copy) NSString *createAt;
@property (nonatomic, copy) NSString *updateAt;

@end
