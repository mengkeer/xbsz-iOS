//
//  CampusNoteModel.m
//  xbsz
//
//  Created by 陈鑫 on 17/2/24.
//  Copyright © 2017年 lotus. All rights reserved.
//

#import "CampusNote.h"

@implementation CampusNote

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"noteID":@"noteId",@"user":@"userInfo",@"time":@"updatedAt"};
}


@end
