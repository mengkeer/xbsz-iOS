//
//  CommendViewController.m
//  xbsz
//
//  Created by 陈鑫 on 16/12/15.
//  Copyright © 2016年 lotus. All rights reserved.
//

#import "CommendViewController.h"

@interface CommendViewController ()

@end

@implementation CommendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *topBackView = [[UIView alloc ]initWithFrame:CGRectMake(0, 0, CXScreenWidth, CXTopCornerRadius)];
    topBackView.backgroundColor = CXMainColor;
    
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CXScreenWidth,CXScreenHeight-49-53 )];
    contentView.backgroundColor = CXWhiteColor;
    
    
    
    [self.view addSubview:topBackView];
    [self.view addSubview:contentView];
//    [self.view sendSubviewToBack:contentView];

    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, CXScreenWidth, contentView.height) byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(CXTopCornerRadius, 8)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = CGRectMake(0, 0, CXScreenWidth, contentView.height);
    maskLayer.path = maskPath.CGPath;
    contentView.layer.mask = maskLayer;
    
//    NSLog(@"width = %lf, height = %f",contentView.frame.size.width,contentView.frame.size.height);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
