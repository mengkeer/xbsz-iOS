//
//  InformViewController.m
//  xbsz
//
//  Created by lotus on 2016/12/18.
//  Copyright © 2016年 lotus. All rights reserved.
//

#import "InformViewController.h"

@interface InformViewController ()

@end

@implementation InformViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = CXBackGroundColor;
    
    UILabel *labelInform = [[UILabel alloc] init];
    labelInform.text = @"通知";
    labelInform.font = CXSystemFont(16);
    
    UILabel *labelLetter = [[UILabel alloc] init];
    labelLetter.text = @"私信";
    labelLetter.font = CXSystemFont(16);
    
    
    
    
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
