//
//  AppIconViewController.h
//  xbsz
//
//  Created by lotus on 2017/12/20.
//  Copyright © 2017年 lotus. All rights reserved.
//

#import "CXWhitePushViewController.h"

@interface AppIconViewController : CXWhitePushViewController

@end


@interface AppIconView : UIView

- (void)updateUIByIconName:(NSString *)iconName isSelected:(BOOL)isSelected;

@end
