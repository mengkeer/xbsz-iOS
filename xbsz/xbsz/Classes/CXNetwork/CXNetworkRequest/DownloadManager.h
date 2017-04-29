//
//  DownloadManager.h
//  xbsz
//
//  Created by lotus on 2017/4/16.
//  Copyright © 2017年 lotus. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^progress)(CGFloat currentProgress);
typedef void (^downloadSuccess)(void);
typedef void (^downloadFailed)(void);
typedef void (^downloadSuspend)(CGFloat currentProgress);
typedef void (^downloadResume)(CGFloat currentPrpgress);


@interface DownloadManager : NSObject

+ (instancetype)manager;

- (void)downloadFromServer:(NSString *)url;

- (void)downloadTikuFromServer;

+ (BOOL)isTikuExists;

@end
