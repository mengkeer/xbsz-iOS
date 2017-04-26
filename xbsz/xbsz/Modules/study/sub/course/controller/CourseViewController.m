//
//  CourseViewController.m
//  xbsz
//
//  Created by lotus on 2016/12/30.
//  Copyright © 2016年 lotus. All rights reserved.
//

#import "CourseViewController.h"
#import "CourseCollectionViewCell.h"
#import "CourseSearchBar.h"
#import "Course.h"
#import "CourseList.h"
#import "CourseDetailViewController.h"
#import "CXNetwork+Course.h"

#import "PYSearch.h"

static int numberOfItems = 3;           //每行的cell个数

static NSString *const cellID = @"CollectionCellID";
static NSString *const headerCellID = @"CollectionHeaderCellID";
static NSString *const footerCellID = @"CollectionFooterCellID";


#define gap (CX_IS_IPHONE6PLUS ? 20 : CX_IS_IPHONE6 ?  15 : 14)

@interface CourseViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,PYSearchViewControllerDelegate,UIViewControllerPreviewingDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) CourseSearchBar *searchBar;

@property (nonatomic, strong) CourseList  *courseList;

@property (nonatomic, strong) YYAnimatedImageView *imageView;


@end

@implementation CourseViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.contentView addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(self.contentView);
        make.centerX.mas_equalTo(self.contentView.mas_centerX);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)loadData{
    
    
//    [CXNetwork getCoursesByStatus:-1 success:^(NSObject *obj) {
//        _courseList = [CourseList yy_modelWithDictionary:(NSDictionary *)obj];
//        [_collectionView reloadData];
//    } failure:^(NSError *error) {
//        CXLog(@"获取课程失败");
//    }];
//    
    
    NSString *fileName = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"courses.json"];
    NSString *jsonStr = [NSString stringWithContentsOfFile:fileName encoding:NSUTF8StringEncoding error:nil];
    
    _courseList = [CourseList yy_modelWithJSON:jsonStr];
    
    [_collectionView reloadData];
    
    CXLog(@"开始加载校园动态");

}


#pragma mark - getter/setter

- (UICollectionView *)collectionView{
    if(!_collectionView){
        UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.backgroundColor = CXWhiteColor;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.alwaysBounceVertical = YES;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        [_collectionView registerClass:[CourseCollectionViewCell class] forCellWithReuseIdentifier:cellID];
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerCellID];
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footerCellID];
        
        _collectionView.contentInset = UIEdgeInsetsMake(50, 0, 0, 0);
        
        [self.collectionView addSubview:self.searchBar];
        
    }
    return _collectionView;
}


- (void)viewWillLayoutSubviews{
    _collectionView.contentOffset = CGPointMake(0, 0);
}

- (CourseSearchBar *)searchBar{
    if(!_searchBar){
        @weakify(self);
        _searchBar = [[CourseSearchBar alloc] initWithFrame:CGRectMake(gap, -30, CXScreenWidth-2*gap, 30)];
        [_searchBar setClicked:^{
            [weak_self gotoSearchView];
        }];
    }
    return _searchBar;
}


#pragma mark - action method

- (void)gotoSearchView{
    // 1. 创建热门搜索
    NSArray *hotSeaches = @[@"密码学", @"网络攻防", @"数据结构", @"线性代数", @"算法" , @"C++程序设计", @"数据库", @"操作系统", @"Linux系统",@"iOS程序设计"];
    // 2. 创建控制器
    PYSearchViewController *searchViewController = [PYSearchViewController searchViewControllerWithHotSearches:hotSeaches searchBarPlaceholder:@"搜索课程" didSearchBlock:^(PYSearchViewController *searchViewController, UISearchBar *searchBar, NSString *searchText) {
        // 开始搜索执行以下代码
        // 如：跳转到指定控制器
        [searchViewController.navigationController pushViewController:[[CourseViewController alloc] init] animated:YES];
    }];
    // 3. 设置风格
    searchViewController.hotSearchStyle = PYHotSearchStyleColorfulTag;
    searchViewController.searchHistoryStyle = PYSearchHistoryStyleDefault;
    // 4. 设置代理
    searchViewController.delegate = self;
    // 5. 跳转到搜索控制器
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:searchViewController];
    [self presentViewController:nav animated:YES completion:nil];
}

