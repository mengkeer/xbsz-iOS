//
//  CampusComment.m
//  xbsz
//
//  Created by 陈鑫 on 17/3/7.
//  Copyright © 2017年 lotus. All rights reserved.
//

#import "CampusComment.h"

@implementation CampusComment

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"noteID":@"noteId",@"time":@"createdAt",@"avatar":@"userInfo.avatar",@"nickname":@"userInfo.nickname"};
}


@end
