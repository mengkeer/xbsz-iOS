//
//  ExerciseChapterViewController.m
//  xbsz
//
//  Created by lotus on 2017/4/24.
//  Copyright © 2017年 lotus. All rights reserved.
//

#import "ExerciseChapterViewController.h"
#import "ExerciseChapterCollectionViewCell.h"
#import "ExerciseQuestionViewController.h"
#import "StudyUtil.h"
#import "UINavigationController+TZPopGesture.h"


static NSString *cellID = @"ChapterCellID";

@interface ExerciseChapterViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,ExerciseChapterTableViewDelegate>

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
    
    [self tz_addPopGestureToView:_collectionView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 3DTouch Item
- (NSArray<id<UIPreviewActionItem>> *)previewActionItems{
    
    // 生成UIPreviewAction
    UIPreviewAction *action1 = [UIPreviewAction actionWithTitle:@"预览模式" style:UIPreviewActionStyleDefault handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        _mode = ExerciseModeRecite;
    }];
    
    UIPreviewAction *action2 = [UIPreviewAction actionWithTitle:@"训练模式(顺序)" style:UIPreviewActionStyleDefault handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        _mode = ExerciseModePractice;
    }];
    
    UIPreviewAction *action3 = [UIPreviewAction actionWithTitle:@"训练模式(随机)" style:UIPreviewActionStyleDefault handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        _mode = ExerciseModePracticeRandom;
    }];
    
    UIPreviewAction *action4 = [UIPreviewAction actionWithTitle:@"模拟考场" style:UIPreviewActionStyleDefault handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        _mode = ExerciseModeExam;
    }];
    
    UIPreviewAction *action5 = [UIPreviewAction actionWithTitle:@"错题集" style:UIPreviewActionStyleDefault handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        _mode = ExerciseModeMistakes;
    }];
    
    
    NSArray *actions = @[action1, action2, action3,action4,action5];
    return actions;
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
        layout.itemSize = CGSizeMake(CXScreenWidth , CXScreenHeight-[self getStartOriginY]);
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        
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

#pragma mark - UICollectionDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 2;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;{
    ExerciseChapterCollectionViewCell *cell = (ExerciseChapterCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    cell.selectDelegate = self;
    BOOL isSingle = indexPath.row == 0 ? YES : NO;
    [cell upadteUIByType:_type mode:_mode isSingle:isSingle];
    return cell;
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

#pragma mark - ExerciseChapterTableViewDelegate

- (void)selectChapter:(NSInteger)index{
    ExerciseQuestionViewController *questionVC = [ExerciseQuestionViewController controller];
    questionVC.mode = ExerciseModeRecite;
    questionVC.type = _type;
    questionVC.isSingle = _segmentControl.selectedSegmentIndex == 0 ? YES : NO;
    questionVC.chapterIndex = index;
    [self.navigationController pushViewController:questionVC animated:YES];
}


- (void)popFromCurrentViewController{
    [super popFromCurrentViewController];
    [StudyUtil closeDB];
}

@end
