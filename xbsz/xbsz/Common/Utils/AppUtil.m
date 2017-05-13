//
//  AppUtil.m
//  xbsz
//     
//  Created by lotus on 2017/5/13.
//  Copyright © 2017年 lotus. All rights reserved.
//

#import "AppUtil.h"

@implementation AppUtil


+ (BOOL)isAfterTimeNode{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyyy-MM-dd";
    NSDate *date = [formatter dateFromString:@"2017-6-11"];
    
    NSDate *now = [NSDate date];
    if([now compare:date] == NSOrderedAscending || [now compare:date] == NSOrderedSame){
        return NO;
    }
    return YES;
}

@end
