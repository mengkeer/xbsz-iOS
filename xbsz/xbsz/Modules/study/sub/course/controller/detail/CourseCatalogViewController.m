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
#import "DownloadManager.h"
#import "AttachmentViewController.h"
#import "CXNetwork+Course.h"
#import "CourseWareList.h"

static NSString *cellID = @"CatalogItemID";
static NSString *sectionID = @"chapterheaderID";

@interface CourseCatalogViewController ()<CXBaseTableViewDelegate,ChapterHeaderDelegate>

@property (nonatomic, strong) CXBaseTableView *tableView;

@property (nonatomic, strong) NSMutableDictionary *foldInfoDic;

@property (nonatomic, strong) CourseWareList *wareList;

@property (nonatomic, strong) NSMutableArray *wares;

@end

@implementation CourseCatalogViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = CXBackGroundColor;
    
    [self.view addSubview:self.tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(self.view);
    }];
    
    _foldInfoDic = [NSMutableDictionary dictionary];
    _wares = [NSMutableArray array];
    [self initData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)initData{
    [CXNetwork getCourseWare:_course.courseID success:^(NSObject *obj) {
        _wareList = [CourseWareList yy_modelWithDictionary:(NSDictionary *)obj];
        [self sortOutData:_wareList.courseWare];
        [_tableView reloadData];
    } failure:^(NSError *error) {
        CXLog(@"获取课程目录失败");
    }];
}

- (void)sortOutData:(NSArray *)coursewares{
    coursewares = [coursewares sortedArrayUsingComparator:^NSComparisonResult(CourseWare  *obj1, CourseWare  *obj2) {
        return obj1.chapter > obj2.chapter;
    }];
    
    NSMutableArray *tempArr = [NSMutableArray array];
    NSInteger lastIndex = -1;
    if([coursewares count] != 0)    lastIndex = ((CourseWare *)([coursewares objectAtIndex:0])).chapter;
    for(NSInteger i = 0;i<[coursewares count];i++){
        CourseWare *temp = [coursewares objectAtIndex:i];
        
        if(lastIndex == -1)   return;
        if(temp.chapter == lastIndex){
            [tempArr addObject:temp];
        }else{
            [_wares addObject:[tempArr copy]];
            [_foldInfoDic addEntriesFromDictionary:@{[NSString stringWithFormat:@"%ld",lastIndex]:@"0"}];
            [tempArr removeAllObjects];
            [tempArr addObject:temp];
            lastIndex = temp.chapter;
        }
        
        if(i == [coursewares count]-1){
            [_wares addObject:[tempArr copy]];
            [_foldInfoDic addEntriesFromDictionary:@{[NSString stringWithFormat:@"%ld",i]:@"0"}];
        }
    }
    
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
    return 50.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50.f;
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
    //暂时去除课程课件学习权限
//    if(_course.applyStatus != 3){
//        [ToastView showStatus:@"请先申请学习该课程"];
//        return;
//    }
    
    CourseWare *ware = [[_wares objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];

    AttachmentViewController *vc = [AttachmentViewController controller];
    vc.path = CXFileUrlByName(ware.file);
    vc.title = ware.name;
    [self.lcNavigationController pushViewController:vc];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [_wares count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSString *key = [NSString stringWithFormat:@"%d", (int)section];
    BOOL folded = [[_foldInfoDic objectForKey:key] boolValue];
    
    return folded == YES ? 0:[[_wares objectAtIndex:section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CourseChapterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if(!cell){
        cell = [[CourseChapterTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    CourseWare *ware = [[_wares objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    [cell updateUIWithModel:ware];
    return cell;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if([_baseDelegate respondsToSelector:@selector(scrollViewDidScroll:)]){
        [_baseDelegate scrollViewDidScroll:scrollView];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    if([_baseDelegate respondsToSelector:@selector(scrollViewWillBeginDragging:)]){
        [_baseDelegate scrollViewWillBeginDragging:scrollView];
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
