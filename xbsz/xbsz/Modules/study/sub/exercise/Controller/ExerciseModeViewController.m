//
//  ExerciseModeViewController.m
//  xbsz
//
//  Created by lotus on 2017/4/28.
//  Copyright © 2017年 lotus. All rights reserved.
//

#import "ExerciseModeViewController.h"
#import "PYSearch.h"
#import "QuestionSearchViewController.h"
#import "ExerciseChapterViewController.h"
#import "ExamViewController.h"
#import "CXNavigationController.h"

#import "AppUtil.h"

@import GoogleMobileAds;

static NSInteger cellWidth = 80;
static NSInteger cellHeight = 110;
static NSString *cellID = @"ExerciseModeCollectionViewCell";
static NSInteger numberOfItems = 3;

@interface ExerciseModeViewController () <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,GADBannerViewDelegate>

@property (nonatomic, strong) UIButton *searchBtn;

@property (nonatomic, strong) UICollectionView *collectionView;


@property (nonatomic, strong) GADBannerView *bannerView;

@end

@implementation ExerciseModeViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    GADRequest *request = [GADRequest request];
    request.testDevices = @[ kGADSimulatorID ];
    if([AppUtil showAD])     [self.bannerView loadRequest:request];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"模式选择";
    
    [self.customNavBarView addSubview:self.searchBtn];
    self.customNavBarView.backgroundColor = CXBackGroundColor;
    
    
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view.mas_top).mas_offset(CX_PHONE_NAVIGATIONBAR_HEIGHT);
        make.bottom.mas_equalTo(self.view.mas_bottom);
    }];
    
//    //添加广告
//    self.bannerView = [[GADBannerView alloc] initWithAdSize:kGADAdSizeSmartBannerPortrait];
//    self.bannerView.adUnitID = @"ca-app-pub-7139153640152838/9742472707";
//    self.bannerView.rootViewController = self;
//    
//    [self.view addSubview:self.bannerView];
//    [self.bannerView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.width.mas_equalTo(320);
//        make.height.mas_equalTo(50);
//        make.centerX.mas_equalTo(self.view.mas_centerX);
//        make.bottom.mas_equalTo(self.view.mas_bottom).mas_offset(-CX_PHONEX_HOME_INDICATOR_HEIGHT);
//    }];
//
//    
//    self.bannerView.delegate = self;
    
}


#pragma mark - 3DTouch Item
- (NSArray<id<UIPreviewActionItem>> *)previewActionItems{
    
    // 生成UIPreviewAction
    UIPreviewAction *action1 = [UIPreviewAction actionWithTitle:@"预览模式" style:UIPreviewActionStyleDefault handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        [self gotoChapterViewController:_type mode:ExerciseModeRecite];
    }];
    
    UIPreviewAction *action2 = [UIPreviewAction actionWithTitle:@"训练模式(顺序)" style:UIPreviewActionStyleDefault handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        [self gotoChapterViewController:_type mode:ExerciseModePractice];
        
    }];
    
    UIPreviewAction *action3 = [UIPreviewAction actionWithTitle:@"训练模式(随机)" style:UIPreviewActionStyleDefault handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        [self gotoChapterViewController:_type mode:ExerciseModePracticeRandom];
        
    }];
    
    UIPreviewAction *action4 = [UIPreviewAction actionWithTitle:@"模拟考场" style:UIPreviewActionStyleDefault handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        [self gotoChapterViewController:_type mode:ExerciseModeExam];
        
    }];
    
    UIPreviewAction *action5 = [UIPreviewAction actionWithTitle:@"错题集" style:UIPreviewActionStyleDefault handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        [self gotoChapterViewController:_type mode:ExerciseModeMistakes];
    }];
    
    
    NSArray *actions = @[action1, action2, action3,action4,action5];
    return actions;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - getter/setter
- (UIButton *)searchBtn{
    if(!_searchBtn){
        _searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _searchBtn.frame = CGRectMake(CXScreenWidth - 47, CX_PHONE_STATUSBAR_HEIGHT, 44, 44);
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
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.itemSize = CGSizeMake(cellWidth ,cellHeight);
        CGFloat gap = (CXScreenWidth-cellWidth*numberOfItems)/4;
        layout.minimumLineSpacing = 60;
        layout.minimumInteritemSpacing = gap;
        layout.sectionInset = UIEdgeInsetsMake(60, gap, 20, gap);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.backgroundColor = CXWhiteColor;
        _collectionView.dataSource = self;
        _collectionView.alwaysBounceHorizontal = NO;
        _collectionView.alwaysBounceVertical = YES;
        _collectionView.delegate = self;
        [_collectionView registerClass:[ExerciseModeCollectionViewCell class] forCellWithReuseIdentifier:cellID];
    }
    return _collectionView;
}

