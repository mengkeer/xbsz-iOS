//
//  CXView.m
//  xbsz
//
//  Created by 陈鑫 on 16/12/13.
//  Copyright © 2016年 lotus. All rights reserved.
//

#import "CXView.h"

@implementation CXView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [self cx_setupViews];
        [self cx_bindViewModel];
    }
    return self;
}

- (instancetype)initWithViewModel:(id<CXViewProtocol>)viewModel {
    
    self = [super init];
    if (self) {
        
        [self cx_setupViews];
        [self cx_bindViewModel];
    }
    return self;
}


- (void)cx_bindViewModel {
}

- (void)cx_setupViews {
}

@end
