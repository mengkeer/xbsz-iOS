//
//  PracticeViewController.m
//  xbsz
//
//  Created by lotus on 2017/4/28.
//  Copyright © 2017年 lotus. All rights reserved.
//

#import "MutiPracticeViewController.h"
#import "FMDBUtil.h"
#import "ExerciseProgressViewController.h"
#import "QuestionCollectionViewCell.h"
#import "UINavigationController+FDFullscreenPopGesture.h"
#import "CXAudioPlayer.h"

static NSString *cellID = @"ExercisePracticeQuestionCellID";
static NSInteger bottomHeight = 45;

@interface MutiPracticeViewController () <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,QuestionOptionDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) UIButton *gotoBtn;
@property (nonatomic, strong) UIButton *restartBtn;
@property (nonatomic, strong) UIButton *removeBtn;
@property (nonatomic, strong) UIButton *showBtn;


@property (nonatomic, strong) UIButton *preBtn;
@property (nonatomic, strong) UILabel *preLabel;

@property (nonatomic, strong) UIButton *nextBtn;
@property (nonatomic, strong) UILabel *nextLabel;

@property (nonatomic, copy) NSArray *questions;         //题目集合

@property (nonatomic, assign) NSInteger index;          //cell索引

@property (nonatomic, strong) NSMutableDictionary *practicedDic;
@property (nonatomic, strong) NSMutableDictionary *judgedDic;
@property (nonatomic, strong) NSMutableDictionary *removedDic;

@end

@implementation MutiPracticeViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.fd_interactivePopDisabled = YES;
    [CXUserDefaults instance].forbidPopGesture = YES;
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [CXUserDefaults instance].forbidPopGesture = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.customNavBarView addSubview:self.gotoBtn];
    [self.customNavBarView addSubview:self.restartBtn];
    if(_mode == ExerciseModeMistakes){
        [self.customNavBarView addSubview:self.removeBtn];
    }
    [self.customNavBarView addSubview:self.showBtn];            //暂时不显示该按钮
    self.customNavBarView.backgroundColor  = [CXUserDefaults instance].bgColor;
    
    
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(CXScreenHeight-[self getStartOriginY]-bottomHeight-CX_PHONEX_HOME_INDICATOR_HEIGHT);
        make.width.mas_equalTo(CXScreenWidth);
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(self.customNavBarView.mas_bottom);
    }];
    
    [self addBottomView];
    
    [self loadData];
    self.title = [NSString stringWithFormat:@"1/%ld",[_questions count]];
    _index = 0;         //初始化cell索引为0
    _practicedDic = [[NSMutableDictionary alloc] init];
    _judgedDic = [[NSMutableDictionary alloc] init];
    _removedDic = [[NSMutableDictionary alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//加载题库数据
- (void)loadData{
    if(_mode == ExerciseModePractice){
        _questions = [FMDBUtil getQuestions:_type isSingle:NO chapterIndex:_chapterIndex];
    }else if(_mode == ExerciseModePracticeRandom){
        _questions = [FMDBUtil getQuestions:_type isSingle:NO chapterIndex:_chapterIndex];
        _questions = [_questions sortedArrayUsingComparator:^NSComparisonResult(ExerciseQuestion *one, ExerciseQuestion *two) {
            int seed = arc4random_uniform(2);
            if (seed) {
                return [one.title compare:two.title];
            } else {
                return [two.title compare:one.title];
            }
        }];
    }else if(_mode == ExerciseModeMistakes){
        _questions = [FMDBUtil getQuestions:_type isSingle:NO isWrong:YES chapterIndex:_chapterIndex];
    }
    [_collectionView reloadData];
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
        make.height.mas_equalTo(bottomHeight+CX_PHONEX_HOME_INDICATOR_HEIGHT);
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
        make.top.mas_equalTo(_preBtn.mas_bottom);
        
    }];
    
    [bottomRightBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.mas_equalTo(self.view);
        make.height.mas_equalTo(bottomHeight+CX_PHONEX_HOME_INDICATOR_HEIGHT);
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
        make.top.mas_equalTo(_nextBtn.mas_bottom);
    }];
}


#pragma mark - getter/setter

