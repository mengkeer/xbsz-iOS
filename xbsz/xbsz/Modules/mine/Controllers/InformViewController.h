//
//  InformViewController.h
//  xbsz
//
//  Created by lotus on 2016/12/18.
//  Copyright © 2016年 lotus. All rights reserved.
//

#import "CXPushViewController.h"
#import "SystemInform.h"

@interface InformViewController : CXPushViewController

@end


@interface InformTableViewCell : UITableViewCell

- (void)updateUIByModel:(SystemInform *)model;

- (void)showLineView:(NSInteger)currentRow totalRows:(NSInteger)totalRows;

@end
