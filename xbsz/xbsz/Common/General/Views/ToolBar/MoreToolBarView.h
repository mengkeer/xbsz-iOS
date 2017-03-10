//
//  ShareToolBarView.h
//  xbsz
//
//  Created by 陈鑫 on 17/3/9.
//  Copyright © 2017年 lotus. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSUInteger,MoreToolBarActionTyep){
    MoreToolBarActionTyepWechat,                //微信好友
    MoreToolBarActionTyepFriends,               //微信朋友圈
    MoreToolBarActionTyepWeibo,                 //微博
    MoreToolBarActionTyepQzone,                  //QQ空间
    MoreToolBarActionTyepQQ,                    //QQ好友
    MoreToolBarActionTyepMessage,                 //短信
    MoreToolBarActionTyepEmail,                    //Email
    
    MoreToolBarActionTyepLike,                     //点赞
    MoreToolBarActionTyepDislike,                   //狠踩它
    MoreToolBarActionTyepCollect,                   //收藏
    MoreToolBarActionTyepReport                     //举报
};

@class ShareToolBarView;
typedef void (^ToolBarActionBlock)(ShareToolBarView *toolbar,MoreToolBarActionTyep actionType);

@interface MoreToolBarView : UIView

- (void)updateUIWithModel: (id)model action:(ToolBarActionBlock)actionBlock;

@end
