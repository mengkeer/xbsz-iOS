//
//  CampusViewController.m
//  xbsz
//
//  Created by 陈鑫 on 17/2/21.
//  Copyright © 2017年 lotus. All rights reserved.
//

#import "CampusViewController.h"
#import "CXBaseTableView.h"
#import "CampusTableViewCell.h"

@interface CampusViewController ()<CXBaseTableViewDelegate>

@property (nonatomic, strong) CXBaseTableView *tableView;

@end

@implementation CampusViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = CXWhiteColor;
    [self.contentView addSubview:self.tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.view);
    }];
    
    [self loadDataAtPageIndex:InitialLoadPage];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark getter / setter
- (UITableView *)tableView{
    if(!_tableView){
        _tableView = [[CXBaseTableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped enablePullRefresh:YES];
        _tableView.baseDelegate = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorStyle = NO;
        _tableView.showEmptyTips = YES;
    }
    return _tableView;
}

#pragma mark  CXBaseTableViewDelegate

- (void)loadDataAtPageIndex:(NSUInteger)pageIndex{
    [_tableView reloadData];
    CXLog(@"开始加载校园动态");
}

#pragma mark UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 300;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CXLog(@"%@",[NSString stringWithFormat:@"点击了第%ld行",indexPath.row])
}




#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    CXLog(@"显示第%ld行",indexPath.row);
    CampusTableViewCell *cell;
    cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if(cell == nil){
        cell = [[CampusTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellID"];
    }
    
    [cell updateUIWithModel:indexPath.row+1];
    
    return cell;
}



@end
