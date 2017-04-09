//
//  CampusNoteList.m
//  xbsz
//
//  Created by 陈鑫 on 17/2/24.
//  Copyright © 2017年 lotus. All rights reserved.
//

#import "CampusNoteList.h"
#import "CampusNote.h"

@implementation CampusNoteList


+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{
        @"notes":CampusNote.class
    };
}

@end
