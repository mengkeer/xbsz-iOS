//
//  ExerciseQuestionViewController.m
//  xbsz
//
//  Created by lotus on 2017/4/25.
//  Copyright © 2017年 lotus. All rights reserved.
//

#import "ExerciseQuestionViewController.h"
#import "QuestionCollectionViewCell.h"

static NSString *cellID = @"ExerciseQuestionCellID";
static NSInteger bottomHeight = 45;

@interface ExerciseQuestionViewController () <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,QuestionTableViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) UIButton *gotoBtn;

@property (nonatomic, strong) UIButton *preBtn;
@property (nonatomic, strong) UILabel *preLabel;

@property (nonatomic, strong) UIButton *nextBtn;
@property (nonatomic, strong) UILabel *nextLabel;

@end

@implementation ExerciseQuestionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"1/13";
    [self.customNavBarView addSubview:self.gotoBtn];
    self.customNavBarView.backgroundColor  = CXBackGroundColor;

    
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(CXScreenHeight-[self getStartOriginY]-bottomHeight);
        make.width.mas_equalTo(CXScreenWidth);
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(self.customNavBarView.mas_bottom);
    }];
    
    [self addBottomView];
    
}

- (void)addBottomView{
    UIView *bottomLeftBgView = [[UIView alloc] init];
    bottomLeftBgView.backgroundColor = CXBackGroundColor;
    UIView *bottomRightBgView = [[UIView alloc] init];
    bottomRightBgView.backgroundColor = CXBackGroundColor;
    
    [bottomLeftBgView addSubview:self.preBtn];
    [bottomLeftBgView addSubview:self.preLabel];
    [bottomRightBgView addSubview:self.nextBtn];
    [bottomRightBgView addSubview:self.nextLabel];
    [self.view addSubview:bottomLeftBgView];
    [self.view addSubview:bottomRightBgView];
    [bottomLeftBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.mas_equalTo(self.view);
        make.height.mas_equalTo(bottomHeight);
        make.width.mas_equalTo(CXScreenWidth/2);
    }];
    
    [_preBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(bottomLeftBgView.mas_centerX);
        make.width.height.mas_equalTo(20);
        make.top.mas_equalTo(bottomLeftBgView.mas_top).mas_offset(6);
    }];
    
    [_preLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(bottomLeftBgView.mas_centerX);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(14);
        make.bottom.mas_equalTo(bottomLeftBgView.mas_bottom).mas_offset(-2);

    }];
    
    [bottomRightBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.mas_equalTo(self.view);
        make.height.mas_equalTo(bottomHeight);
        make.width.mas_equalTo(CXScreenWidth/2);
    }];
    
    [_nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(bottomRightBgView.mas_centerX);
        make.width.height.mas_equalTo(20);
        make.top.mas_equalTo(bottomLeftBgView.mas_top).mas_offset(6);
    }];
    
    [_nextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(bottomRightBgView.mas_centerX);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(16);
        make.bottom.mas_equalTo(bottomRightBgView.mas_bottom).mas_offset(-2);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - getter/setter

- (UIButton *)gotoBtn{
    if(!_gotoBtn){
        _gotoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _gotoBtn.frame = CGRectMake(CXScreenWidth - 35, 20, 20, 44);
        [_gotoBtn setImage:[UIImage imageNamed:@"question_goto"] forState:UIControlStateNormal];
        [_gotoBtn setImage:[UIImage imageNamed:@"question_goto"] forState:UIControlStateHighlighted];
        [_gotoBtn addTarget:self action:@selector(questionGoto) forControlEvents:UIControlEventTouchUpInside];
    }
    return _gotoBtn;
}

- (UICollectionView *)collectionView{
    if(!_collectionView){
        UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.itemSize = CGSizeMake(CXScreenWidth , CXScreenHeight-[self getStartOriginY]-bottomHeight);
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
        [_collectionView registerClass:[QuestionCollectionViewCell class] forCellWithReuseIdentifier:cellID];
    }
    return _collectionView;
}


- (UIButton *)preBtn{
    if(!_preBtn){
        _preBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_preBtn setImage:[UIImage imageNamed:@"question_pre"] forState:UIControlStateNormal];
        [_preBtn addTarget:self action:@selector(pre) forControlEvents:UIControlEventTouchUpInside];
    }
    return _preBtn;
}

- (UILabel *)preLabel{
    if(!_preLabel){
        _preLabel = [[UILabel alloc] init];
        _preLabel.font = CXSystemFont(12);
        _preLabel.textAlignment = NSTextAlignmentCenter;
        _preLabel.textColor = CXHexColor(0x08b292);
        _preLabel.text = @"无";
        [_preLabel sizeToFit];
    }
    return _preLabel;
}

- (UIButton *)nextBtn{
    if(!_nextBtn){
        _nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_nextBtn setImage:[UIImage imageNamed:@"question_next"] forState:UIControlStateNormal];
        [_nextBtn addTarget:self action:@selector(next) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nextBtn;
}

- (UILabel *)nextLabel{
    if(!_nextLabel){
        _nextLabel = [[UILabel alloc] init];
        _nextLabel.font = CXSystemFont(12);
        _nextLabel.textAlignment = NSTextAlignmentCenter;
        _nextLabel.textColor = CXHexColor(0x08b292);
        _nextLabel.text = @"下一题";
        [_nextLabel sizeToFit];
    }
    return _nextLabel;
}
#pragma mark - UICollectionDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 2;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;{
    QuestionCollectionViewCell *cell = (QuestionCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    cell.selectDelegate = self;
    return cell;
}

#pragma mark - ExerciseChapterTableViewDelegate

- (void)selectOption:(NSInteger)index{
    CXLog(@"点击了选项%ld",index+1);
}

- (void)questionGoto{
    CXLog(@"跳转");
    self.title = @"2/13";
}

- (void)pre{
    CXLog(@"上一题");
}

- (void)next{
     CXLog(@"下一题");
}

@end
