//
//  CourseCommentViewController.m
//  xbsz
//
//  Created by lotus on 2017/4/20.
//  Copyright © 2017年 lotus. All rights reserved.
//

#import "CourseCommentViewController.h"
#import "CXBaseTableView.h"
#import "CourseCommentTableViewCell.h"
#import "CourseCommentList.h"

#import "CXNetwork+Course.h"

static NSString *cellID = @"CourseCommentCellID";
static NSInteger limit = 10;

@interface CourseCommentViewController ()<CXBaseTableViewDelegate>

@property (nonatomic, strong) CXBaseTableView *tableView;

@property (nonatomic, strong) CourseCommentList *commentList;

@property (nonatomic, strong) NSMutableArray *comments;

@end

@implementation CourseCommentViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadDataAtPageIndex:CXFisrtLoadPage];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(self.view);
    }];
    
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refresh) name:NotificationCourseCommentSubmited object:nil];
    
    _comments = [NSMutableArray array];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


#pragma mark - getter/setter

- (CXBaseTableView *)tableView{
    if(!_tableView){
        _tableView = [[CXBaseTableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped enablePullRefresh:YES];
        _tableView.baseDelegate = self;
        _tableView.showsVerticalScrollIndicator = YES;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}


#pragma mark - CXBaseTableViewDelegate

- (void)refresh{
    [self.tableView loadRefreshData];
}

- (void)loadDataAtPageIndex:(NSUInteger )pageIndex{
    @weakify(self);
    [CXNetwork getCourseComments:_course.courseID offset:pageIndex-1 limit:limit success:^(NSObject *obj) {
        weak_self.commentList = [CourseCommentList yy_modelWithDictionary:(NSDictionary *)obj];
        if(pageIndex == 1){
            [weak_self.comments removeAllObjects];
        }
        
        [weak_self.comments addObjectsFromArray:_commentList.comments];
        
        CXPage *pageInfo = weak_self.commentList.pageInfo;
        
        if([weak_self.comments count] == 0){
            [weak_self.tableView showDefaultImageWithResult:NO];
        }else{
            [weak_self.tableView showRefresh];
        }
        
        if([weak_self.comments count] == pageInfo.count){
            [weak_self.tableView loadNoMoreData];
        }
        
        [weak_self.tableView reloadData];           //重新加载

    } failure:^(NSError *error) {
        if (weak_self.comments.count == 0) {
            [weak_self.tableView showDefaultImageWithResult:YES];
        }else{
            [ToastView showErrorWithStaus:@"加载失败"];
        }
        [weak_self.tableView endRefresh];
    }];

}


#pragma  mark - UIScrollViewDelegate
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

#pragma  mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CXLog(@"您点击了%ld行",indexPath.row);
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
     return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 75;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(section == 0)    return 35;
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] init];
    UILabel *label = [[UILabel alloc] init];
    label.text = @"评价详情 (共0人评价)";
    if(_commentList  != nil && _commentList.pageInfo != 0){
        label.text = [NSString stringWithFormat:@"评价详情 (共%ld人评价)",_commentList.pageInfo.count];

    }
    label.font = CXSystemFont(14);
    label.textAlignment = NSTextAlignmentLeft;
    label.textColor = CXHexColor(0x4A4A4A);
    
    [view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(view).mas_offset(15);
        make.height.mas_equalTo(15);
        make.top.mas_equalTo(view.mas_top).mas_offset(15);
    }];
    
    return view;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_comments count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CourseCommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if(!cell){
        cell = [[CourseCommentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    [cell updateUIWithModel:[_comments objectAtIndex:indexPath.row]];
    [cell showLineView:indexPath.row totalRows:[_comments count]];
    return cell;
}



@end