- (void)gotoCourseDetailView:(Course *)course{
    CourseDetailViewController *detailViewController = [CourseDetailViewController controller];
    [detailViewController updateDetailWithCourse: course];
    [self.navigationController pushViewController:detailViewController animated:YES];
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self gotoCourseDetailView:[_courseList.courses objectAtIndex:(indexPath.section)*numberOfItems+indexPath.row]];
}


#pragma mark - UICollctionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(cellWidth, cellHeight);
}

//最小行间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return gap;
}

//最小列间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return gap;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(gap, gap, 0, gap);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeZero;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    
    
    NSInteger rows = [_courseList.courses count] / numberOfItems +1;
    if([_courseList.courses count]%3 == 0)  rows -= 1;
    
    if(section == rows - 1){
        
        NSUInteger singalHeight = (cellHeight + gap);
        
        NSInteger height = CGRectGetHeight(self.contentView.frame) - singalHeight*rows;;
        if(height < 0){
            height = -(-height % singalHeight);
            height = singalHeight + height;
        }
        
        
        return CGSizeMake(CXScreenWidth, height);
    }
    return CGSizeZero;
}


#pragma mark - UICollectionDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    NSInteger nums = [_courseList.courses count]/numberOfItems +1;
    return [_courseList.courses count] % 3 == 0 ? nums-1 : nums;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if([_courseList.courses count] >= (section+1)*numberOfItems){
        return numberOfItems;
    }else{
        return [_courseList.courses count]%numberOfItems;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;{
    CourseCollectionViewCell *cell = (CourseCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    NSInteger index = (indexPath.section == 0 ? indexPath.row : (indexPath.section)*numberOfItems+indexPath.row);
    [cell updateCellWithModel:[_courseList.courses objectAtIndex:index]];
    if(CX3DTouchOpened)       [cell registerTouch:self];
    return cell;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath{
    return NO;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionReusableView *reusableView = nil;
    if (kind == UICollectionElementKindSectionHeader) {
        UICollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerCellID forIndexPath:indexPath];
        reusableView = header;
    }
    reusableView.backgroundColor = [UIColor greenColor];
    if (kind == UICollectionElementKindSectionFooter){
        UICollectionReusableView *footerview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footerCellID forIndexPath:indexPath];
        footerview.backgroundColor = [UIColor clearColor];
        reusableView = footerview;
    }
    return reusableView;
}


#pragma mark - PYSearchViewControllerDelegate
- (void)searchViewController:(PYSearchViewController *)searchViewController searchTextDidChange:(UISearchBar *)seachBar searchText:(NSString *)searchText{
    if (searchText.length) { // 与搜索条件再搜索
        // 根据条件发送查询（这里模拟搜索）
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{ // 搜索完毕
            // 显示建议搜索结果
            NSMutableArray *searchSuggestionsM = [NSMutableArray array];
            for (int i = 0; i < arc4random_uniform(5) + 10; i++) {
                NSString *searchSuggestion = [NSString stringWithFormat:@"搜索建议 %d", i];
                [searchSuggestionsM addObject:searchSuggestion];
            }
            // 返回
            searchViewController.searchSuggestions = searchSuggestionsM;
        });
    }
}

#pragma mark - 3D Touch Status Changed
- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
    CXLog(@"3Dtouch状态发生改变");
}

#pragma mark - 3DTouch Delegate

- (UIViewController *)previewingContext:(id<UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location{
    //防止重复加入
    if ([self.presentedViewController isKindOfClass:[CourseDetailViewController class]]){
        return nil;
    }else{
        CourseDetailViewController *peekViewController = [[CourseDetailViewController alloc] init];
        [peekViewController updateDetailWithCourse:[_courseList.courses objectAtIndex:[self getIndexByPreviewing:previewingContext]]];
        return peekViewController;
    }
}

- (void)previewingContext:(id<UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit{
    CourseDetailViewController *popViewController = [CourseDetailViewController controller];
    [popViewController updateDetailWithCourse:[_courseList.courses objectAtIndex:[self getIndexByPreviewing:previewingContext]]];
    [self showViewController:popViewController sender:self];
}


- (NSInteger)getIndexByPreviewing:(id<UIViewControllerPreviewing>)previewingContext{
    CourseCollectionViewCell  *cell = (CourseCollectionViewCell *)[[[previewingContext sourceView] superview] superview];
    NSIndexPath *indexPath = [_collectionView indexPathForCell:cell];
    NSInteger index = indexPath.section*numberOfItems + indexPath.row;
    return index;
}

@end
