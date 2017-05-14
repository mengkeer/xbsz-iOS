//
//  CXBaseTableView.m
//  xbsz
//
//  Created by lotus on 20/02/2017.
//  Copyright © 2017 lotus. All rights reserved.
//

#import "CXBaseTableView.h"
#import "MJRefresh.h"

@interface CXBaseTableView ()

@property (nonatomic, assign) BOOL pullRefreshEnabled;      //是否允许上拉刷新

@property (nonatomic, assign) NSInteger defaultImageType;       //1表示网络错误  2表示空数据

@end

@implementation CXBaseTableView

- (instancetype)initWithFrame:(CGRect)frame enablePullRefresh:(BOOL)enable{
    return [self initWithFrame:frame style:UITableViewStylePlain enablePullRefresh:enable];
}

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style enablePullRefresh:(BOOL)enable{
    self = [super initWithFrame:frame style:style];
    if(self){
        _pullRefreshEnabled = enable;
        self.showEmptyTips = NO;
        _currentPage = CXFisrtLoadPage;
        [self initBaseTableView];
    }
    return self;
}

- (void)initBaseTableView{
    self.emptyDataSetSource = self;
    self.emptyDataSetDelegate = self;
    
    self.backgroundColor = CXWhiteColor;
    if(_pullRefreshEnabled == NO)   return;
    MJRefreshNormalHeader *gifHeader = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadRefreshData];
    }];
    
    gifHeader.lastUpdatedTimeLabel.hidden = YES;
    self.mj_header = gifHeader;

    self.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self loadNextPageData];
    }];
}

- (void)reloadData{
    [super reloadData];
    if(_pullRefreshEnabled == YES){
        [self.mj_header endRefreshing];
        [self.mj_footer endRefreshing];
    }
}

-(void)loadRefreshData{
    self.currentPage = 1;
    if ([self.baseDelegate respondsToSelector:@selector(loadDataAtPageIndex:)]) {
        [self.baseDelegate loadDataAtPageIndex:_currentPage];
    }
}

-(void)loadNextPageData{
    self.currentPage++ ;
    if ([self.baseDelegate respondsToSelector:@selector(loadDataAtPageIndex:)]) {
        [self.baseDelegate loadDataAtPageIndex:self.currentPage];
    }
}

- (void)loadNoMoreData{
    [self.mj_footer endRefreshingWithNoMoreData];
    [self.mj_footer setHidden:YES];
}

- (void)showRefresh{
    if(_pullRefreshEnabled == YES){
        if(self.mj_footer.hidden == YES)    [self.mj_footer setHidden:NO];
        if(self.mj_header.hidden == YES)    [self.mj_header setHidden:NO];
    }
}

- (void)endRefresh{
    [self.mj_footer endRefreshing];
    [self.mj_header endRefreshing];
}

- (void)setBaseDelegate:(id<CXBaseTableViewDelegate>)baseDelegate{
    _baseDelegate = baseDelegate;
    self.delegate = baseDelegate;
    self.dataSource = baseDelegate;
}

- (void)showDefaultImageWithResult:(BOOL)result{
    [self.mj_footer setHidden:YES];
    [self.mj_header setHidden:YES];
    if(result == YES){
        _showEmptyTips = YES;
        _defaultImageType = 1;
        [self reloadData];
    }else{
        _showEmptyTips = YES;
        _defaultImageType = 2;
        [self reloadData];
    }
}

#pragma mark DZNEmptyDataSetDelegate

- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView{
    return _showEmptyTips;
}

- (void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view{
    [self loadRefreshData];
}

- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView{
    return YES;
}


#pragma DZNEmptyDataSetDataSource

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{
    if(_defaultImageType == 1){
        return [UIImage imageNamed:@"nonetwork"];
    }else{
        return [UIImage imageNamed:@"nocontent"];

    }
}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView{
    NSString *text = @"";
    if(_defaultImageType == 1){
        text = @"网络开了个小差";
    }else{
         text = @"好像没有什么让你看的";
    }
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:18.0f],
                                 NSForegroundColorAttributeName: [UIColor darkGrayColor]};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView{
    NSString *text = @"";
    if(_defaultImageType == 1){
        text = @"点击一下再重新加载吧";
    }else{
        text = @"要不你点击一下再试试？";
    }
    
    NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    paragraph.alignment = NSTextAlignmentCenter;
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:14.0f],
                                 NSForegroundColorAttributeName: [UIColor lightGrayColor],
                                 NSParagraphStyleAttributeName: paragraph};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}


- (CAAnimation *)imageAnimationForEmptyDataSet:(UIScrollView *)scrollView{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath: @"transform"];
    
    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    animation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI_2, 0.0, 0.0, 1.0)];
    
    animation.duration = 0.25;
    animation.cumulative = YES;
    animation.repeatCount = MAXFLOAT;
    
    return animation;
}

- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView{
    return -10;
}


@end
