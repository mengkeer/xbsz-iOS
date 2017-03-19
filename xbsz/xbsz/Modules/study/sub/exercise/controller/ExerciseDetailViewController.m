//
//  ExerciseDetailViewController.m
//  xbsz
//
//  Created by lotus on 18/03/2017.
//  Copyright © 2017 lotus. All rights reserved.
//

#import "ExerciseDetailViewController.h"

@interface ExerciseDetailViewController ()

@property (nonatomic, strong) Exercise *exercise;

@end

@implementation ExerciseDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma marke - public method

- (void)updateDetailWithCourse:(Exercise *)exercise{
    _exercise = exercise;
}


@end
