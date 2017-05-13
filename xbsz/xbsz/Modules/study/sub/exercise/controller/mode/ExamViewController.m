//
//  ExamViewController.m
//  xbsz
//
//  Created by lotus on 2017/4/29.
//  Copyright © 2017年 lotus. All rights reserved.
//

#import "ExamViewController.h"
#import "QuestionCollectionViewCell.h"
#import "ExerciseProgressViewController.h"
#import "StudyUtil.h"

static NSString *cellID = @"ExerciseExamQuestionCellID";
static NSInteger bottomHeight = 45;

@interface ExamViewController () <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,QuestionOptionDelegate>

@property (nonatomic, strong) UIButton *gotoBtn;
@property (nonatomic, strong) UIButton *submitBtn;


@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) UIButton *preBtn;
@property (nonatomic, strong) UILabel *preLabel;

@property (nonatomic, strong) UIButton *nextBtn;
@property (nonatomic, strong) UILabel *nextLabel;


@property (nonatomic, copy) NSArray *questions;         //题目集合

@property (nonatomic, assign) NSInteger index;          //cell索引

@property (nonatomic, strong) NSMutableDictionary *practicedDic;

@property (nonatomic, strong) NSMutableDictionary *judgedDic;

@end

@implementation ExamViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self.customNavBarView addSubview:self.gotoBtn];
    [self.customNavBarView addSubview:self.submitBtn];
    self.customNavBarView.backgroundColor  = CXBackGroundColor;
    
    
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
    _practicedDic = [[NSMutableDictionary alloc] init];
    _judgedDic = [[NSMutableDictionary alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//加载题库数据
- (void)loadData{
    _questions = [StudyUtil getExamQuestionsByType:_type];
    [_collectionView reloadData];
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
        _collectionView.backgroundColor = CXWhiteColor;
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
    if([_judgedDic count] != 0){
        [cell updateUIByQuestion:question allowSelect:NO];
    }else{
        [cell updateUIByQuestion:question allowSelect:YES];
    }
    //从已做过的记录中回复做题记录
    if([_judgedDic count] != 0){
        NSString *selectedIndexs = [_practicedDic valueForKey:key];
        if(selectedIndexs == nil)       selectedIndexs = @"";
        [cell showMutiPracticeAnswer:selectedIndexs];
    }else{
        NSString *selectedIndexs = [_practicedDic valueForKey:key];
        if(selectedIndexs == nil)       selectedIndexs = @"";
        [cell setTemporarySelected:selectedIndexs];
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

- (void)selectOption:(NSInteger)selectedIndex{
    NSString *key = [NSString stringWithFormat:@"%ld",_index];
    NSString *newValue = [NSString stringWithFormat:@"%ld",selectedIndex];
    
    if([_judgedDic containsObjectForKey:key])  return;
    
    if(_index <= 59){
          [_practicedDic setValue:newValue forKey:key];
    }else{
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
    }
    
    NSIndexPath *path = [NSIndexPath indexPathForRow:_index inSection:0];
    QuestionCollectionViewCell *cell = (QuestionCollectionViewCell *)[_collectionView cellForItemAtIndexPath:path];
    [cell setTemporarySelected:[_practicedDic objectForKey:key]];
    if(_index <= 59)       [self performSelector:@selector(next) withObject:nil afterDelay:0.5];

}


- (void)questionGoto{
    ExerciseProgressViewController *progressVC = [ExerciseProgressViewController controller];
    if([_judgedDic count] == [_questions count]){
        ExerciseProgressViewController *progressVC = [ExerciseProgressViewController controller];
        [progressVC updateData:ExerciseModePractice total:[_questions count] practicedDic:_practicedDic judgedDic:_judgedDic currentIndex:_index clicked:^(NSInteger index) {
            if(index >= 0){
                _index = index;
                NSIndexPath *path = [NSIndexPath indexPathForRow:index inSection:0];
                [_collectionView scrollToItemAtIndexPath:path atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
                [self updatePreAndNextLabel:index];
            }
        }];
        [self presentViewController:progressVC animated:YES completion:nil];
    }else{
        [progressVC updateData:ExerciseModeExam total:[_questions count] practicedDic:_practicedDic judgedDic:nil currentIndex:_index clicked:^(NSInteger index) {
            if(index >= 0){
                _index = index;
                NSIndexPath *path = [NSIndexPath indexPathForRow:index inSection:0];
                [_collectionView scrollToItemAtIndexPath:path atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
                [self updatePreAndNextLabel:index];
            }
        }];
        [self presentViewController:progressVC animated:YES completion:nil];
    }

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
    if(_index == 0){
        _preLabel.text = @"无";
        _nextLabel.text = @"下一题";
    }else if(_index == [_questions count] -1){
        _preLabel.text = @"上一题";
        if([_judgedDic count] == 0) _nextLabel.text = @"提交试卷";
        else    _nextLabel.text = @"退出";
    }else{
        _preLabel.text = @"上一题";
        _nextLabel.text = @"下一题";
    }
    self.title = [NSString stringWithFormat:@"%ld/%ld",index+1,[_questions count]];
}

- (void)submitExam{
    
    if([_judgedDic count] == [_questions count]){
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"是否确认退出" message:@"您已提交过试卷" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:cancel];
        
        UIAlertAction *back = [UIAlertAction actionWithTitle:@"离开" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [super popFromCurrentViewController];
        }];
        [alert addAction:back];
        
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    
    NSString *message = @"";
    if([_practicedDic count] != 80){
        message = @"有题目未完成,请确认是否提交";
    }else{
        message = @"您已完成全部试题";
    }
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"是否提交" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:cancel];
    
    UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        for(NSInteger i = 0;i<[_questions count];i++){
            ExerciseQuestion *question = [_questions objectAtIndex:i];
            NSString *key = [NSString stringWithFormat:@"%ld",i];
            if([_practicedDic containsObjectForKey:key]){
                NSString *val = [_practicedDic valueForKey:key];
                BOOL isRight = NO;
                if(question.type == 2){
                    isRight = [StudyUtil isMutiRightAnswer:val answer:question.answer];
                }else{
                    isRight = [StudyUtil isSingleRightAnswer:[val integerValue] answer:question.answer];
                }
                if(isRight){
                    [_judgedDic setValue:@"1" forKey:key];
                }else{
                    [_judgedDic setValue:@"-1" forKey:key];
                }
            }else{
                [_judgedDic setValue:@"-1" forKey:key];
            }
        }
        
        
        ExerciseProgressViewController *progressVC = [ExerciseProgressViewController controller];
        [progressVC updateData:ExerciseModePractice total:[_questions count] practicedDic:_practicedDic judgedDic:_judgedDic currentIndex:_index clicked:^(NSInteger index) {
            if(index >= 0){
                _index = index;
                NSIndexPath *path = [NSIndexPath indexPathForRow:index inSection:0];
                [_collectionView scrollToItemAtIndexPath:path atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
                [self updatePreAndNextLabel:index];
                [_collectionView reloadData];
            }
        }];
        [self presentViewController:progressVC animated:YES completion:nil];
        
        
    }];
    [alert addAction:confirm];
    [self presentViewController:alert animated:YES completion:nil];
}


#pragma mark - 自定义界面返回事件
- (void)popFromCurrentViewController{
    if([_judgedDic count] == [_questions count]){
        [super popFromCurrentViewController];
    }else{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"是否确认退出" message:@"当前试卷未提交" preferredStyle:UIAlertControllerStyleAlert];
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
