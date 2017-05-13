//
//  CourseIntroductionController.m
//  xbsz
//
//  Created by 陈鑫 on 17/3/17.
//  Copyright © 2017年 lotus. All rights reserved.
//

#import "CourseIntroductionViewController.h"
#import "CWStarRateView.h"
#import "UINavigationController+TZPopGesture.h"

static int titleHeight = 40;
static int avatarWidth = 40;

@interface CourseIntroductionViewController () <UIScrollViewDelegate>


@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIView *infoView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) CWStarRateView *rateView;
@property (nonatomic, strong) UILabel *scoreLabel;
@property (nonatomic, strong) UILabel *numberLabel;     //共有多少人学习过

@property (nonatomic, strong) UIView *briefView;            //课程简介
@property (nonatomic, strong) UILabel *briefTitleLabel;
@property (nonatomic, strong) UILabel *briefLabel;

@property (nonatomic, strong) UIView *noticeView;          //适用人群
@property (nonatomic, strong) UILabel *noticeTitleLabel;
@property (nonatomic, strong) UILabel *noticeLabel;


@property (nonatomic, strong) UIView *peopleView;          //适用人群
@property (nonatomic, strong) UILabel *peopleTitleLabel;
@property (nonatomic, strong) UILabel *peopleLabel;


@property (nonatomic, strong) UIView *teacherView;          //教师信息View
@property (nonatomic, strong) UILabel *teacherTitleLabel;
@property (nonatomic, strong) YYAnimatedImageView *avatarImageView;       //教师头像
@property (nonatomic, strong) UILabel *nameLable;           //教师名称
@property (nonatomic, strong) UILabel *teacherBriefLabel;        //教师个人简介


@end

@implementation CourseIntroductionViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.view.backgroundColor = CXWhiteColor;
    
    [self.view addSubview:self.scrollView];
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view);
    }];
    //添加课程名称 评分 参与人数
    [_scrollView addSubview:self.infoView];
    [_infoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_scrollView.mas_top);
        make.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(80);
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_infoView.mas_top);
        make.height.mas_equalTo(50);
        make.right.mas_equalTo(_scrollView);
        make.left.mas_equalTo(_scrollView.mas_left).mas_offset(15);
    }];
    
//    添加课程简介
    [_scrollView addSubview:self.briefView];
    [_briefView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(_infoView.mas_bottom).mas_offset(10);
    }];
    
    [_briefTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).mas_offset(15);
        make.right.mas_equalTo(self.view.mas_right).mas_offset(-15);
        make.height.mas_equalTo(titleHeight);
        make.top.mas_equalTo(_briefView.mas_top);
    }];

    [_briefLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(15);
        make.right.mas_equalTo(self.view).mas_offset(-15);
        make.top.mas_equalTo(_briefTitleLabel.mas_bottom);
        make.bottom.mas_equalTo(_briefView.mas_bottom).mas_offset(-10);
    }];
    
    UIView *lineView1 = [[UIView alloc] init];
    lineView1.backgroundColor = CXLineColor;
    [_scrollView addSubview:lineView1];
    [lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_briefView.mas_bottom);
        make.height.mas_equalTo(1/CXMainScale);
        make.left.mas_equalTo(self.view).mas_offset(15);
        make.right.mas_equalTo(self.view).mas_offset(-15);
    }];
    
    
    //添加最新通告
    [_scrollView addSubview:self.noticeView];
    [_noticeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(lineView1.mas_bottom);
    }];
    
    [_noticeTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).mas_offset(15);
        make.right.mas_equalTo(self.view.mas_right).mas_offset(-15);
        make.height.mas_equalTo(titleHeight);
        make.top.mas_equalTo(_briefView.mas_bottom);
    }];
    
    [_noticeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(15);
        make.right.mas_equalTo(self.view).mas_offset(-15);
        make.top.mas_equalTo(_noticeTitleLabel.mas_bottom);
        make.bottom.mas_equalTo(_noticeView.mas_bottom).mas_offset(-10);
    }];

    
    UIView *lineView2 = [[UIView alloc] init];
    lineView2.backgroundColor = CXLineColor;
    [_scrollView addSubview:lineView2];
    [lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_noticeView.mas_bottom);
        make.height.mas_equalTo(1/CXMainScale);
        make.left.mas_equalTo(self.view).mas_offset(15);
        make.right.mas_equalTo(self.view).mas_offset(-15);
    }];
    

    //添加适用人群
    [_scrollView addSubview:self.peopleView];
    [_peopleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(lineView2.mas_bottom);
    }];
    
    [_peopleTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).mas_offset(15);
        make.right.mas_equalTo(self.view.mas_right).mas_offset(-15);
        make.height.mas_equalTo(titleHeight);
        make.top.mas_equalTo(_noticeView.mas_bottom);
    }];
    
    [_peopleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(15);
        make.right.mas_equalTo(self.view).mas_offset(-15);
        make.top.mas_equalTo(_peopleTitleLabel.mas_bottom);
        make.bottom.mas_equalTo(_peopleView.mas_bottom).mas_offset(-10);
    }];

    UIView *lineView3 = [[UIView alloc] init];
    lineView3.backgroundColor = CXLineColor;
    [_scrollView addSubview:lineView3];
    [lineView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_peopleView.mas_bottom);
        make.height.mas_equalTo(1/CXMainScale);
        make.left.mas_equalTo(self.view).mas_offset(15);
        make.right.mas_equalTo(self.view).mas_offset(-15);
    }];
    
    //添加教师个人简介
    [_scrollView addSubview:self.teacherView];
    [_teacherView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(lineView3.mas_bottom);
        make.bottom.mas_equalTo(_scrollView.mas_bottom);
    }];
    
    [_teacherTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).mas_offset(15);
        make.right.mas_equalTo(self.view.mas_right).mas_offset(-15);
        make.height.mas_equalTo(titleHeight+10);
        make.top.mas_equalTo(_peopleView.mas_bottom);
    }];
    
    [_avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(avatarWidth);
        make.left.mas_equalTo(self.view).mas_offset(15);
        make.top.mas_equalTo(_teacherTitleLabel.mas_bottom);
    }];
    
    [_nameLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_avatarImageView.mas_right).mas_offset(10);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(30);
        make.top.mas_equalTo(_teacherTitleLabel.mas_bottom);
    }];
    
    [_teacherBriefLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_avatarImageView.mas_right).mas_offset(10);
        make.right.mas_equalTo(self.view.mas_right).mas_offset(-15);
        make.top.mas_equalTo(_nameLable.mas_bottom);
        make.bottom.mas_equalTo(_scrollView.mas_bottom).mas_offset(-40);
    }];
    
     [self tz_addPopGestureToView:_scrollView];
}


- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

#pragma mark - getter/setter

- (UIScrollView *)scrollView{
    if(!_scrollView){
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.backgroundColor = CXBackGroundColor;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = YES;
        _scrollView.alwaysBounceHorizontal = NO;
        _scrollView.alwaysBounceVertical = YES;
        _scrollView.delegate = self;
//        _scrollView.contentSize = CGSizeMake(CXScreenWidth, self.view.frame.size.height+300);
    }
    return _scrollView;
}

- (UIView *)infoView{
    if(!_infoView){
        _infoView = [[UIView alloc] init];
        _infoView.backgroundColor = CXWhiteColor;
        [_infoView addSubview:self.titleLabel];
        [_infoView addSubview:self.rateView];
        [_infoView addSubview:self.scoreLabel];
        [_infoView addSubview:self.numberLabel];
    }
    return _infoView;
}

- (UILabel *)titleLabel{
    if(!_titleLabel){
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = CXSystemFont(20);
        _titleLabel.textColor = CXHexAlphaColor(0x000000, 0.8);
        _titleLabel.text = _course.title;
        _titleLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _titleLabel;
}

- (CWStarRateView *)rateView{
    if(!_rateView){
        _rateView = [[CWStarRateView alloc] initWithFrame:CGRectMake(15, 50, 100, 15) numberOfStars:5];
        _rateView.scorePercent = _course.rate/5;
        _rateView.allowIncompleteStar = YES;
        _rateView.allowRate = NO;
        _rateView.hasAnimation = NO;                             //不允许打分
    }
    return _rateView;
}

- (UILabel *)scoreLabel{
    if(!_scoreLabel){
        _scoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(120, 50, 30, 15)];
        _scoreLabel.font = CXSystemFont(11);
        _scoreLabel.textAlignment = NSTextAlignmentLeft;
        _scoreLabel.textColor = CXLightGrayColor;
        _scoreLabel.text = [NSString stringWithFormat:@"%.1f分",_course.rate];
    }
    return _scoreLabel;
}

- (UILabel *)numberLabel{
    if(!_numberLabel){
        _numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(165, 50, 80, 15)];
        _numberLabel.text = [NSString stringWithFormat:@"共%ld人参与",_course.total];
        _numberLabel.textAlignment = NSTextAlignmentLeft;
        _numberLabel.textColor = CXLightGrayColor;
        _numberLabel.font = CXSystemFont(11);
    }
    return _numberLabel;
}

- (UIView *)briefView{
    if(!_briefView){
        _briefView = [[UIView alloc] init];
        _briefView.backgroundColor = CXWhiteColor;
        
        _briefTitleLabel = [[UILabel alloc] init];
        _briefTitleLabel.text = @"课程简介";
        _briefTitleLabel.font = CXSystemFont(16);
        _briefTitleLabel.textColor =  CXHexAlphaColor(0x000000, 0.8);;
        _briefTitleLabel.textAlignment = NSTextAlignmentLeft;
        [_briefView addSubview:_briefTitleLabel];
        [_briefView addSubview:self.briefLabel];

    }
    return _briefView;
}

- (UILabel *)briefLabel{
    if(!_briefLabel){
        _briefLabel = [[UILabel alloc] init];
        _briefLabel.textColor = CXLightGrayColor;
        _briefLabel.font = CXSystemFont(14);
        _briefLabel.numberOfLines = 0;
        // 调整行间距
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:_course.brief];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:3];
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [_course.brief length])];
        _briefLabel.attributedText = attributedString;
        
        [_briefLabel sizeToFit];
    }
    return _briefLabel;
}


