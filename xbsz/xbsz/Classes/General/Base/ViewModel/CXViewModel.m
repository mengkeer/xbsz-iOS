//
//  CXViewModel.m
//  xbsz
//
//  Created by 陈鑫 on 16/12/13.
//  Copyright © 2016年 lotus. All rights reserved.
//

#import "CXViewModel.h"

@implementation CXViewModel


+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    
    CXViewModel *viewModel = [super allocWithZone:zone];
    
    if (viewModel) {
        
        [viewModel cx_initialize];
    }
    return viewModel;
}

- (instancetype)initWithModel:(id)model {
    
    self = [super init];
    if (self) {
        
    }
    return self;
}



- (void)cx_initialize {
    
}


@end
