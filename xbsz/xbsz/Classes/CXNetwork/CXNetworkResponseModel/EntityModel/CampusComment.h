//
//  CampusComment.h
//  xbsz
//
//  Created by 陈鑫 on 17/3/7.
//  Copyright © 2017年 lotus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CXUser.h"

@interface CampusComment : NSObject

@property (nonatomic, copy) NSString *noteID;

@property (nonatomic, copy) NSString *userID;

@property (nonatomic, copy) NSString *content;

@property (nonatomic, copy) NSString *avatar;

@property (nonatomic, copy) NSString *nickname;

@property (nonatomic, strong) NSDate *time;

@end
