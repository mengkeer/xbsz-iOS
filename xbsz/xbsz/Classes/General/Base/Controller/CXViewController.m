//
//  CXViewController.m
//  xbsz
//
//  Created by 陈鑫 on 16/12/13.
//  Copyright © 2016年 lotus. All rights reserved.
//

#import "CXViewController.h"

@interface CXViewController ()

@end

@implementation CXViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
}


+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    
    CXViewController *viewController = [super allocWithZone:zone];
    
    @weakify(viewController)
    
    [[viewController rac_signalForSelector:@selector(viewDidLoad)] subscribeNext:^(id x) {
        
        @strongify(viewController)
        [viewController cx_addSubviews];
        [viewController cx_bindViewModel];
    }];
    
    [[viewController rac_signalForSelector:@selector(viewWillAppear:)] subscribeNext:^(id x) {
        
        @strongify(viewController)
        [viewController cx_layoutNavigation];
        [viewController cx_getNewData];
    }];
    
    
    return viewController;
}


- (instancetype)initWithViewModel:(id<CXViewModelProtocol>)viewModel {
    
    self = [super init];
    if (self) {
    }
    return self;
}


#pragma mark - RAC
/**
 *  添加控件
 */
- (void)jm_addSubviews {}

/**
 *  绑定
 */
- (void)jm_bindViewModel {}

/**
 *  设置navation
 */
- (void)jm_layoutNavigation {}

/**
 *  初次获取数据
 */
- (void)jm_getNewData {}



@end
