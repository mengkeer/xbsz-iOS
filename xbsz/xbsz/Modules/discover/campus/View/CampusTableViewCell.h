//
//  CampusTableViewCell.h
//  xbsz
//
//  Created by 陈鑫 on 17/2/21.
//  Copyright © 2017年 lotus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CampusNote.h"

@interface CampusTableViewCell : UITableViewCell


- (void)updateUIWithModel:(CampusNote *)model;

@end
