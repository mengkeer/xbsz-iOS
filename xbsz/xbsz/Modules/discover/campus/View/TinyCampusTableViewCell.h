//
//  TinyCampusTableViewCell.h
//  xbsz
//
//  Created by lotus on 2017/12/27.
//  Copyright © 2017年 lotus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CampusNote.h"
#import "CommentToolBarView.h"

typedef NS_ENUM(NSUInteger,TinyCommentCellActionType){
    TinyCommentCellActionTypeReply = 1<<1,       //回复
    TinyCommentCellActionTypeMore = 1<<3,        //更多
    
    TinyCommentCellActionTypeUserInfo,             //点击进入用户信息页面
    TinyCommentCellActionTypeSourceImage,          //点击进入原图
    TinyCommentCellActionTypeComment               //点击进入评论列表
};

typedef void(^TinyCellActionBlock)(id cell,id model , TinyCommentCellActionType actionType);
typedef void(^MoreClickBlock)(void);


@interface TinyCampusTableViewCell : UITableViewCell

//用户分享的图片
@property (nonatomic, strong) YYAnimatedImageView *sharedImageView;

@property (nonatomic, strong) CampusNote *note;

@property (nonatomic, strong) CommentToolBarView *toolBarView;      //点赞 留言 分享 更多等功能


- (void)updateUIWithModel:(CampusNote *)model
                   action:(TinyCellActionBlock)actiobBlock
             didClickMore:(MoreClickBlock)block;

- (void)registerTouch:(id)delegate;

+ (CGFloat)heightForModel:(CampusNote *)model;


@end
