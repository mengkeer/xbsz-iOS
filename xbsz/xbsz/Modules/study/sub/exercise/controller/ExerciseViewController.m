//
//  CourseViewController.m
//  xbsz
//
//  Created by lotus on 2016/12/30.
//  Copyright © 2016年 lotus. All rights reserved.
//

#import "ExerciseViewController.h"
#import "ExerciseCollectionViewCell.h"
#import "ExerciseSearchBar.h"
#import "Exercise.h"
#import "ExerciseList.h"
#import "ExerciseChapterViewController.h"
#import "StudyUtil.h"
#import "ExerciseMode.h"

#import "PYSearch.h"

static int numberOfItems = 3;           //每行的cell个数

static NSString *const cellID = @"CollectionCellID";
static NSString *const headerCellID = @"CollectionHeaderCellID";
static NSString *const footerCellID = @"CollectionFooterCellID";


#define gap (CX_IS_IPHONE6PLUS ? 20 : CX_IS_IPHONE6 ?  15 : 14)

@interface ExerciseViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,PYSearchViewControllerDelegate,UIViewControllerPreviewingDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) ExerciseSearchBar *searchBar;

@property (nonatomic, strong) ExerciseList  *exerciseList;

@property (nonatomic, strong) YYAnimatedImageView *imageView;


@end

@implementation ExerciseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.contentView addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(self.contentView);
        make.centerX.mas_equalTo(self.contentView.mas_centerX);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
    }];
    
    [self loadData];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)loadData{
    
    
    NSString *fileName = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"exercises.json"];
    NSString *jsonStr = [NSString stringWithContentsOfFile:fileName encoding:NSUTF8StringEncoding error:nil];
    
    _exerciseList = [ExerciseList yy_modelWithJSON:jsonStr];
    
    
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
        [_collectionView registerClass:[ExerciseCollectionViewCell class] forCellWithReuseIdentifier:cellID];
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

- (ExerciseSearchBar *)searchBar{
    if(!_searchBar){
        @weakify(self);
        _searchBar = [[ExerciseSearchBar alloc] initWithFrame:CGRectMake(gap, -30, CXScreenWidth-2*gap, 30)];
        [_searchBar setClicked:^{
            [weak_self gotoSearchView];
        }];
    }
    return _searchBar;
}


#pragma mark - action method

- (void)gotoSearchView{
    // 1. 创建热门搜索
    NSArray *hotSeaches = @[@"近代史", @"马克思", @"思修", @"毛概1", @"毛概2" , @"大学英语3", @"Java程序设计", @"计算机二级",@"多媒体技术"];
    // 2. 创建控制器
    PYSearchViewController *searchViewController = [PYSearchViewController searchViewControllerWithHotSearches:hotSeaches searchBarPlaceholder:@"搜索课程" didSearchBlock:^(PYSearchViewController *searchViewController, UISearchBar *searchBar, NSString *searchText) {
        // 开始搜索执行以下代码
        // 如：跳转到指定控制器
        [searchViewController.navigationController pushViewController:[[ExerciseViewController alloc] init] animated:YES];
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

- (void)gotoExerciseDetailView:(ExerciseType)type{
    ExerciseChapterViewController *chapterVC = [ExerciseChapterViewController controller];
    chapterVC.type = type;
    [self.navigationController pushViewController:chapterVC animated:YES];
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger index = indexPath.section*numberOfItems + indexPath.row;
    ExerciseType type = [StudyUtil indexToExerciseType:index];
    [self gotoExerciseDetailView:type];
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
    
    
    NSInteger rows = [_exerciseList.exercises count] / numberOfItems +1;
    if([_exerciseList.exercises count]%3 == 0)  rows -= 1;
    
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
    NSInteger nums = [_exerciseList.exercises count]/numberOfItems +1;
    return [_exerciseList.exercises count] % 3 == 0 ? nums-1 : nums;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if([_exerciseList.exercises count] >= (section+1)*numberOfItems){
        return numberOfItems;
    }else{
        return [_exerciseList.exercises count]%numberOfItems;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;{
    ExerciseCollectionViewCell *cell = (ExerciseCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    NSInteger index = (indexPath.section == 0 ? indexPath.row : (indexPath.section)*numberOfItems+indexPath.row);
    [cell updateCellWithModel:[_exerciseList.exercises objectAtIndex:index]];
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
    if ([self.presentedViewController isKindOfClass:[ExerciseChapterViewController class]]){
        return nil;
    }else{
        ExerciseChapterViewController *peekViewController = [[ExerciseChapterViewController alloc] init];
        peekViewController.type = [StudyUtil indexToExerciseType:[self getIndexByPreviewing:previewingContext]];
        return peekViewController;
    }
}

- (void)previewingContext:(id<UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit{
    ExerciseChapterViewController *popViewController = [ExerciseChapterViewController controller];
    popViewController.type = [StudyUtil indexToExerciseType:[self getIndexByPreviewing:previewingContext]];
    [self showViewController:popViewController sender:self];
}


- (NSInteger)getIndexByPreviewing:(id<UIViewControllerPreviewing>)previewingContext{
    ExerciseCollectionViewCell  *cell = (ExerciseCollectionViewCell *)[[[previewingContext sourceView] superview] superview];
    NSIndexPath *indexPath = [_collectionView indexPathForCell:cell];
    NSInteger index = indexPath.section*numberOfItems + indexPath.row;
    return index;
}




@end
