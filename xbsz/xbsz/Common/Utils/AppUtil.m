//
//  AppUtil.m
//  xbsz
//     
//  Created by lotus on 2017/5/13.
//  Copyright © 2017年 lotus. All rights reserved.
//

#import "AppUtil.h"
#import "CXNetworkMonitoring.h"

@implementation AppUtil

+ (BOOL)isAfterAdTimeNode{
    NSString *launchTime  = [CXStandardUserDefaults objectForKey:APPFirstLaunchTime];
    if(launchTime == nil)   return NO;
    
////    暂时调整时间节点
//    [CXStandardUserDefaults setObject:@"2017-06-08 22:22:22" forKey:APPFirstLaunchTime];
//    launchTime  = [CXStandardUserDefaults objectForKey:APPFirstLaunchTime];
//    if(launchTime == nil)   return NO;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH-mm-ss";
    NSDate *date = [formatter dateFromString:launchTime];

    NSDate *now = [NSDate date];
    if([[date dateByAddingHours:3] compare:now] == NSOrderedAscending){
        return YES;
    }
    
    return NO;
}

+ (BOOL)isAfterAppUpperTimeNode{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd";
    NSDate *date = [formatter dateFromString:@"2017-06-22"];
    
    NSDate *now = [NSDate date];
    if([date compare:now] == NSOrderedAscending){
        return YES;
    }
    
    return NO;
}

+ (BOOL)showAD{
    BOOL hasAd = [CXUserDefaults instance].hasAd;
    if(hasAd && [self isAfterAdTimeNode]){
        CXLog(@"显示广告");
        return YES;
    }else{
        CXLog(@"无广告");
        return NO;
    }
}

+ (void)checkUpdate:(UIViewController *)controller{
    if([CXNetworkMonitoring canReachable] == NO || [self isAfterAppUpperTimeNode] == NO)    return;
    
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:configuration];

    NSString *storeString = [NSString stringWithFormat:@"https://itunes.apple.com/lookup?id=%@",APPID];
    [manager GET:storeString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray *array = responseObject[@"results"];
        NSDictionary *dic  = [array firstObject];
        NSString *storeVersion = dic[@"version"];
        
        NSString *currentVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
        
        if([currentVersion compare:storeVersion options:NSNumericSearch] == NSOrderedAscending){
            
            
            //跳转到appstore更新
//            NSString *releaseNotes = dic[@"releaseNotes"];
            NSString *trackUrl =dic[@"trackViewUrl"];
            
            UIAlertController *alertController=[UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"发现新版本V%@",currentVersion] message:nil preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"下次再说" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            
            
            UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"前往更新" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:trackUrl]];
                
            }];
            
            [alertController addAction:action1];
            
            [alertController addAction:action2];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [controller presentViewController:alertController animated:YES completion:nil];
            });
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    

}

+ (NSInteger)getCacheSize{
    //获取文件管理器对象
    NSFileManager * fileManger = [NSFileManager defaultManager];
    
    //获取缓存沙盒路径
    NSString * cachePath =  [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    
    //拼接缓存文件夹路径
    NSString * fileCachePath = [cachePath stringByAppendingPathComponent:[[NSBundle mainBundle] bundleIdentifier]];
    
    //将缓存文件夹路径赋值给成员属性(后面删除缓存文件时需要用到)

    
    //通过缓存文件路径创建文件遍历器
    NSDirectoryEnumerator * fileEnumrator = [fileManger enumeratorAtPath:fileCachePath];
    
    //先定义一个缓存目录总大小的变量
    NSInteger fileTotalSize = 0;
    
    for (NSString * fileName in fileEnumrator)
    {
        //拼接文件全路径（注意：是文件）
        NSString * filePath = [fileCachePath stringByAppendingPathComponent:fileName];
        
        //获取文件属性
        NSDictionary * fileAttributes = [fileManger attributesOfItemAtPath:filePath error:nil];
        
        //根据文件属性判断是否是文件夹（如果是文件夹就跳过文件夹，不将文件夹大小累加到文件总大小）
        if ([fileAttributes[NSFileType] isEqualToString:NSFileTypeDirectory]) continue;
        
        //获取单个文件大小,并累加到总大小
        fileTotalSize += [fileAttributes[NSFileSize] integerValue];
    }
    
    //将字节大小转为MB，然后传出去
    return fileTotalSize;
}


//清除缓存
+ (void) cleanCache
{
    
    //获取缓存沙盒路径
    NSString * cachePath =  [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    
    NSString * fileCachePath = [cachePath stringByAppendingPathComponent:[[NSBundle mainBundle] bundleIdentifier]];

    
    //删除缓存目录下所有缓存文件
    [[NSFileManager defaultManager] removeItemAtPath:fileCachePath error:nil];
}

@end
