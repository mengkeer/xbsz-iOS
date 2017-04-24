//
//  ExerciseChapterViewController.m
//  xbsz
//
//  Created by lotus on 2017/4/24.
//  Copyright © 2017年 lotus. All rights reserved.
//

#import "ExerciseChapterViewController.h"
#import "ExerciseChapterCollectionViewCell.h"

static NSString *cellID = @"ChapterCellID";

@interface ExerciseChapterViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UISegmentedControl *segmentControl;

@property (nonatomic, strong) UIButton *searchBtn;

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation ExerciseChapterViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.customNavBarView addSubview:self.segmentControl];
    [self.customNavBarView addSubview:self.searchBtn];
    self.customNavBarView.backgroundColor  = CXBackGroundColor;
    [_segmentControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(120);
        make.centerX.mas_equalTo(self.customNavBarView.mas_centerX);
        make.height.mas_equalTo(26);
        make.top.mas_equalTo(self.customNavBarView.mas_top).mas_offset(29);
    }];
    
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(CXScreenHeight-[self getStartOriginY]);
        make.width.mas_equalTo(CXScreenWidth);
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(self.customNavBarView.mas_bottom);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - getter/setter
- (UISegmentedControl *)segmentControl{
    if(!_segmentControl){
        _segmentControl = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"单选",@"多选" ,nil]];
        _segmentControl.selectedSegmentIndex = 0;
        _segmentControl.tintColor = [UIColor brownColor];
        [_segmentControl addTarget:self action:@selector(segementValueChanged:) forControlEvents:UIControlEventValueChanged];
    }
    return _segmentControl;
}

- (UIButton *)searchBtn{
    if(!_searchBtn){
        _searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _searchBtn.frame = CGRectMake(CXScreenWidth - 35, 20, 20, 44);
        [_searchBtn setImage:[UIImage imageNamed:@"question_search"] forState:UIControlStateNormal];
        [_searchBtn setImage:[UIImage imageNamed:@"question_search"] forState:UIControlStateHighlighted];
        [_searchBtn addTarget:self action:@selector(questionSearch) forControlEvents:UIControlEventTouchUpInside];
    }
    return _searchBtn;
}

- (UICollectionView *)collectionView{
    if(!_collectionView){
        UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.backgroundColor = CXWhiteColor;
        _collectionView.dataSource = self;
        _collectionView.alwaysBounceHorizontal = YES;
        _collectionView.delegate = self;
        _collectionView.pagingEnabled = YES;
        _collectionView.showsHorizontalScrollIndicator = NO;
        [_collectionView registerClass:[ExerciseChapterCollectionViewCell class] forCellWithReuseIdentifier:cellID];
    }
    return _collectionView;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    CXLog(@"点击了单选或多选");
}


#pragma mark - UICollctionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(CXScreenWidth , CXScreenHeight-[self getStartOriginY]);
}

//最小行间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

//最小列间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

#pragma mark - UICollectionDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 2;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;{
    ExerciseChapterCollectionViewCell *cell = (ExerciseChapterCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    cell.exercise = _exercise;
    return cell;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath{
    return NO;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGFloat startX = scrollView.contentOffset.x;
    NSInteger index = startX/CXScreenWidth;
    [_segmentControl setSelectedSegmentIndex:index];
}


#pragma private method
- (void)segementValueChanged:(UISegmentedControl *)segementControl{
    NSInteger index = segementControl.selectedSegmentIndex;
    NSIndexPath *path = [NSIndexPath indexPathForRow:index inSection:0];
    [_collectionView scrollToItemAtIndexPath:path atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
}

- (void)questionSearch{
    CXLog(@"搜索题目");
}

@end
