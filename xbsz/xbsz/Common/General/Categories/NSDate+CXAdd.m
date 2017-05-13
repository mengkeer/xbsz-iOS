//
//  NSDate+CXAdd.m
//  xbsz
//
//  Created by lotus on 2017/5/12.
//  Copyright © 2017年 lotus. All rights reserved.
//

#import "NSDate+CXAdd.h"

@implementation NSDate (CXAdd)


- (NSString *)convertToLocalTime{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyyy-MM-dd HH-mm-ss";
    NSDate *date = self;
    
    NSDate *now = [NSDate date];
    
    if([date isToday]){
        formatter.dateFormat = @"今天HH:mm";
        return [formatter stringFromDate:date];
    }
    
    if([date isYesterday]){
        formatter.dateFormat = @"昨天HH:mm";
        return [formatter stringFromDate:date];
    }
    
    if([[date dateByAddingDays:2] isToday]){
        formatter.dateFormat = @"前天HH:mm";
        return [formatter stringFromDate:date];
    }
    
    if(date.year == now.year ){
        formatter.dateFormat = @"MM-dd HH:mm";
        return [formatter stringFromDate:date];
    }
    
    if(date.year < now.year ){
        formatter.dateFormat = @"yyyy-MM-dd";
        return [formatter stringFromDate:date];
    }
    
    return [self stringWithFormat:@"yyyy-MM-dd"];;
}

@end
