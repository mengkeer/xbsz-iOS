//
//  CourseCatalogViewController.m
//  xbsz
//
//  Created by 陈鑫 on 17/3/21.
//  Copyright © 2017年 lotus. All rights reserved.
//

#import "CourseCatalogViewController.h"
#import "CXBaseTableView.h"

@interface CourseCatalogViewController ()

@property (nonatomic, strong) CXBaseTableView *tableView;

@end

@implementation CourseCatalogViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = CXBackGroundColor;
    
    [self.view addSubview:self.tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(self.view);
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - getter/setter
- (CXBaseTableView *)tableView{
    if(_tableView){
        _tableView = [[CXBaseTableView alloc] init];
    }
    return _tableView;
}

@end
