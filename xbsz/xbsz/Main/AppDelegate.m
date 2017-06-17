//
//  AppDelegate.m
//  xbsz
//
//  Created by lotus on 2016/12/2.
//  Copyright © 2016年 lotus. All rights reserved.
//

#import "AppDelegate.h"
#import "CXLaunchViewController.h"
#import "CXNetworkMonitoring.h"
#import <Bugly/Bugly.h>         //集成bugly服务
#import "CXNetwork+User.h"
#import "DownloadManager.h"
#import "CXUserDefaults.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = [CXLaunchViewController controller];
    [self.window makeKeyAndVisible];
    
    [CXNetworkMonitoring startNetworkMonitoring];
    
    [Bugly startWithAppId:BuglyAppID];         //集成bugly服务
    [self JWRefreshLogin];
    if([DownloadManager isTikuExpired])    [[DownloadManager manager] downloadTikuFromServer];
    [CXUserDefaults setDefaultspreference];         //设置默认偏好设置
    
    return YES;
}


//进入前台时重新获取教务网CASTGC参数   类似于Token
- (void)applicationWillEnterForeground:(UIApplication *)application{
    [self JWRefreshLogin];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - private method
- (void)JWRefreshLogin{
    [CXNetwork JWRefreshLogin:nil success:^(NSObject *obj) {
        CXLog(@"刷新Token成功");
    } failure:^(NSError *error) {
        CXLog(@"刷新获取Token失败");
    }];
}

@end