- (UIButton *)gotoBtn{
    if(!_gotoBtn){
        _gotoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _gotoBtn.frame = CGRectMake(CXScreenWidth - 44, CX_PHONE_STATUSBAR_HEIGHT+5, 34, 34);
        [_gotoBtn setImageEdgeInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
        [_gotoBtn setImage:[UIImage imageNamed:@"question_goto"] forState:UIControlStateNormal];
        [_gotoBtn setImage:[UIImage imageNamed:@"question_goto"] forState:UIControlStateHighlighted];
        [_gotoBtn addTarget:self action:@selector(questionGoto) forControlEvents:UIControlEventTouchUpInside];
    }
    return _gotoBtn;
}

- (UIButton *)restartBtn{
    if(!_restartBtn){
        _restartBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _restartBtn.frame = CGRectMake(CXScreenWidth - 78, CX_PHONE_STATUSBAR_HEIGHT+5, 34, 34);
        [_restartBtn setImageEdgeInsets:UIEdgeInsetsMake(5, 5,5,5)];
        [_restartBtn setImage:[UIImage imageNamed:@"question_restart"] forState:UIControlStateNormal];
        [_restartBtn setImage:[UIImage imageNamed:@"question_restart"] forState:UIControlStateHighlighted];
        [_restartBtn addTarget:self action:@selector(restartByWrongQuestion) forControlEvents:UIControlEventTouchUpInside];
    }
    return _restartBtn;
}

- (UIButton *)removeBtn{
    if(!_removeBtn){
        _removeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _removeBtn.frame = CGRectMake(CXScreenWidth - 112, CX_PHONE_STATUSBAR_HEIGHT+5, 34, 34);
        [_removeBtn setImageEdgeInsets:UIEdgeInsetsMake(4, 7,4,1)];
        [_removeBtn setImage:[UIImage imageNamed:@"question_remove"] forState:UIControlStateNormal];
        [_removeBtn setImage:[UIImage imageNamed:@"question_remove"] forState:UIControlStateHighlighted];
        [_removeBtn addTarget:self action:@selector(removeQuestion) forControlEvents:UIControlEventTouchUpInside];
    }
    return _removeBtn;
}

- (UIButton *)showBtn{
    if(!_showBtn){
        _showBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        if(_mode != ExerciseModeMistakes){
            _showBtn.frame = CGRectMake(CXScreenWidth - 112, CX_PHONE_STATUSBAR_HEIGHT+5, 34, 34);
            [_showBtn setImageEdgeInsets:UIEdgeInsetsMake(4, 6,4,2)];
        }else{
            _showBtn.frame = CGRectMake(CXScreenWidth - 146, CX_PHONE_STATUSBAR_HEIGHT+5, 34, 34);
            [_showBtn setImageEdgeInsets:UIEdgeInsetsMake(4, 7,4,1)];
        }
        
        [_showBtn setImage:[UIImage imageNamed:@"show_answer"] forState:UIControlStateNormal];
        [_showBtn setImage:[UIImage imageNamed:@"show_answer"] forState:UIControlStateHighlighted];
        [_showBtn addTarget:self action:@selector(showAnswer) forControlEvents:UIControlEventTouchUpInside];
    }
    return _showBtn;
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
    QuestionCollectionViewCell *cell = (QuestionCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    cell.baseDelegate = self;
    NSString *key = [NSString stringWithFormat:@"%ld",indexPath.row];
    ExerciseQuestion *question = [_questions objectAtIndex:indexPath.row];
    if([_judgedDic containsObjectForKey:key]){
        [cell updateUIByQuestion:question allowSelect:NO];
    }else{
        [cell updateUIByQuestion:question allowSelect:YES];
    }
    //从已做过的记录中回复做题记录
    if([_practicedDic containsObjectForKey:key]){
        NSString *selectedIndexs = [_practicedDic valueForKey:key];
        if([_judgedDic containsObjectForKey:key])       [cell showMutiPracticeAnswer:selectedIndexs];
        else        [cell setTemporarySelected:selectedIndexs];
    }
    
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


#pragma mark - ExerciseChapterTableViewDelegate

- (void)selectOption:(NSInteger)selectedIndex{

    NSString *key = [NSString stringWithFormat:@"%ld",_index];
    NSString *newValue = [NSString stringWithFormat:@"%ld",selectedIndex];
    
    if([_judgedDic containsObjectForKey:key])  return;
    
    BOOL isSelected = YES;
    if([_practicedDic containsObjectForKey:key]){
        NSString *value = [_practicedDic valueForKey:key];
        if([value containsString:newValue]){
            isSelected = NO;
            value = [value stringByReplacingOccurrencesOfString:newValue withString:@""];
            [_practicedDic setValue:value forKey:key];
        }else{
            isSelected = YES;
            value = [NSString stringWithFormat:@"%@%@",value,newValue];
            [_practicedDic setValue:value forKey:key];
        }
    }else{
        isSelected = YES;
        [_practicedDic setValue:newValue forKey:key];
    }
    
    
    NSIndexPath *path = [NSIndexPath indexPathForRow:_index inSection:0];
    QuestionCollectionViewCell *cell = (QuestionCollectionViewCell *)[_collectionView cellForItemAtIndexPath:path];
    [cell setTemporarySelected:[_practicedDic objectForKey:key]];
    
}

- (void)questionGoto{
    ExerciseProgressViewController *progressVC = [ExerciseProgressViewController controller];
    [progressVC updateData:_mode total:[_questions count] practicedDic:_practicedDic judgedDic:_judgedDic currentIndex:_index clicked:^(NSInteger index) {
        if(index >= 0){
            _index = index;
            NSIndexPath *path = [NSIndexPath indexPathForRow:index inSection:0];
            [_collectionView scrollToItemAtIndexPath:path atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
            [self updatePreAndNextLabel:index];
            [_collectionView reloadData];
        }
    }];
    [self presentViewController:progressVC animated:YES completion:nil];
}

#pragma mark - 私有方法

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
    NSString *key = [NSString stringWithFormat:@"%ld",_index];
    if(_index == [_questions count] -1 && [_judgedDic containsObjectForKey:key]){
        [self restartByWrongQuestion];
        return;
    }
    NSString *val = [_practicedDic valueForKey:key];
    if([_judgedDic containsObjectForKey:key] || val == nil || [val length] == 0){
        if(_index == [_questions count] - 1){
            [self restartByWrongQuestion];
            return;
        }
        ++_index;
        NSIndexPath *path = [NSIndexPath indexPathForRow:_index inSection:0];
        [_collectionView scrollToItemAtIndexPath:path atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
        [_collectionView reloadItemsAtIndexPaths:@[path]];
        [self updatePreAndNextLabel:_index];
        
    }else{
        NSIndexPath *path = [NSIndexPath indexPathForRow:_index inSection:0];
        QuestionCollectionViewCell *cell = (QuestionCollectionViewCell *)[_collectionView cellForItemAtIndexPath:path];
        BOOL isRight = [cell showMutiPracticeAnswer:[_practicedDic objectForKey:key]];
        if(isRight == YES){
            [CXAudioPlayer playSoundByFilename:@"correct"];
            [_judgedDic setValue:@"1" forKey:key];
             [self performSelector:@selector(next) withObject:nil afterDelay:0.5];
            
        }else{
            [CXAudioPlayer playSoundByFilename:@"mistake"];
            [_judgedDic setValue:@"-1" forKey:key];
            ExerciseQuestion *question = [_questions objectAtIndex:_index];
            if(question.flag != -1)     [FMDBUtil setQuestionFlag:_type quesionID:question.question_id isWrong:YES];
        }
        [self updatePreAndNextLabel:_index];
    }
    
}

- (void)updatePreAndNextLabel:(NSInteger)index{
    if(_index == 0){
        _preLabel.text = @"无";
        _nextLabel.text = @"下一题";
    }else if(_index == [_questions count] -1){
        _preLabel.text = @"上一题";
        NSString *key = [NSString stringWithFormat:@"%ld",index];
        if([_judgedDic containsObjectForKey:key]){
            _nextLabel.text = @"错题重做";
        }else{
            _nextLabel.text = @"下一题";
        }
    }else{
        _preLabel.text = @"上一题";
        _nextLabel.text = @"下一题";
    }
    self.title = [NSString stringWithFormat:@"%ld/%ld",index+1,[_questions count]];
    
    NSString *key = [NSString stringWithFormat:@"%ld",index];
    if([_removedDic containsObjectForKey:key] && [[_removedDic valueForKey:key] isEqualToString:@"1"]){
        [_removeBtn setImage:[UIImage imageNamed:@"question_removed"] forState:UIControlStateNormal];
        [_removeBtn setImage:[UIImage imageNamed:@"question_removed"] forState:UIControlStateHighlighted];
    }else{
        [_removeBtn setImage:[UIImage imageNamed:@"question_remove"] forState:UIControlStateNormal];
        [_removeBtn setImage:[UIImage imageNamed:@"question_remove"] forState:UIControlStateHighlighted];
    }
}

#pragma mark - 共有方法

- (void)updateData:(ExerciseMode)mode type:(ExerciseType)type chapter:(NSInteger)chapterIndex{
    _mode = mode;
    _type = type;
    _chapterIndex = chapterIndex;
}

- (void)restartByWrongQuestion{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"错题重做" message:@"以当前练习的错题进行下一轮练习" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:cancel];
    
    UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        NSMutableArray *arr = [NSMutableArray array];
        for(NSInteger i = 0;i<[_questions count];i++){
            NSString *key = [NSString stringWithFormat:@"%ld",i];
            if([_judgedDic containsObjectForKey:key] && [[_judgedDic valueForKey:key] isEqualToString:@"-1"]){
                [arr addObject:[_questions objectAtIndex:i]];
            }
        }
        
        if([arr count] == 0){
            [ToastView showErrorWithStaus:@"本轮练习无错题"];
            return ;
        }
        
        _questions = arr;
        [_practicedDic removeAllObjects];
        [_judgedDic removeAllObjects];
        self.title =     self.title = [NSString stringWithFormat:@"1/%ld",[_questions count]];
        _index = 0;
        [_collectionView reloadData];
        NSIndexPath *path = [NSIndexPath indexPathForRow:_index inSection:0];
        [_collectionView scrollToItemAtIndexPath:path atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
        [self updatePreAndNextLabel:_index];
    }];
    [alert addAction:confirm];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)removeQuestion{
    ExerciseQuestion *quesion = [_questions objectAtIndex:_index];
    NSString *key = [NSString stringWithFormat:@"%ld",_index];
    if([_removedDic containsObjectForKey:key] && [[_removedDic valueForKey:key] isEqualToString:@"1"]){
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"是否添加" message:@"将该题重新加入错题集，退出当前模式后将生效" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:cancel];
        
        UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [_removedDic setValue:@"0" forKey:key];
            
            [FMDBUtil setQuestionFlag:_type quesionID:quesion.question_id isWrong:YES];
            [ToastView showBlackSuccessWithStaus:@"取消成功"];
            [_removeBtn setImage:[UIImage imageNamed:@"question_remove"] forState:UIControlStateNormal];
            [_removeBtn setImage:[UIImage imageNamed:@"question_remove"] forState:UIControlStateHighlighted];
        }];
        [alert addAction:confirm];
        
        [self presentViewController:alert animated:YES completion:nil];
    }else{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"是否从错题集中删除" message:@"退出后重新进入错题集将生效" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:cancel];
        
        UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [_removedDic setValue:@"1" forKey:key];
            
            [FMDBUtil setQuestionFlag:_type quesionID:quesion.question_id isWrong:NO];
            [ToastView showBlackSuccessWithStaus:@"删除成功"];
            [_removeBtn setImage:[UIImage imageNamed:@"question_removed"] forState:UIControlStateNormal];
            [_removeBtn setImage:[UIImage imageNamed:@"question_removed"] forState:UIControlStateHighlighted];
        }];
        [alert addAction:confirm];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
}

- (void)showAnswer{
    ExerciseQuestion *question = [_questions objectAtIndex:_index];
    NSString *str = [NSString stringWithFormat:@"正确答案为%@",question.answer];
    [ToastView showStatus:str];
}

#pragma mark - 自定义界面返回事件
- (void)popFromCurrentViewController{
    if([_judgedDic count] == [_questions count] || _mode == ExerciseModeMistakes){
        [super popFromCurrentViewController];
    }else{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"是否确认退出" message:@"当前练习未完成\ntips:已做错的题会保存在错题集" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:cancel];
        
        UIAlertAction *back = [UIAlertAction actionWithTitle:@"离开" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [super popFromCurrentViewController];
        }];
        [alert addAction:back];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
}

@end
