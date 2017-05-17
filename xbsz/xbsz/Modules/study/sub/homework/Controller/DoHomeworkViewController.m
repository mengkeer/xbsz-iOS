//
//  DoHomeworkViewController.m
//  xbsz
//
//  Created by lotus on 2017/5/17.
//  Copyright © 2017年 lotus. All rights reserved.
//

#import "DoHomeworkViewController.h"
#import "CourseQuestion.h"
#import "CourseQuestionList.h"
#import "CourseQuestionCollectionViewCell.h"

static NSString *cellID = @"CourseQuestionCellID";
static NSInteger bottomHeight = 45;

@interface DoHomeworkViewController () <UICollectionViewDelegate,UICollectionViewDataSource,CourseQuestionOptionDelegate>

@property (nonatomic, strong) UIButton *gotoBtn;
@property (nonatomic, strong) UIButton *submitBtn;

@property (nonatomic, strong) UICollectionView *collectionView;


@property (nonatomic, strong) UIButton *preBtn;
@property (nonatomic, strong) UILabel *preLabel;

@property (nonatomic, strong) UIButton *nextBtn;
@property (nonatomic, strong) UILabel *nextLabel;

@property (nonatomic, copy) NSArray *questions;
@property (nonatomic, strong) CourseQuestionList *questionList;
@property (nonatomic, assign) NSInteger index;          //cell索引

@end

@implementation DoHomeworkViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.customNavBarView addSubview:self.gotoBtn];
    [self.customNavBarView addSubview:self.submitBtn];
    self.customNavBarView.backgroundColor  = [CXUserDefaults instance].bgColor;
    
    
    [self.customNavBarView addSubview:self.gotoBtn];
    [self.customNavBarView addSubview:self.submitBtn];
    self.customNavBarView.backgroundColor  = [CXUserDefaults instance].bgColor;
    
    
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(CXScreenHeight-[self getStartOriginY]-bottomHeight);
        make.width.mas_equalTo(CXScreenWidth);
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(self.customNavBarView.mas_bottom);
    }];
    
    [self addBottomView];

    [self loadData];
    
    self.title = [NSString stringWithFormat:@"1/%ld",[_questions count]];
    _index = 0;         //初始化cell索引为0
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadData{
    NSString *fileName = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"questions.json"];
    NSString *jsonStr = [NSString stringWithContentsOfFile:fileName encoding:NSUTF8StringEncoding error:nil];
    
    _questionList = [CourseQuestionList yy_modelWithJSON:jsonStr];
    
    _questions = _questionList.questions;
}

- (void)addBottomView{
    UIView *bottomLeftBgView = [[UIView alloc] init];
    bottomLeftBgView.backgroundColor = [CXUserDefaults instance].bgColor;
    UIView *bottomRightBgView = [[UIView alloc] init];
    bottomRightBgView.backgroundColor = [CXUserDefaults instance].bgColor;
    
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
        make.width.height.mas_equalTo(30);
        make.top.mas_equalTo(bottomLeftBgView.mas_top);
    }];
    
    [_preLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(bottomLeftBgView.mas_centerX);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(13);
        make.bottom.mas_equalTo(bottomLeftBgView.mas_bottom).mas_offset(-2);
        
    }];
    
    [bottomRightBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.mas_equalTo(self.view);
        make.height.mas_equalTo(bottomHeight);
        make.width.mas_equalTo(CXScreenWidth/2);
    }];
    
    [_nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(bottomRightBgView.mas_centerX);
        make.width.height.mas_equalTo(30);
        make.top.mas_equalTo(bottomLeftBgView.mas_top);
    }];
    
    [_nextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(bottomRightBgView.mas_centerX);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(13);
        make.bottom.mas_equalTo(bottomRightBgView.mas_bottom).mas_offset(-2);
    }];
}


#pragma mark - getter/setter

- (UIButton *)gotoBtn{
    if(!_gotoBtn){
        _gotoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _gotoBtn.frame = CGRectMake(CXScreenWidth - 44, 25, 34, 34);
        [_gotoBtn setImageEdgeInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
        [_gotoBtn setImage:[UIImage imageNamed:@"question_goto"] forState:UIControlStateNormal];
        [_gotoBtn setImage:[UIImage imageNamed:@"question_goto"] forState:UIControlStateHighlighted];
        [_gotoBtn addTarget:self action:@selector(questionGoto) forControlEvents:UIControlEventTouchUpInside];
    }
    return _gotoBtn;
}

- (UIButton *)submitBtn{
    if(!_submitBtn){
        _submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _submitBtn.frame = CGRectMake(CXScreenWidth - 78, 25, 34, 34);
        [_submitBtn setImageEdgeInsets:UIEdgeInsetsMake(5, 5,5,5)];
        [_submitBtn setImage:[UIImage imageNamed:@"exam_submit"] forState:UIControlStateNormal];
        [_submitBtn setImage:[UIImage imageNamed:@"exam_submit"] forState:UIControlStateHighlighted];
        [_submitBtn addTarget:self action:@selector(submitExam) forControlEvents:UIControlEventTouchUpInside];
    }
    return _submitBtn;
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
        _collectionView.backgroundColor = [CXUserDefaults instance].bgColor;
        _collectionView.dataSource = self;
        _collectionView.alwaysBounceHorizontal = YES;
        _collectionView.delegate = self;
        //        _collectionView.scrollEnabled = NO;
        _collectionView.pagingEnabled = YES;
        _collectionView.showsHorizontalScrollIndicator = NO;
        [_collectionView registerClass:[CourseQuestionCollectionViewCell class] forCellWithReuseIdentifier:cellID];
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
        _preLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pre)];
        [_preLabel addGestureRecognizer:tap];
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
        _nextLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(next)];
        [_nextLabel addGestureRecognizer:tap];
        [_nextLabel sizeToFit];
    }
    return _nextLabel;
}

#pragma mark - UICollectionDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [_questions count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;{
    CourseQuestionCollectionViewCell *cell = (CourseQuestionCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    cell.baseDelegate = self;
    
    CourseQuestion *question = [_questions objectAtIndex:indexPath.row];
    
    [cell updateUIByQuestion:question];
    return cell;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGFloat startX = scrollView.contentOffset.x;
    NSInteger index = startX/CXScreenWidth;
    _index = index;
    self.title = [NSString stringWithFormat:@"%ld/%ld",index+1,[_questions count]];
    [self updatePreAndNextLabel:_index];
}

- (void)selectOption:(NSInteger)selectedIndex{
    
}

#pragma mark - 处理事件

- (void)pre{
    if(_index <= 0){
        [ToastView showErrorWithStaus:@"没有上一题了"];
        return;
    }
    --_index;
    NSIndexPath *path = [NSIndexPath indexPathForRow:_index inSection:0];
    [_collectionView scrollToItemAtIndexPath:path atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
    [_collectionView reloadItemsAtIndexPaths:@[path]];
    [self updatePreAndNextLabel:_index];
}

- (void)next{
    if(_index == [_questions count] -1){
        [self submitExam];
        return;
    }
    ++_index;
    NSIndexPath *path = [NSIndexPath indexPathForRow:_index inSection:0];
    [_collectionView scrollToItemAtIndexPath:path atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
    [_collectionView reloadItemsAtIndexPaths:@[path]];
    [self updatePreAndNextLabel:_index];
    
}

- (void)updatePreAndNextLabel:(NSInteger)index{

}

- (void)questionGoto{
    
}

- (void)submitExam{
    
    
}



@end
