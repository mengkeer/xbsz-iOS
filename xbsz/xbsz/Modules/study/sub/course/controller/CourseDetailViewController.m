//
//  CourseDetailViewController.m
//  xbsz
//
//  Created by lotus on 14/03/2017.
//  Copyright © 2017 lotus. All rights reserved.
//

#import "CourseDetailViewController.h"

@interface CourseDetailViewController ()

@end

@implementation CourseDetailViewController

- (instancetype)init{
    self = [super init];
    if (self) {
        [self setHidesBottomBarWhenPushed:YES];
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewWillAppear:animated];
        [self.navigationController.view bringSubviewToFront:self.navigationController.navigationBar];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.view bringSubviewToFront:self.navigationController.navigationBar];
    self.navigationController.navigationBar.backgroundColor = CXWhiteColor;
    self.title = self.course.title;
//    self.view.backgroundColor = CXWhiteColor;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSArray<id<UIPreviewActionItem>> *)previewActionItems
{
    
    // 生成UIPreviewAction
    UIPreviewAction *action1 = [UIPreviewAction actionWithTitle:@"认领课程" style:UIPreviewActionStyleDefault handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        NSLog(@"Action 1 selected");
    }];
    
    UIPreviewAction *action2 = [UIPreviewAction actionWithTitle:@"开始学习" style:UIPreviewActionStyleDefault handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        NSLog(@"Action 2 selected");
    }];
    
    UIPreviewAction *action3 = [UIPreviewAction actionWithTitle:@"移除课程" style:UIPreviewActionStyleDestructive handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        NSLog(@"Action 3 selected");
    }];
    
    NSArray *actions = @[action1, action2, action3];
    return actions;
}




@end
