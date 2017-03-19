//
//  CampusNoteModel.h
//  xbsz
//
//  Created by 陈鑫 on 17/2/24.
//  Copyright © 2017年 lotus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CXUser.h"

@interface CampusNote : NSObject

@property (nonatomic, strong) CXUser *user;

@property (nonatomic, copy) NSString *noteID;         //帖子id

@property (nonatomic, copy) NSString *imageUrl;

@property (nonatomic, assign) NSInteger width;          //图片宽度

@property (nonatomic, assign) NSInteger height;         //图片高度

@property (nonatomic, assign) NSUInteger total;         //评论总数

@property (nonatomic, copy) NSString *subject;              //帖子主题  也就是帖子发表者留言

@property (nonatomic, copy) NSString *locaiton;         //发帖地址

@property (nonatomic, assign) NSInteger likes;

@property (nonatomic, assign) NSInteger dislikes;

@property (nonatomic, assign) BOOL isOpend;     //帖子主题是否展开过

@property (nonatomic, copy) NSString *create_at;


@end
