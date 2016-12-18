//
//  UIViewController+CXInit.m
//  idemo
//
//  Created by lotus on 06/12/2016.
//  Copyright © 2016 lotus. All rights reserved.
//

#import "UIViewController+CXInit.h"

@implementation UIViewController (CXInit)

+ (instancetype)controller{
    UIViewController *controller = [[self alloc] init];
    return controller;
}

@end
