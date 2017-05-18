//
//  CampusCommentViewController.h
//  xbsz
//
//  Created by lotus on 2017/5/15.
//  Copyright © 2017年 lotus. All rights reserved.
//

#import "CXPushViewController.h"
#import "CampusNote.h"

@interface CampusCommentViewController : CXPushViewController

@property (nonatomic, strong) CampusNote *note;

@property (nonatomic, strong) UIImage *sharedImage;     //用于3D Touch保存图片

@property (nonatomic, strong) UIViewController *beforePeekedViewConreoller;

@end
