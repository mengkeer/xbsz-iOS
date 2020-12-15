//
//  CXTabBarController.m
//  xbsz
//
//  Created by lotus on 2016/12/9.
//  Copyright © 2016年 lotus. All rights reserved.
//

#import "CXTabBarController.h"
#import "CXNavigationController.h"
#import "CXStudyViewController.h"
#import "UserCenterViewController.h"
#import "DiscoverViewController.h"
#import "UINavigationController+FDFullscreenPopGesture.h"

@interface CXTabBarController ()<UITabBarControllerDelegate>

@end

@implementation CXTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBar.tintColor = CXMainColor;
    self.tabBar.translucent = YES;
    self.delegate = self;
    
    
    [self addChildVC:[CXStudyViewController controller] title:@"学习" image:@"tab_home" selectedImage:@"tab_home_s"];
    
//    [self addChildVC:[DiscoverViewController controller] title:@"发现" image:@"tab_discover" selectedImage:@"tab_discover_s"];
    
    [self addChildVC:[UserCenterViewController controller] title:@"我的" image:@"tab_mine" selectedImage:@"tab_mine_s"];
}

#pragma private method

- (void)addChildVC:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectImage{
    
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:image];
    vc.tabBarItem.selectedImage = [UIImage imageNamed:selectImage];
    [vc.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -3)];
    
    CXNavigationController *nav = [[CXNavigationController alloc] initWithRootViewController:vc];
    [self addChildViewController:nav];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{

}


-(UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait ;
}

- (BOOL)shouldAutorotate{
    return NO;
}

-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    return UIInterfaceOrientationPortrait;
}


@end
