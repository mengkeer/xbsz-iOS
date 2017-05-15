//
//  CampusCommentTableViewCell.h
//  xbsz
//
//  Created by lotus on 2017/5/15.
//  Copyright © 2017年 lotus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CampusComment.h"

@interface CampusCommentTableViewCell : UITableViewCell

- (void)updateUIWithModel:(CampusComment *)model;

@end
