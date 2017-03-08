//
//  CampusTableViewCell.h
//  xbsz
//
//  Created by 陈鑫 on 17/2/21.
//  Copyright © 2017年 lotus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CampusNote.h"

typedef NS_ENUM(NSUInteger,CellActionType){
    CellActionTypeLike = 1<<0,       //点赞
    CellActionTypeReply = 1<<1,       //回复
    CellActionTypeShare = 1<<2,       //分享
    CellActionTypeMore = 1<<3,        //更多
    
    CellActionTypeUserInfo,             //点击进入用户信息页面
    CellActionTypeComment               //点击进入评论列表
};

typedef void(^CellActionBlock)(id model , CellActionType actionType);

@interface CampusTableViewCell : UITableViewCell

- (void)updateUIWithModel:(CampusNote *)model hasLiked:(BOOL)liked action:(CellActionBlock)actiobBlock;

@end
