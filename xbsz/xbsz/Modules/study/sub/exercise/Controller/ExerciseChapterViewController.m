//
//  ExerciseChapterViewController.m
//  xbsz
//
//  Created by lotus on 2017/4/24.
//  Copyright © 2017年 lotus. All rights reserved.
//

#import "ExerciseChapterViewController.h"
#import "ExerciseChapterCollectionViewCell.h"
#import "FMDBUtil.h"
#import "PYSearch.h"
#import "QuestionSearchViewController.h"
#import "CXNavigationController.h"
#import "ReciteViewController.h"
#import "SinglePracticeViewController.h"
#import "MutiPracticeViewController.h"

#import "AppUtil.h"

@import GoogleMobileAds;


static NSString *cellID = @"ChapterCellID";

@interface ExerciseChapterViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,ExerciseChapterTableViewDelegate,GADBannerViewDelegate>

@property (nonatomic, strong) UISegmentedControl *segmentControl;

@property (nonatomic, strong) UIButton *searchBtn;

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) GADBannerView *bannerView;


@end

@implementation ExerciseChapterViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if(_mode == ExerciseModeMistakes)   [_collectionView reloadData];
    
    GADRequest *request = [GADRequest request];
    request.testDevices = @[ kGADSimulatorID];
    if([AppUtil showAD])     [self.bannerView loadRequest:request];
}

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
    
    //添加广告
    self.bannerView = [[GADBannerView alloc] initWithAdSize:kGADAdSizeSmartBannerPortrait];
    self.bannerView.adUnitID = @"ca-app-pub-7139153640152838/2219205900";
    self.bannerView.rootViewController = self;
    
    [self.view addSubview:self.bannerView];
    [self.bannerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(320);
        make.height.mas_equalTo(50);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.bottom.mas_equalTo(self.view.mas_bottom);
    }];
    
    self.bannerView.delegate = self;
    
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
        _searchBtn.frame = CGRectMake(CXScreenWidth - 47, 20, 44, 44);
        _searchBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 12, 0, 12);
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
    // 2. 创建控制器
    PYSearchViewController *searchViewController = [PYSearchViewController searchViewControllerWithHotSearches:nil searchBarPlaceholder:@"搜索题干、选项" didSearchBlock:^(PYSearchViewController *searchViewController, UISearchBar *searchBar, NSString *searchText) {
        // 开始搜索执行以下代码
        // 如：跳转到指定控制器
        if(searchText == nil || [[searchText stringByTrim] length] == 0){
            [ToastView showErrorWithStaus:@"搜索内容为空"];
        }else{
            [searchViewController.navigationController dismissViewControllerAnimated:NO completion:nil];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.05 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                QuestionSearchViewController *vc = [QuestionSearchViewController controller];
                vc.type = _type;
                vc.searchText = [searchText stringByTrim];
                [self.lcNavigationController pushViewController:vc];
            });
            
          
        }
    }];
    // 3. 设置风格
    searchViewController.hotSearchStyle = PYHotSearchStyleColorfulTag;
    searchViewController.searchHistoryStyle = PYSearchHistoryStyleDefault;
    // 4. 设置代理
    // 5. 跳转到搜索控制器
    CXNavigationController *nav = [[CXNavigationController alloc] initWithRootViewController:searchViewController];
    [self presentViewController:nav animated:YES completion:nil];}

#pragma mark - ExerciseChapterTableViewDelegate

- (void)selectChapter:(NSInteger)index{
    if(_mode == ExerciseModeRecite){
        ReciteViewController *questionVC = [ReciteViewController controller];
        questionVC.mode = _mode;
        questionVC.type = _type;
        questionVC.isSingle = _segmentControl.selectedSegmentIndex == 0 ? YES : NO;
        questionVC.chapterIndex = index;
        [self.lcNavigationController pushViewController:questionVC];

    }else if(_mode == ExerciseModePractice || _mode == ExerciseModePracticeRandom || _mode == ExerciseModeMistakes){
        if(_segmentControl.selectedSegmentIndex == 0){
            SinglePracticeViewController *questionVC = [SinglePracticeViewController controller];
            [questionVC updateData:_mode type:_type chapter:index];
            [self.lcNavigationController pushViewController:questionVC];
        }else{
            MutiPracticeViewController *questionVC = [MutiPracticeViewController controller];
            [questionVC updateData:_mode type:_type chapter:index];
            [self.lcNavigationController pushViewController:questionVC];
        }
    }
    else{
        [ToastView showErrorWithStaus:@"该模式还未开放"];
    }
   
}


- (void)popFromCurrentViewController{
    [super popFromCurrentViewController];
    [FMDBUtil closeDB];
}

#pragma mark - 广告代理事件

- (void)adViewDidReceiveAd:(GADBannerView *)bannerView {
    bannerView.hidden = NO;
}

- (void)adView:(GADBannerView *)adView didFailToReceiveAdWithError:(GADRequestError *)error {
    NSLog(@"adView:didFailToReceiveAdWithError: %@", error.localizedDescription);
}

@end
