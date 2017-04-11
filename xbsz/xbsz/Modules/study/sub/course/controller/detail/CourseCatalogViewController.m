//
//  CourseCatalogViewController.m
//  xbsz
//
//  Created by 陈鑫 on 17/3/21.
//  Copyright © 2017年 lotus. All rights reserved.
//

#import "CourseCatalogViewController.h"
#import "CXBaseTableView.h"

static NSString *cellID = @"courseSectionID";

@interface CourseCatalogViewController ()<CXBaseTableViewDelegate>
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
    if(!_tableView){
        _tableView = [[CXBaseTableView alloc] initWithFrame:CGRectZero enablePullRefresh:NO];
        _tableView.baseDelegate = self;
        _tableView.showsVerticalScrollIndicator = YES;
        _tableView.separatorStyle = YES;
    }
    return _tableView;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CXLog(@"%@",[NSString stringWithFormat:@"点击了第%lu行",indexPath.row])
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 6;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"第%ld行%ld列",indexPath.section,indexPath.row];
    cell.detailTextLabel.text = @"这是详情";
    cell.backgroundColor = CXWhiteColor;
    return cell;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if([_scrollViewDelegate respondsToSelector:@selector(scrollViewDidScroll:)]){
        [_scrollViewDelegate scrollViewDidScroll:scrollView];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    if([_scrollViewDelegate respondsToSelector:@selector(scrollViewWillBeginDragging:)]){
        [_scrollViewDelegate scrollViewWillBeginDragging:scrollView];
    }
}

@end
