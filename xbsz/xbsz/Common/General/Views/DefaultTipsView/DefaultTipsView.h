//
//  DeFaultTipsView.h
//  xbsz
//
//  Created by lotus on 25/03/2017.
//  Copyright © 2017 lotus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DefaultTipsView : UIView

- (void)updateUIWitImage:(UIImage *)image title:(NSString *)title;

- (void)SetClicked:(void(^)())clickBlock;

@end
