//
//  NSString+CXAdd.m
//  xbsz
//
//  Created by 陈鑫 on 17/3/7.
//  Copyright © 2017年 lotus. All rights reserved.
//

#import "NSString+CXAdd.h"

@implementation NSString (CXAdd)

//将服务器端的时间转化为在客户端上显示的时间

- (NSString *)convertToLocalTime{

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyyy-MM-dd HH-mm-ss";
    NSDate *date = [formatter dateFromString:self];
    
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
    
    return self;;
}

- (id)JSONValue{
    NSData* data = [self dataUsingEncoding:NSUTF8StringEncoding];
    __autoreleasing NSError* error = nil;
    id result = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    if (error != nil) return nil;
    return result;
}

+ (NSString *)getAvatarUrl:(NSString *)imagename{
    if(imagename == nil || [imagename isEqualToString:@""]){
        return CXDefaultUserAvatarUrl;
    }else{
        return [NSString stringWithFormat:@"%@/%@",CXAvatarsBaseUrl,imagename];

    }
}

@end
