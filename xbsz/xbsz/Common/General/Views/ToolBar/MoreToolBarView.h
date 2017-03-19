//
//  ShareToolBarView.h
//  xbsz
//
//  Created by 陈鑫 on 17/3/9.
//  Copyright © 2017年 lotus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CampusNote.h"

typedef NS_ENUM(NSUInteger,MoreToolBarActionTyep){
    MoreToolBarActionTyepDigup,                     //点赞
    MoreToolBarActionTyepDigdown,                     //踩
    MoreToolBarActionTyepDislike,                   //不感兴趣
    MoreToolBarActionTyepLove,                   //收藏
    MoreToolBarActionTyepReport,                     //举报
    
    MoreToolBarActionTyepCancel                     //取消
};

typedef void (^MoreToolBarActionBlock)(MoreToolBarActionTyep actionType);

@interface MoreToolBarView : UIView

+ (instancetype)instance; 

- (void)updateUIWithModel: (CampusNote *)model action:(MoreToolBarActionBlock)actionBlock;

- (void)showInView:(UIView *)view;

- (void)dismissInView:(UIView *)view;

@end

