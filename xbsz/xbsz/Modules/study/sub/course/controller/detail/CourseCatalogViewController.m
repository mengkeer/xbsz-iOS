//
//  CourseCatalogViewController.m
//  xbsz
//
//  Created by 陈鑫 on 17/3/21.
//  Copyright © 2017年 lotus. All rights reserved.
//

#import "CourseCatalogViewController.h"
#import "CXBaseTableView.h"
#import "ChapterHeaderView.h"

static NSString *cellID = @"chapterItemID";
static NSString *sectionID = @"chapterheaderID";

@interface CourseCatalogViewController ()<CXBaseTableViewDelegate,ChapterHeaderDelegate>

@property (nonatomic, strong) CXBaseTableView *tableView;

@property (nonatomic, strong) NSMutableDictionary *foldInfoDic;

@end

@implementation CourseCatalogViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = CXBackGroundColor;
    
    [self.view addSubview:self.tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(self.view);
    }];
    
    _foldInfoDic = [NSMutableDictionary dictionaryWithDictionary:@{
                                                                   @"0":@"0",
                                                                   @"1":@"0",
                                                                   @"2":@"0",
                                                                   @"3":@"0"
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
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorStyle = NO;
    }
    return _tableView;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 45.f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    ChapterHeaderView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:sectionID];
    if(!header){
        header = [[ChapterHeaderView alloc] initWithReuseIdentifier:sectionID];
        header.delegate = self;
    }
    NSString *key = [NSString stringWithFormat:@"%d", (int)section];
    BOOL folded = [[_foldInfoDic valueForKey:key] boolValue];
    [header updateSectionHeader:[NSString stringWithFormat:@"第%ld章",section+1] section:section canFold:YES];
    header.isFolded = folded;
    return header;
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
    NSString *key = [NSString stringWithFormat:@"%d", (int)section];
    BOOL folded = [[_foldInfoDic objectForKey:key] boolValue];
    
    return folded == YES ? 0:6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
        cell.selectedBackgroundView.backgroundColor = CXHexAlphaColor(0xCCFFCC,0.3);
    }
    cell.textLabel.text = [NSString stringWithFormat:@"第%ld节",indexPath.row+1];
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

#pragma mark - Chapter Delegate
- (void)foldHeaderInSection:(NSInteger)section{
    CXLog(@"点击了第%ld章",section);
    NSString *key = [NSString stringWithFormat:@"%d",(int)section];
    BOOL folded = [[_foldInfoDic objectForKey:key] boolValue];
    NSString *fold = folded ? @"0" : @"1";
    [_foldInfoDic setValue:fold forKey:key];
    NSMutableIndexSet *set = [[NSMutableIndexSet alloc] initWithIndex:section];
    [_tableView reloadSections:set withRowAnimation:UITableViewRowAnimationFade];
}
@end
