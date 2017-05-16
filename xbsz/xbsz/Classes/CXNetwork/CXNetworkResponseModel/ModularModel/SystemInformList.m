//
//  SystemInformList.m
//  xbsz
//
//  Created by lotus on 2017/5/16.
//  Copyright © 2017年 lotus. All rights reserved.
//

#import "SystemInformList.h"
#import "SystemInform.h"

@implementation SystemInformList

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"informs":@"inform"};
}

+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{
             @"informs":SystemInform.class
             };
}

@end
