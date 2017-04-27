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
#import "StudyUtil.h"

static NSString *cellID = @"ChapterTableViewCellID";

@interface ExerciseChapterCollectionViewCell ()<CXBaseTableViewDelegate>

@property (nonatomic, strong) CXBaseTableView *tableView;

@property (nonatomic, assign) ExerciseType type;

@property (nonatomic, assign) ExerciseMode mode;

@property (nonatomic, assign) BOOL isSingle;

@property (nonatomic, copy) NSArray *chapterIndex;     //章节数

@property (nonatomic, copy) NSArray *chapterNums;       //每一章的题目数量

@property (nonatomic, copy) NSArray *indexMap;

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
    
    //设置章节索引映射到图片上，每次都是随机映射
    _indexMap = [NSArray arrayWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",nil];
    _indexMap = [_indexMap sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        int seed = arc4random_uniform(2);
        if (seed) {
            return [obj1 compare:obj2];
        } else {
            return [obj2 compare:obj1];
        }
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
    NSInteger num = [StudyUtil getQuestionsTotalByType:_type];
    label.text = [NSString stringWithFormat:@"%@ (共%ld题)",[StudyUtil exerciseTypeToExerciseName:_type],num];
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
    [self performSelector:@selector(deselect) withObject:nil afterDelay:0.2f];
    if(_selectDelegate && [_selectDelegate respondsToSelector:@selector(selectChapter:)]){
        [_selectDelegate selectChapter:[[_chapterIndex objectAtIndex:indexPath.row] integerValue]];
    }
}

- (void)deselect{
    [_tableView deselectRowAtIndexPath:[_tableView indexPathForSelectedRow] animated:YES];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_chapterIndex count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ExerciseChapterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if(!cell){
        cell = [[ExerciseChapterTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.backgroundColor = CXWhiteColor;
    }
    NSArray *arr = [_chapterNums objectAtIndex:indexPath.row];
    NSInteger num = [[arr objectAtIndex:_isSingle ? 0 :1] integerValue];
    NSString *imageName = [NSString stringWithFormat:@"chapter_%ld",[[_indexMap objectAtIndex:indexPath.row] integerValue]];
    [cell updateUI: imageName
      chapterIndex:[[_chapterIndex objectAtIndex:indexPath.row] integerValue]
               num:num];
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

#pragma mark - public method
- (void)upadteUIByType:(ExerciseType)type mode:(ExerciseMode)mode isSingle:(BOOL)isSingle{
    _type = type;
    _mode = mode;
    _isSingle = isSingle;
    _chapterIndex = [StudyUtil getChapterIndex:type];
    _chapterNums = [StudyUtil getChapterNums:type];
    [_tableView reloadData];
}



@end
