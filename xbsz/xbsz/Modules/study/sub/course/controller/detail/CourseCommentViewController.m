//
//  CourseCommentViewController.m
//  xbsz
//
//  Created by lotus on 2017/4/20.
//  Copyright © 2017年 lotus. All rights reserved.
//

#import "CourseCommentViewController.h"
#import "CXBaseTableView.h"
#import "CommentTableViewCell.h"
#import "CourseCommentList.h"

static NSString *cellID = @"CourseCommentCellID";

@interface CourseCommentViewController ()<CXBaseTableViewDelegate>

@property (nonatomic, strong) CXBaseTableView *tableView;

@property (nonatomic, strong) CourseCommentList *commentList;

@end

@implementation CourseCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(self.view);
    }];
    
    [self loadDataAtPageIndex:CXFisrtLoadPage];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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

- (void)loadDataAtPageIndex:(NSUInteger )pageIndex{
    
    NSString *fileName = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"comments.json"];
    NSString *jsonStr = [NSString stringWithContentsOfFile:fileName encoding:NSUTF8StringEncoding error:nil];
    
    if(_commentList && [_commentList.comments count]>0){
        [_commentList.comments addObjectsFromArray:[CourseCommentList yy_modelWithJSON:jsonStr].comments];
    }else{
        _commentList = [CourseCommentList yy_modelWithJSON:jsonStr];
    }
    
    [_tableView reloadData];
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
    label.text = @"评价详情 (共70人评价)";
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
    return [_commentList.comments count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if(!cell){
        cell = [[CommentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    [cell updateUIWithModel:[_commentList.comments objectAtIndex:indexPath.row]];
    return cell;
}



@end
