
//
//  CXNetwork+download.m
//  xbsz
//
//  Created by lotus on 2017/4/16.
//  Copyright © 2017年 lotus. All rights reserved.
//

#import "DownloadManager.h"
#import "CXNetwork.h"
#import "CXNetworkMonitoring.h"

static id _manager = nil;

@interface DownloadManager ()

@property (nonatomic, strong) NSURLSessionDownloadTask *downloadTask;

@end

@implementation DownloadManager

+ (instancetype)manager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[DownloadManager alloc] init];
    });
    return _manager;
}

- (void)downloadFromServer:(NSString *)url{
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
   
    NSURL *URL = [NSURL URLWithString:url];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    _downloadTask = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"%f",1.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount);
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
        NSString *path = [cachesPath stringByAppendingPathComponent:response.suggestedFilename];
        return [NSURL fileURLWithPath:path];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        CXLog(@"下载完成");
    }];
    [_downloadTask resume];
}

- (void)downloadTikuFromServer{
    
    //删除源文件
    // 取得沙盒目录
    NSString *localPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    // 要检查的文件目录
    NSString *filePath = [localPath  stringByAppendingPathComponent:@"tiku.db"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:filePath]) {
        NSError *err = nil;
        [fileManager removeItemAtPath:filePath error:&err];
//        if(err != nil)  return;
    }
    
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *URL = [NSURL URLWithString:CXTiKuUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    _downloadTask = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"%f",1.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount);
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        NSString *localPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        NSString *path = [localPath stringByAppendingPathComponent:response.suggestedFilename];
        //保存修改时间
        NSDictionary *fields = [(NSHTTPURLResponse *)response allHeaderFields];
        
        NSDate *fileModDate = [fields valueForKey:@"Last-Modified"];
        
        [CXStandardUserDefaults setObject:fileModDate forKey:TikuModTime ];
        
        
        return [NSURL fileURLWithPath:path];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        if(error != nil){
            [ToastView showStatus:@"后台服务器异常，无法下载题库" delay:3];
        }else{
            [ToastView showStatus:@"题库更新完成" delay:3.5];
        }
    }];
    [_downloadTask resume];
}

+ (BOOL)isTikuExists{
    // 取得沙盒目录
    NSString *localPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    // 要检查的文件目录
    NSString *filePath = [localPath  stringByAppendingPathComponent:@"tiku.db"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:filePath]) {
        return YES;
    }else {
        return NO;
    }
}

+ (BOOL)isTikuExpired{
    
    if([CXNetworkMonitoring canReachable] == NO)    return NO;
    
    // 取得沙盒目录
    NSString *localPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    // 要检查的文件目录
    NSString *filePath = [localPath  stringByAppendingPathComponent:@"tiku.db"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:filePath]) {
        
        NSURL *url = [NSURL URLWithString:CXTiKuUrl];
        // 询问服务器是否有修改
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        [request setHTTPMethod:@"HEAD"];
        NSHTTPURLResponse *response;
        NSError *error = nil;
        [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
        if ([response respondsToSelector:@selector(allHeaderFields)] && error == nil) {
            NSDate *nowModTime = [[response allHeaderFields] objectForKey:@"Last-Modified"];
            NSDate *lastModTime = (NSDate *)[CXStandardUserDefaults objectForKey:TikuModTime];
            if(lastModTime == nil || [lastModTime compare:nowModTime] == NSOrderedAscending){
                return YES;
            }else{
                return NO;
            }
        }else{
            return NO;
        }
    }else {
        return YES;
    }
}

- (void)resume{
    [_downloadTask resume];
}

- (void)suspend{
    [_downloadTask suspend];
}

@end
