//
//  CXNetworkMonitoring.m
//  idemo
//
//  Created by lotus on 06/12/2016.
//  Copyright © 2016 lotus. All rights reserved.
//

#import "CXNetworkMonitoring.h"
#import "AFNetworkReachabilityManager.h"

static AFNetworkReachabilityStatus status = -1;

@interface CXNetworkMonitoring ()

@end

@implementation CXNetworkMonitoring

+ (void)startNetworkMonitoring{
    
    AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
    [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        // 当网络状态发生改变的时候调用这个block
        [self setStatus:status];
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWiFi:{
                CXLog(@"切换至WIFI状态");
                break;
            }
            case AFNetworkReachabilityStatusReachableViaWWAN:
            {
                YYReachability *reach = [YYReachability reachability];
                YYReachabilityWWANStatus wwanStatus = reach.wwanStatus;
                switch (wwanStatus) {
                    case YYReachabilityWWANStatusNone:
                    {
                        CXLog(@"切换至蜂窝网络");
                        break;
                    }
                    case YYReachabilityWWANStatus2G:
                    {
                        CXLog(@"切换至2G");
                        break;
                    }
                    case YYReachabilityWWANStatus3G:
                    {
                        CXLog(@"切换至3G");
                        break;
                    }
                    case YYReachabilityWWANStatus4G:
                    {
                        CXLog(@"切换至4G");
                        break;
                    }
                    default:
                        break;
                }
                
                break;
            }
            case AFNetworkReachabilityStatusNotReachable:
                CXLog(@"没有网络");
                break;
            case AFNetworkReachabilityStatusUnknown:
                CXLog(@"未知网络");
                break;
            default:
                break;
        }
    }];
    // 开始监控
    [mgr startMonitoring];
}

+ (AFNetworkReachabilityStatus)currentStatus{
    return status;
}

+ (BOOL)canReachable{
    if(status == AFNetworkReachabilityStatusReachableViaWiFi || status == AFNetworkReachabilityStatusReachableViaWWAN){
        return YES;
    }else{
        return NO;
    }
}

+ (BOOL)wifiOnly{
    if(status == AFNetworkReachabilityStatusReachableViaWiFi){
        return YES;
    }else{
        return NO;
    }
}

+ (void)setStatus:(AFNetworkReachabilityStatus)currentStatus{
    status = currentStatus;
}

@end
