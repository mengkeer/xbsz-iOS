//
//  SearchResultViewController.m
//  xbsz
//
//  Created by lotus on 2017/4/27.
//  Copyright © 2017年 lotus. All rights reserved.
//

#import "SearchResultViewController.h"
#import "QuestionCollectionViewCell.h"

@interface SearchResultViewController ()

@end

@implementation SearchResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    self.title = @"搜索结果显示";
    self.customNavBarView.backgroundColor = CXBackGroundColor;
    
    QuestionCollectionViewCell *contentView = [[QuestionCollectionViewCell alloc] initWithFrame:CGRectZero];
    contentView.backgroundColor = CXWhiteColor;
    [contentView updateUIByQuestion:_question showRightAnswer:YES];
    [self.view addSubview:contentView];
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.view);
        make.top.mas_equalTo(self.customNavBarView.mas_bottom);
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
