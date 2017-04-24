//
//  ExerciseChapterCollectionViewCell.m
//  xbsz
//
//  Created by lotus on 2017/4/24.
//  Copyright © 2017年 lotus. All rights reserved.
//

#import "ExerciseChapterCollectionViewCell.h"
#import "CXBaseTableView.h"
#import "ExerciseChapterTableViewCell.h"

static NSString *cellID = @"ChapterTableViewCellID";

@interface ExerciseChapterCollectionViewCell ()<CXBaseTableViewDelegate>

@property (nonatomic, strong) CXBaseTableView *tableView;

@end

@implementation ExerciseChapterCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self initCollectionCell];
    }
    return self;
}

- (void)initCollectionCell{
    [self.contentView addSubview:self.tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.top.mas_equalTo(self.contentView);
    }];
}

#pragma mark - getter/setter
- (CXBaseTableView *)tableView{
    if(!_tableView){
        _tableView = [[CXBaseTableView alloc] initWithFrame:CGRectZero enablePullRefresh:NO];
        _tableView.baseDelegate = self;
        _tableView.backgroundColor = CXWhiteColor;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = YES;
    }
    return _tableView;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(section == 0)    return 40;
    return 0.01f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] init];
    UILabel *label = [[UILabel alloc] init];
    label.text = [NSString stringWithFormat:@"%@ (共875题)",_exercise.title];
    label.font = CXSystemFont(14);
    label.textAlignment = NSTextAlignmentLeft;
    label.textColor = CXHexColor(0x4A4A4A);
    
    [view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(view).mas_offset(15);
        make.height.mas_equalTo(15);
        make.centerY.mas_equalTo(view.mas_centerY);
    }];
    
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CXLog(@"您点击了%ld行",indexPath.row);
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 9;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ExerciseChapterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if(!cell){
        cell = [[ExerciseChapterTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.backgroundColor = CXWhiteColor;
    }
    [cell updateUI:indexPath.row title:nil num:123];
    return cell;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat sectionHeaderHeight = 40;
    if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
    }
}

@end
