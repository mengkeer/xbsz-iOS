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
    self.window.backgroundColor = CXWhiteColor;
    self.window.rootViewController = [CXLaunchViewController controller];
//    self.window.rootViewController = [CXTabBarController    controller];
    [self.window makeKeyAndVisible];
    
    [CXNetworkMonitoring startNetworkMonitoring];
    
    [self create3DTouchItems];
    
    //通过3D Touch启动应用
    UIApplicationShortcutItem *shortcutItem = [launchOptions valueForKey:UIApplicationLaunchOptionsShortcutItemKey];
    //如果是从快捷选项标签启动app，则根据不同标识执行不同操作，然后返回NO，防止调用- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler
    if (shortcutItem) {
        if([shortcutItem.type isEqualToString:CX3DTouchItemTypeShare]){
            CXLog(@"通过3D Touch进入分享界面");
        } else if ([shortcutItem.type isEqualToString:CX3DTouchItemTypeSearch]) {//进入搜索界面
            CXLog(@"通过3D Touch进入搜索界面");
        } else if ([shortcutItem.type isEqualToString:CX3DTouchItemTypeLove]) {//进入收藏界面
            CXLog(@"通过3D Touch进入收藏界面");
        }else{
            CXLog(@"通过3D Touch反馈Bug");
        }
        return NO;
    }
    
//    [Bugly startWithAppId:BuglyAppID];         //集成bugly服务
    [self JWRefreshLogin];
    if(![DownloadManager isTikuExists])    [[DownloadManager manager] downloadTikuFromServer];
    [CXUserDefaults setDefaultspreference];         //设置默认偏好设置
    
    return YES;
}




- (void)create3DTouchItems{
    
    UIApplicationShortcutIcon *icon1 = [UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeShare];
    UIApplicationShortcutIcon *icon2 = [UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeSearch];
    UIApplicationShortcutIcon *icon3 = [UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeLove];
    UIApplicationShortcutIcon *icon4 = [UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeMail];
    
//创建自定义图标的icon
//    UIApplicationShortcutIcon *icon2 = [UIApplicationShortcutIcon iconWithTemplateImageName:@"分享.png"];
 
    //创建快捷选项
    UIApplicationShortcutItem * item1 = [[UIApplicationShortcutItem alloc] initWithType:CX3DTouchItemTypeShare localizedTitle:@"分享“学霸思政”" localizedSubtitle:nil icon:icon1 userInfo:nil];
    
    UIApplicationShortcutItem * item2 = [[UIApplicationShortcutItem alloc] initWithType:CX3DTouchItemTypeSearch localizedTitle:@"搜索题目" localizedSubtitle:nil icon:icon2 userInfo:nil];
    
    UIApplicationShortcutItem * item3 = [[UIApplicationShortcutItem alloc] initWithType:CX3DTouchItemTypeLove localizedTitle:@"我的收藏" localizedSubtitle:nil icon:icon3 userInfo:nil];
    
    UIApplicationShortcutItem * item4 = [[UIApplicationShortcutItem alloc] initWithType:CX3DTouchItemTypeMail localizedTitle:@"bug反馈" localizedSubtitle:nil icon:icon4 userInfo:nil];
    
    //添加到快捷选项数组
    [UIApplication sharedApplication].shortcutItems = @[item1,item2,item3,item4];
}

//如果app在后台，通过快捷选项标签进入app，则调用该方法，如果app不在后台已杀死，则处理通过快捷选项标签进入app的逻辑在- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions中
- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler {
    
    if([shortcutItem.type isEqualToString:CX3DTouchItemTypeShare]){
        CXLog(@"通过3D Touch进入分享界面");
    } else if ([shortcutItem.type isEqualToString:CX3DTouchItemTypeSearch]) {//进入搜索界面
        CXLog(@"通过3D Touch进入搜索界面");
    } else if ([shortcutItem.type isEqualToString:CX3DTouchItemTypeLove]) {//进入收藏界面
        CXLog(@"通过3D Touch进入收藏界面");
    }else{
        CXLog(@"通过3D Touch反馈Bug");
    }

    
    if (completionHandler) {
        completionHandler(YES);
    }
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
