//
//  CXNavigationController.m
//  xbsz
//
//  Created by lotus on 2016/12/9.
//  Copyright © 2016年 lotus. All rights reserved.
//

#import "CXNavigationController.h"

@interface CXNavigationController ()

@end

@implementation CXNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(BOOL)shouldAutorotate{
    return YES;
}

-(UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return [self.viewControllers.lastObject supportedInterfaceOrientations];
}

-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    return [self.viewControllers.lastObject preferredInterfaceOrientationForPresentation];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.childViewControllers.count >= 1) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
    if (@available(iOS 11.0, *)){
        CGRect frame = self.tabBarController.tabBar.frame;
        frame.origin.y = [UIScreen mainScreen].bounds.size.height - frame.size.height;
        self.tabBarController.tabBar.frame = frame;
    }
}


@end
