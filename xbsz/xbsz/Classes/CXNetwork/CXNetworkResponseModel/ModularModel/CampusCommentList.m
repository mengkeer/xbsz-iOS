//
//  NoteCommentList.m
//  xbsz
//
//  Created by lotus on 2017/5/18.
//  Copyright © 2017年 lotus. All rights reserved.
//

#import "CampusCommentList.h"
#import "CampusComment.h"

@implementation CampusCommentList

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"comments":@"threadNotes"};
}

+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{
             @"comments":CampusComment.class
             };
}


@end
