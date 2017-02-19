//
//  CXPushViewController.h
//  xbsz
//
//  Created by lotus on 2016/12/13.
//  Copyright © 2016年 lotus. All rights reserved.
//

#import "CXBaseViewController.h"

@interface CXPushViewController : CXBaseViewController

@property (nonatomic,strong) UIView *customNavBarView;
@property (nonatomic,assign) BOOL showTopRadius;
@property (nonatomic,strong) UIView *contentView;

- (float)getStartOriginY;

- (float)getContentViewHeight;

- (void)popFromCurrentViewController;

- (void)setCustomNavBarHidden:(BOOL)hidden;


@end
