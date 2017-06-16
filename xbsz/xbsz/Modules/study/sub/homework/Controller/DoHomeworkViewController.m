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
#import "StudyUtil.h"
#import "FMDBUtil.h"
#import "ExerciseProgressViewController.h"
#import "IQKeyboardManager.h"
#import "CXNetwork+Course.h"

static NSString *cellID = @"CourseQuestionCellID";
static NSString *blankCellID = @"BlankQuestionCellID";
static NSInteger bottomHeight = 45;

@interface DoHomeworkViewController () <UICollectionViewDelegate,UICollectionViewDataSource,CourseQuestionOptionDelegate,BlankTextViewDelegate>

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

@property (nonatomic, strong) NSMutableDictionary *practicedDic;
@property (nonatomic, strong) NSMutableDictionary *judgedDic;

@end

@implementation DoHomeworkViewController

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [IQKeyboardManager sharedManager].enable = YES;
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
}

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
    _practicedDic = [[NSMutableDictionary alloc] init];
    _judgedDic = [[NSMutableDictionary alloc] init];
    _index = 0;         //初始化cell索引为0
    
    _hasRightAnswer = YES;
    _hasPracticed = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadData{
    [ToastView showProgressBar:@"获取题目中..."];

    [CXNetwork getHomeworkQuestions:_homework.exerciseID success:^(NSObject *obj) {
        _questionList = [CourseQuestionList yy_modelWithDictionary:(NSDictionary *)obj];
        
        [ToastView showStatus:@"获取成功" delay:1];
        _questions = _questionList.questions;
        
        _index = 0;
        [self updatePreAndNextLabel:_index];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [_collectionView reloadData];
        });
        
    } failure:^(NSError *error) {
        [ToastView showStatus:@"获取失败" delay:1];
    }];
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
        [_collectionView registerClass:[BlankCollectionViewCell class] forCellWithReuseIdentifier:blankCellID];
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
    CourseQuestion *question = [_questions objectAtIndex:indexPath.row];
    NSString *key = [NSString stringWithFormat:@"%ld",indexPath.row];

    
    //如果是填空题/简答题
    QuestionType type = [StudyUtil getQuestionTypeByString:question.type];
    if(type == QuestionTypeBlank){
        BlankCollectionViewCell *cell = (BlankCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:blankCellID forIndexPath:indexPath];
        cell.baseDelegate = self;
        if([_judgedDic count] != 0){
            [cell updateUIByQuestion:question allowEdit:NO];
        }else{
            [cell updateUIByQuestion:question allowEdit:YES];
        }
        
        //从已做过的记录中回复做题记录
        if([_judgedDic count] != 0){
            NSString *text = [_practicedDic valueForKey:key];
            if(text == nil)       text = @"";
            [cell showPracticeAnswer:text];
        }else{
            NSString *text = [_practicedDic valueForKey:key];
            if(text == nil)       text = @"";
            [cell showTemporaryText:text];
        }
        
        
        return cell;
    }
    
    
    CourseQuestionCollectionViewCell *cell = (CourseQuestionCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    cell.baseDelegate = self;
    
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

#pragma mark - 内部点击事件 回调等

- (void)selectOption:(NSInteger)selectedIndex{
    NSString *key = [NSString stringWithFormat:@"%ld",_index];
    NSString *newValue = [NSString stringWithFormat:@"%ld",selectedIndex];
    
    if([_judgedDic containsObjectForKey:key])  return;

    CourseQuestion *question = [_questions objectAtIndex:_index];
    QuestionType type = [StudyUtil getQuestionTypeByString:question.type];
    if(type == QuestionTypeSingle || type == QuestionTypeJudge){
        [_practicedDic setValue:newValue forKey:key];
    }else if(type == QuestionTypeMuti){
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
    }else if(type == QuestionTypeBlank){
        
    }
    
    NSIndexPath *path = [NSIndexPath indexPathForRow:_index inSection:0];
    CourseQuestionCollectionViewCell *cell = (CourseQuestionCollectionViewCell *)[_collectionView cellForItemAtIndexPath:path];
    [cell setTemporarySelected:[_practicedDic objectForKey:key]];
    if(type == QuestionTypeJudge || type == QuestionTypeSingle)       [self performSelector:@selector(next) withObject:nil afterDelay:0.5];
    
}

- (void)blankTextEntered:(NSString *)text{
    NSString *key = [NSString stringWithFormat:@"%ld",_index];
    
    if([_judgedDic containsObjectForKey:key])  return;
    
    [_practicedDic setValue:text forKey:key];
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
    if(_index == 0){
        _preLabel.text = @"无";
        _nextLabel.text = @"下一题";
    }else if(_index == [_questions count] -1){
        _preLabel.text = @"上一题";
        if(_hasRightAnswer){
            if([_judgedDic count] == 0)     _nextLabel.text = @"提交练习";
            else    _nextLabel.text = @"退出";
        }else{
            _nextLabel.text = @"提交练习";
        }
    }else{
        _preLabel.text = @"上一题";
        _nextLabel.text = @"下一题";
    }
    self.title = [NSString stringWithFormat:@"%ld/%ld",index+1,[_questions count]];
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

- (void)submitExam{
    if([_judgedDic count] == [_questions count]){
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"是否确认退出" message:@"您已完成练习" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:cancel];
        
        UIAlertAction *back = [UIAlertAction actionWithTitle:@"离开" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [super popFromCurrentViewController];
        }];
        [alert addAction:back];
        
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    
    NSString *title = @"";
    NSString *message = @"";
    
    if(_hasRightAnswer == YES){
        title = @"是否提交?";
        message = @"提交后显示参考答案，数据不发送到后台";
    }else{
        if(_hasPracticed == YES){
            title = @"您已做过该练习，是否提交?";
            message = @"这将覆盖之前的练习结果";
        }else{
            title = @"是否提交?";
            message = @"做题数据将发送到服务器后台";
        }
    }
    
    
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:cancel];
    
    UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //数据将发送到后台
        if(_hasRightAnswer == NO){
            [ToastView showStatus:@"做题结果已上传"];
            return ;
        }
        
        //数据不发送到后台  立即显示做题结果
        for(NSInteger i = 0;i<[_questions count];i++){
            CourseQuestion *question = [_questions objectAtIndex:i];
            NSString *key = [NSString stringWithFormat:@"%ld",i];
            if([_practicedDic containsObjectForKey:key]){
                NSString *val = [_practicedDic valueForKey:key];
                BOOL isRight = NO;
                QuestionType type = [StudyUtil getQuestionTypeByString:question.type];
                if(type == QuestionTypeSingle || type == QuestionTypeJudge){
                    isRight = [FMDBUtil isMutiRightAnswer:val answer:question.answer];
                }else if(type == QuestionTypeMuti){
                    isRight = [FMDBUtil isSingleRightAnswer:[val integerValue] answer:question.answer];
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
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"是否确认退出" message:@"当前练习未提交" preferredStyle:UIAlertControllerStyleAlert];
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
