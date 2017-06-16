//
//  LocalUser.m
//  xbsz
//
//  Created by 陈鑫 on 17/2/24.
//  Copyright © 2017年 lotus. All rights reserved.
//

#import "CXLocalUser.h"


static CXLocalUser *instance = nil;

@implementation CXLocalUser

+(instancetype)instance{
    
    @synchronized (self)
    {
        if (instance == nil) {
            instance = [CXLocalUser read];
            if (instance ==nil) {
                instance = [[CXLocalUser alloc]init];
            }
        }
    };
    return instance;
}

+(id)read{
    NSString *path = [NSString stringWithFormat:@"%@/Documents/UserInfo.dat", NSHomeDirectory()];
    //序列化
    //房序列化
    NSData *data2 = [NSData dataWithContentsOfFile:path];//读取文件
    id t = [NSKeyedUnarchiver unarchiveObjectWithData:data2];//反序列化
    return t;
}

- (BOOL)save{
    
    NSString *path = [NSString stringWithFormat:@"%@/Documents/UserInfo.dat", NSHomeDirectory()];
    //序列化
    //房序列化
    return [NSKeyedArchiver archiveRootObject:instance toFile:path];
}



- (BOOL)save:(CXUser *)user{
    instance.userID = user.userID;
    instance.username = user.username;
    instance.avatar = user.avatar;
    instance.nickname = user.nickname;
    instance.truename = user.truename;
    instance.studentID = user.studentID;
    instance.gender = user.gender;
    instance.email = user.email;
    instance.mobile = user.mobile;
    instance.major = user.major;
    instance.birthday = user.birthday;
    instance.signature = user.signature;
    instance.brief = user.brief;
    instance.district = user.district;

    return [self save];
}

- (void)reset{
    instance = [[CXLocalUser alloc] init];
    [instance save];
}

- (BOOL)isLogin {
    if (![instance.userID isEqualToString:@"null"] && instance.userID.length>0 && ![instance.token isEqualToString:@"null"] && instance.token.length>0) {
        return YES;
    }
    return NO;
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.token forKey:@"token"];
    [aCoder encodeObject:self.userID forKey:@"userID"];
    [aCoder encodeObject:self.studentID forKey:@"studentID"];
    [aCoder encodeObject:self.username forKey:@"username"];
    [aCoder encodeObject:self.nickname forKey:@"nickname"];
    [aCoder encodeObject:self.truename forKey:@"truename"];
    [aCoder encodeObject:self.avatar forKey:@"avatar"];
    [aCoder encodeObject:[NSNumber numberWithInteger:self.gender] forKey:@"gender"];
    [aCoder encodeObject:self.email forKey:@"email"];
    [aCoder encodeObject:self.mobile forKey:@"mobile"];
    [aCoder encodeObject:self.major forKey:@"major"];
    [aCoder encodeObject:self.birthday forKey:@"birthday"];
    [aCoder encodeObject:self.district forKey:@"district"];
    [aCoder encodeObject:self.brief forKey:@"brief"];
    [aCoder encodeObject:self.signature forKey:@"signature"];
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        self.token = [aDecoder decodeObjectForKey:@"token"];
        self.userID = [aDecoder decodeObjectForKey:@"userID"];
        self.studentID = [aDecoder decodeObjectForKey:@"studentID"];
        self.username = [aDecoder decodeObjectForKey:@"username"];
        self.nickname = [aDecoder decodeObjectForKey:@"nickname"];
        self.truename = [aDecoder decodeObjectForKey:@"truename"];
        self.avatar = [aDecoder decodeObjectForKey:@"avatar"];
        self.gender = [(NSNumber *)[aDecoder decodeObjectForKey:@"gender"] integerValue];
        self.email = [aDecoder decodeObjectForKey:@"email"];
        self.mobile = [aDecoder decodeObjectForKey:@"mobile"];
        self.major = [aDecoder decodeObjectForKey:@"major"];
        self.birthday = [aDecoder decodeObjectForKey:@"birthday"];
        self.brief = [aDecoder decodeObjectForKey:@"brief"];
        self.district = [aDecoder decodeObjectForKey:@"district"];
        self.signature = [aDecoder decodeObjectForKey:@"signature"];
    }
    return self;
}

@end
