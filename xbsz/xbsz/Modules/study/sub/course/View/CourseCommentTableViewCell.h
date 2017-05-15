//
//  CommentTableViewCell.h
//  xbsz
//
//  Created by lotus on 2017/4/20.
//  Copyright © 2017年 lotus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CourseComment.h"

@interface CourseCommentTableViewCell : UITableViewCell

- (void)updateUIWithModel:(CourseComment *)model;

- (void)showLineView:(NSInteger)currentRow totalRows:(NSInteger)totalRows;

@end
