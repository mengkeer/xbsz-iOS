//
//  ToolBarView.h
//  xbsz
//
//  Created by 陈鑫 on 17/2/21.
//  Copyright © 2017年 lotus. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,ToolBarActionType){
    ToolBarClickTypeReply = 1<<1,       //回复
    ToolBarClickTypeMore = 1<<3         //更多
};

@class CommentToolBarView;
typedef   void(^ToolBarActionBlock)(CommentToolBarView *view , ToolBarActionType actionType);


@interface CommentToolBarView : UIView

- (void)updateUIByAction:(ToolBarActionBlock)actionBlock;

@end
