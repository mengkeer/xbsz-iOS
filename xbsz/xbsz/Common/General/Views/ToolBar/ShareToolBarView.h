//
//  ShareToolView.h
//  xbsz
//
//  Created by lotus on 19/03/2017.
//  Copyright © 2017 lotus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CampusNote.h"

typedef NS_ENUM(NSUInteger,ShareToolBarActionTyep){
    ShareToolBarActionTyepPYQ,               //微信朋友圈
    ShareToolBarActionTyepWechat,                //微信好友
    ShareToolBarActionTyepQQ,                    //QQ好友
    ShareToolBarActionTyepQzone,                  //QQ空间
    ShareToolBarActionTyepWeibo,                 //微博
    ShareToolBarActionTyepSystem,                    //Email

    ShareToolBarActionTyepCancel                     //取消
};

typedef void (^ShareToolBarActionBlock)(ShareToolBarActionTyep actionType);

@interface ShareToolBarView : UIView

+ (instancetype)instance;

- (void)updateUIWithModel: (CampusNote *)model action:(ShareToolBarActionBlock)actionBlock;

- (void)showInView:(UIView *)view;

- (void)dismissInView:(UIView *)view;

@end

