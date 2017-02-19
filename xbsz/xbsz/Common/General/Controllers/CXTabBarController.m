//
//  CXTabBarController.m
//  xbsz
//
//  Created by lotus on 2016/12/9.
//  Copyright © 2016年 lotus. All rights reserved.
//

#import "CXTabBarController.h"
#import "CXNavigationController.h"
#import "CXHomeViewController.h"
#import "UserCenterViewController.h"
#import "DiscoverViewController.h"

@interface CXTabBarController ()<UITabBarControllerDelegate>

@end

@implementation CXTabBarController

+ (void)initialize{
    UITabBar *tabbar = [UITabBar appearance];
    tabbar.barTintColor = CXWhiteColor;
    [tabbar setTranslucent:NO];
    tabbar.tintColor = CXMainColor;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.delegate = self;
    
    [self addChildVC:[CXHomeViewController controller] title:@"学习" image:@"tab_home" selectedImage:@"tab_home_s"];
    
//    [self addChildVC:[CXHomeViewController controller] title:@"校园" image:@"tab_school" selectedImage:@"tab_school_s"];
    
    [self addChildVC:[DiscoverViewController controller] title:@"发现" image:@"tab_discover" selectedImage:@"tab_discover_s"];
    
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




@end