- (UIView *)noticeView{
    if(!_noticeView){
        _noticeView = [[UIView alloc] init];
        _noticeView.backgroundColor = CXWhiteColor;
        
        _noticeTitleLabel = [[UILabel alloc] init];
        _noticeTitleLabel.text = @"最新通告";
        _noticeTitleLabel.font = CXSystemFont(16);
        _noticeTitleLabel.textColor =  CXRedColor;
        _noticeTitleLabel.textAlignment = NSTextAlignmentLeft;
        [_noticeView addSubview:_noticeTitleLabel];
        [_noticeView addSubview:self.noticeLabel];
    }
    return _noticeView;
}

- (UILabel *)noticeLabel{
    if(!_noticeLabel){
        _noticeLabel = [[UILabel alloc] init];
        _noticeLabel.font = CXSystemFont(14);
        _noticeLabel.textColor = CXLightGrayColor;
        _noticeLabel.numberOfLines = 0;
        // 调整行间距
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@"下周课程将在140机房"];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:3];
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [_course.suit length])];
        _noticeLabel.attributedText = attributedString;
        
        [_noticeLabel sizeToFit];
    }
    return _noticeLabel;
}

- (UIView *)peopleView{
    if(!_peopleView){
        _peopleView = [[UIView alloc] init];
        _peopleView.backgroundColor = CXWhiteColor;
        
        _peopleTitleLabel = [[UILabel alloc] init];
        _peopleTitleLabel.text = @"面向专业";
        _peopleTitleLabel.font = CXSystemFont(16);
        _peopleTitleLabel.textColor =  CXHexAlphaColor(0x000000, 0.8);;
        _peopleTitleLabel.textAlignment = NSTextAlignmentLeft;
        [_peopleView addSubview:_peopleTitleLabel];
        [_peopleView addSubview:self.peopleLabel];
    }
    return _peopleView;
}

- (UILabel *)peopleLabel{
    if(!_peopleLabel){
        _peopleLabel = [[UILabel alloc] init];
        _peopleLabel.font = CXSystemFont(14);
        _peopleLabel.textColor = CXLightGrayColor;
        _peopleLabel.numberOfLines = 0;
        // 调整行间距
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:_course.suit];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:3];
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [_course.suit length])];
        _peopleLabel.attributedText = attributedString;

        [_peopleLabel sizeToFit];
    }
    return _peopleLabel;
}

- (UIView *)teacherView{
    if(!_teacherView){
        _teacherView = [[UIView alloc] init];
        _teacherView.backgroundColor = CXWhiteColor;
        
        [_teacherView addSubview:self.teacherTitleLabel];
        [_teacherView addSubview:self.avatarImageView];
        [_teacherView addSubview:self.nameLable];
        [_teacherView addSubview:self.teacherBriefLabel];
    }
    return _teacherView;
}

- (UILabel *)teacherTitleLabel{
    if(!_teacherTitleLabel){
        _teacherTitleLabel = [[UILabel alloc] init];
        _teacherTitleLabel.text = @"教师";
        _teacherTitleLabel.font = CXSystemFont(16);
        _teacherTitleLabel.textColor =  CXHexAlphaColor(0x000000, 0.8);;
        _teacherTitleLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _teacherTitleLabel;
}

- (YYAnimatedImageView *)avatarImageView{
    if(!_avatarImageView){
        _avatarImageView = [[YYAnimatedImageView alloc] init];
        _avatarImageView.yy_imageURL = [NSURL URLWithString:[NSString getAvatarUrl:_course.teacher.avatar]];
        _avatarImageView.layer.cornerRadius = avatarWidth/2;
        _avatarImageView.clipsToBounds = YES;
    }
    return _avatarImageView;
}

- (UILabel *)nameLable{
    if(!_nameLable){
        _nameLable = [[UILabel alloc] init];
        _nameLable.font = CXSystemFont(15);
        _nameLable.textColor = CXBlackColor;
        _nameLable.textAlignment = NSTextAlignmentLeft;
        _nameLable.text = [NSString stringWithFormat:@"%@",_course.teacher.truename];
    }
    return _nameLable;
}

- (UILabel *)teacherBriefLabel{
    if(!_teacherBriefLabel){
        _teacherBriefLabel = [[UILabel alloc] init];
        _teacherBriefLabel.font = CXSystemFont(14);
        _teacherBriefLabel.textColor = CXLightGrayColor;
        _teacherBriefLabel.numberOfLines = 0;
        // 调整行间距
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:_course.teacher.brief];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:3];
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [_course.teacher.brief length])];
        _teacherBriefLabel.attributedText = attributedString;
        
        [_teacherBriefLabel sizeToFit];
    }
    return _teacherBriefLabel;
}

#pragma  mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if([_baseDelegate respondsToSelector:@selector(scrollViewDidScroll:)]){
        [_baseDelegate scrollViewDidScroll:scrollView];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    if([_baseDelegate respondsToSelector:@selector(scrollViewWillBeginDragging:)]){
        [_baseDelegate scrollViewWillBeginDragging:scrollView];
    }
}

@end
