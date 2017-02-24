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

@property (nonatomic, copy) NSString *subject;

@property (nonatomic, copy) NSString *locaiton;         //发帖地址

@property (nonatomic, assign) NSInteger likes;


@end
