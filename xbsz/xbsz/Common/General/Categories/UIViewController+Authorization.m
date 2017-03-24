//
//  UIViewController+Authorization.m
//  xbsz
//
//  Created by 陈鑫 on 17/3/24.
//  Copyright © 2017年 lotus. All rights reserved.
//

#import "UIViewController+Authorization.h"
#import <AVFoundation/AVFoundation.h>
#import  <AssetsLibrary/AssetsLibrary.h>

@implementation UIViewController (Authorization)

- (BOOL)cameraAuthorization{
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if(status == AVAuthorizationStatusDenied || status == AVAuthorizationStatusRestricted){
        return NO;
    }else{
        return YES;
    }
}

- (BOOL)albumAuthorization{
    ALAuthorizationStatus status = [ALAssetsLibrary authorizationStatus];
    if (status == ALAuthorizationStatusDenied || status == ALAuthorizationStatusRestricted) {
        return NO;
    }else{
        return YES;
    }
}

@end
