//
//  ToolBarView.h
//  xbsz
//
//  Created by 陈鑫 on 17/2/21.
//  Copyright © 2017年 lotus. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,ToolBarActionType){
    ToolBarClickTypeLike = 1<<0,       //点赞
    ToolBarClickTypeReply = 1<<1,       //回复
    ToolBarClickTypeShare = 1<<2,       //分享
    ToolBarClickTypeMore = 1<<3         //更多
};

@class CommentToolBarView;
typedef   void(^ToolBarActionBlock)(CommentToolBarView *view , ToolBarActionType actionType);


@interface CommentToolBarView : UIView

- (void)updateUIByStatus:(BOOL)status action:(ToolBarActionBlock)actionBlock;             //根据是否点过赞来更新状态

@end