#pragma private method

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
                [self.navigationController pushViewController:vc animated:YES];
            });
      
        }
    }];
    // 3. 设置风格
    searchViewController.hotSearchStyle = PYHotSearchStyleColorfulTag;
    searchViewController.searchHistoryStyle = PYSearchHistoryStyleDefault;
    // 4. 设置代理
    // 5. 跳转到搜索控制器
    UINavigationController *nav = [[CXNavigationController alloc] initWithRootViewController:searchViewController];
    
    nav.modalPresentationStyle = UIModalPresentationFullScreen;
    nav.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    
    [self presentViewController:nav animated:YES completion:nil];
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self gotoChapterViewController:indexPath.row];
}

#pragma mark - UICollectionDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 5;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;{
    ExerciseModeCollectionViewCell *cell = (ExerciseModeCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    NSInteger index = (indexPath.section*numberOfItems)+indexPath.row;
    [cell updateUIByQuestionIndex:index];
    return cell;
}

#pragma mark - 自定义的方法

- (void)gotoChapterViewController:(NSInteger)index{
    ExerciseMode mode;
    if(index == 0)    mode = ExerciseModeRecite;
    else if(index == 1)    mode = ExerciseModePractice;
    else if(index == 2)    mode = ExerciseModePracticeRandom;
    else if(index == 3)    mode = ExerciseModeExam;
    else if(index == 4)    mode = ExerciseModeMistakes;
    else   mode = ExerciseModeUnknown;
    
    if(mode == ExerciseModeExam){
        ExamViewController *exam = [ExamViewController controller];
        exam.type = _type;
        [self.navigationController pushViewController:exam animated:YES];
        return;
    }
   
    ExerciseChapterViewController *chapterVC = [ExerciseChapterViewController controller];
    chapterVC.type = _type;
    chapterVC.mode = mode;
    [self.navigationController pushViewController:chapterVC animated:YES];
}

- (void)gotoChapterViewController:(ExerciseType)type mode:(ExerciseMode)mode{
    ExerciseModeViewController *modeVC = [ExerciseModeViewController controller];
    modeVC.type = type;
    [self.beforePeekedViewConreoller.navigationController pushViewController:modeVC animated:YES];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        ExerciseChapterViewController *chapterVC = [ExerciseChapterViewController controller];
        chapterVC.type = type;
        chapterVC.mode = mode;
        [self.navigationController pushViewController:chapterVC animated:YES];
    });

}

#pragma mark - 广告代理事件

//- (void)adViewDidReceiveAd:(GADBannerView *)bannerView {
//    bannerView.hidden = NO;
//}
//
//- (void)adView:(GADBannerView *)adView didFailToReceiveAdWithError:(GADRequestError *)error {
//    NSLog(@"adView:didFailToReceiveAdWithError: %@", error.localizedDescription);
//}

@end

#pragma mark - 自定义的CEll
@implementation ExerciseModeCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self initCollectionCell];
    }
    return self;
}

- (void)initCollectionCell{
    [self.contentView addSubview:self.modeImageView];
    [_modeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(64);
        make.left.mas_equalTo(self.contentView).mas_offset(8);
        make.right.mas_equalTo(self.contentView.mas_right).mas_offset(-8);
        make.top.mas_equalTo(self.contentView.mas_top).mas_offset(8);
    }];
    
    [self.contentView addSubview:self.modeTitle];
    [_modeTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(30);
        make.left.right.bottom.mas_equalTo(self.contentView);
    }];
    
}

- (UILabel *)modeTitle{
    if(!_modeTitle){
        _modeTitle = [[UILabel alloc] init];
        _modeTitle.font = CXSystemFont(13);
        _modeTitle.textColor = CXBlackColor;
        _modeTitle.textAlignment = NSTextAlignmentCenter;
    }
    return _modeTitle;
}

- (UIImageView *)modeImageView{
    if(!_modeImageView){
        _modeImageView = [[UIImageView alloc] init];
        _modeImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _modeImageView;
}

- (void)updateUIByQuestionIndex:(NSInteger)index{
    _modeImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"exercise_mode%ld",index+1]];
    [_modeImageView mas_updateConstraints:^(MASConstraintMaker *make) {
        if(index == 0){
            make.left.mas_equalTo(self.contentView).mas_offset(11);
        }else{
            make.left.mas_equalTo(self.contentView).mas_offset(8);
        }
    }];
    
    _modeTitle.text = [self indexConvertToModeTitle:index];
    
}

- (NSString *)indexConvertToModeTitle:(NSInteger)index{
    if(index == 0){
        return @"题目预览";
    }else if(index == 1){
        return @"练习·顺序";
    }else if(index == 2){
        return @"练习·随机";
    }else if(index == 3){
        return @"模拟考场";
    }else if(index == 4){
        return @"错题集";
    }else{
        return @"未知模式";
    }
}

@end
