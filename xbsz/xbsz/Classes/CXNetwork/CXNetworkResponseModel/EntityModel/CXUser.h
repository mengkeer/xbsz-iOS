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
@property (nonatomic, copy) NSString *username;             //登录名
@property (nonatomic, copy) NSString *studentID;        //学号
@property (nonatomic, copy) NSString *avatar;                   //头像
@property (nonatomic, copy) NSString *nickname;                 //昵称
@property (nonatomic, copy) NSString *truename;                 //真实姓名
@property (nonatomic, assign) NSInteger gender;
@property (nonatomic, copy) NSString *email;
@property (nonatomic, copy) NSString *mobile;                   //电话
@property (nonatomic, copy) NSString *major;
@property (nonatomic, copy) NSString *birthday;
@property (nonatomic, copy) NSString *signature;                    //个性签名
@property (nonatomic, copy) NSString *brief;                        //个人简介      特指老师的介绍 其履历 教学范围等
@property (nonatomic, copy) NSString *district;                 //家庭住址

@property (nonatomic, assign) NSInteger fans;       //粉丝数
@property (nonatomic, assign) NSInteger concerns;       //关注数目

@end
