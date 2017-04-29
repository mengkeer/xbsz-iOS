//
//  CXAudioPlayer.m
//  xbsz
//
//  Created by lotus on 2017/4/29.
//  Copyright © 2017年 lotus. All rights reserved.
//

#import "CXAudioPlayer.h"
#import <AudioToolbox/AudioToolbox.h>
#import "CXUserDefaults.h"

@implementation CXAudioPlayer

+ (void)playSoundByFilename:(NSString *)name{
    
    BOOL isAudioOpen = [CXUserDefaults instance].isAudioOpen;
    BOOL isShakeOpen = [CXUserDefaults  instance].isShakeOpen;
    
    NSString *audioFile=[[NSBundle mainBundle] pathForResource:name ofType:@"wav"];
    NSURL *fileUrl=[NSURL fileURLWithPath:audioFile];
    //1.获得系统声音ID
    SystemSoundID soundID=0;
    /**
     * inFileUrl:音频文件url
     * outSystemSoundID:声音id（此函数会将音效文件加入到系统音频服务中并返回一个长整形ID）
     */
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)(fileUrl), &soundID);
    //如果需要在播放完之后执行某些操作，可以调用如下方法注册一个播放完成回调函数
    AudioServicesAddSystemSoundCompletion(soundID, NULL, NULL, soundCompleteCallback, NULL);
    //2.播放音频
    if(isAudioOpen == YES && isShakeOpen == NO){
        AudioServicesPlaySystemSound(soundID);//播放音效
    }else if(isAudioOpen == NO && isShakeOpen == YES){
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    }else if(isAudioOpen == YES && isShakeOpen == YES){
        AudioServicesPlayAlertSound(soundID);//播放音效并震动
    }else{
        return;
    }
    
}

void soundCompleteCallback(SystemSoundID soundID,void * clientData){
//    NSLog(@"播放完成...");
}


@end
