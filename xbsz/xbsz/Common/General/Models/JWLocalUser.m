//
//  JWLocalUser.m
//  xbsz
//
//  Created by lotus on 2017/4/7.
//  Copyright © 2017年 lotus. All rights reserved.
//

#import "JWLocalUser.h"

static JWLocalUser *instance = nil;

@implementation JWLocalUser

+(instancetype)instance{
    
    @synchronized (self)
    {
        if (instance == nil) {
            instance = [JWLocalUser read];
            if (instance ==nil) {
                instance = [[JWLocalUser alloc] init];
            }
        }
    };
    return instance;
}

+(id)read{
    NSString *path = [NSString stringWithFormat:@"%@/Documents/JWUserInfo.dat", NSHomeDirectory()];
    //序列化
    //房序列化
    NSData *data2 = [NSData dataWithContentsOfFile:path];//读取文件
    id t = [NSKeyedUnarchiver unarchiveObjectWithData:data2];//反序列化
    return t;
}

-(BOOL)save{
    
    NSString *path = [NSString stringWithFormat:@"%@/Documents/JWUserInfo.dat", NSHomeDirectory()];
    //序列化
    //房序列化
    return [NSKeyedArchiver archiveRootObject:instance toFile:path];
}

-(void)reset{
    instance = [[JWLocalUser alloc] init];
    [instance save];
}

- (BOOL)isAuthorized {
    if (self != nil && ![instance.JWUserName isEqualToString:@"null"] && instance.JWUserName.length>0 && ![instance.JWPassword isEqualToString:@"null"] && instance.JWPassword.length>0) {
        return YES;
    }
    return NO;
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.JWUserName forKey:@"JWUserName"];
    [aCoder encodeObject:self.JWPassword forKey:@"JWPassword"];
    [aCoder encodeObject:self.JWEncryptPassword forKey:@"JWEncryptPassword"];
    [aCoder encodeObject:self.JWCastgc forKey:@"JWCastgc"];
    [aCoder encodeObject:self.JWSessionID forKey:@"JWSessionID"];
    [aCoder encodeObject:self.time forKey:@"time"];
}
- (id)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        self.JWUserName = [aDecoder decodeObjectForKey:@"JWUserName"];
        self.JWPassword = [aDecoder decodeObjectForKey:@"JWPassword"];
        self.JWEncryptPassword = [aDecoder decodeObjectForKey:@"JWEncryptPassword"];
        self.JWCastgc = [aDecoder decodeObjectForKey:@"JWCastgc"];
        self.JWSessionID = [aDecoder decodeObjectForKey:@"JWSessionID"];
        self.time = [aDecoder decodeObjectForKey:@"time"];
    }
    return self;
}

@end
