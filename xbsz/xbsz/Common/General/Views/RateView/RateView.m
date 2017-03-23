//
//  RateView.m
//  xbsz
//
//  Created by 陈鑫 on 17/3/17.
//  Copyright © 2017年 lotus. All rights reserved.
//

#import "RateView.h"
#import "CWStarRateView.h"
#import "ToastView.h"

static RateView *sharedObj;

@interface RateView () <CWStarRateViewDelegate>

@property (nonatomic, strong) CWStarRateView *startRateView;

@property (nonatomic, strong) UILabel *descriptionLabel;

@property (nonatomic, strong) UITextView *commentTextView;

@property (nonatomic, strong) UILabel *submitLabel;

@end


@implementation RateView

+ (instancetype)instance{
    @synchronized (self){
        if (sharedObj == nil){
            if (sharedObj == nil)
                sharedObj = [[RateView alloc] initWithFrame:CGRectZero];
        }
    }
    return sharedObj;
}

- (instancetype)init{
    return [self initWithFrame:CGRectZero];
}

- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:CGRectZero]){
        [self initRateView];
    }
    return self;
}


- (void)initRateView{
    CGFloat width = CXScreenWidth*0.7;
    CGFloat height = width*0.8;
    self.frame = CGRectMake( 0, 0, width , height);
    self.backgroundColor = CXWhiteColor;
    self.layer.cornerRadius = 8;
    self.clipsToBounds = YES;
    
    [self addSubview:self.startRateView];
    [self addSubview:self.descriptionLabel];
    [_descriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_startRateView.mas_bottom).mas_offset(4);
        make.left.right.mas_equalTo(self);
        make.height.mas_equalTo(30);
    }];
    
    [self addSubview:self.commentTextView];
    [_commentTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self);
        make.height.mas_equalTo(height*0.5);
        make.top.mas_equalTo(self.mas_top).mas_offset(height*0.3);
    }];
    
    [self addSubview:self.submitLabel];
    [_submitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.mas_bottom);
        make.left.right.mas_equalTo(self);
        make.height.mas_equalTo(height*0.2);
    }];
}

#pragma mark - getter/setter
- (CWStarRateView *)startRateView{
    if(!_startRateView){
        CGFloat width = CXScreenWidth*0.7*0.7;
        CGFloat margin = (CXScreenWidth*0.7 - width)/2;
        
        _startRateView = [[CWStarRateView alloc] initWithFrame:CGRectMake(margin , 20, width, 18) numberOfStars:5];
        _startRateView.backgroundColor = CXWhiteColor;
        _startRateView.scorePercent = 0.0;
        _startRateView.allowIncompleteStar = YES;
        _startRateView.allowRate = YES;
        _startRateView.hasAnimation = NO;
        _startRateView.delegate = self;
    }
    return _startRateView;
}

- (UILabel *)descriptionLabel{
    if(!_descriptionLabel){
        _descriptionLabel = [[UILabel alloc] init];
        _descriptionLabel.textColor = CXHexAlphaColor(0x000000, 0.8);
        _descriptionLabel.textAlignment = NSTextAlignmentCenter;
        _descriptionLabel.font = CXSystemFont(11);
        _descriptionLabel.text = @"良好";
        _descriptionLabel.hidden = YES;
    }
    return _descriptionLabel;
}

- (UITextView *)commentTextView{
    if(!_commentTextView){
        _commentTextView = [[UITextView alloc] init];
        _commentTextView.backgroundColor = CXBackGroundColor;
    }
    return _commentTextView;
}

- (UILabel *)submitLabel{
    if(!_submitLabel){
        _submitLabel = [[UILabel alloc] init];
        _submitLabel.text = @"提交";
        _submitLabel.textAlignment = NSTextAlignmentCenter;
        _submitLabel.font = CXSystemFont(14);
        _submitLabel.textColor = CXHexColor(0x43CD80);
        _submitLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(submit)];
        [_submitLabel addGestureRecognizer:tap];
    }
    return _submitLabel;
}

- (void)submit{
    
    if(_startRateView.scorePercent == 0.0){
        [ToastView showErrorWithStaus:@"您还没评分哦😯"];
        return ;
    }
    
    if(_delegate && [_delegate respondsToSelector:@selector(rateView:contnet:)]){
        [_delegate rateView:_startRateView.scorePercent contnet:_commentTextView.text];
    }
    
}

#pragma mark - public method

- (void)showInView:(UIView *)view{
    //展现时将之前的状态清楚掉
    _descriptionLabel.hidden = YES;
    CGFloat width = CXScreenWidth*0.7;
    CGFloat height = width*0.8;
    [_commentTextView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(height*0.5);
        make.top.mas_equalTo(self.mas_top).mas_offset(height*0.3);
    }];
    _startRateView.scorePercent = 0.0;
    _commentTextView.text = @"";
    
    
    UIView *backView = [[UIView alloc] initWithFrame:view.frame];
    backView.userInteractionEnabled = YES;
    backView.tag = 101;
    backView.backgroundColor = CXBlackColor;
    backView.alpha = 0;
    @weakify(self);
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
        [weak_self dismissInView:view];
    }];
    [backView addGestureRecognizer:tap];
    [view addSubview:backView];
    RateView *rateView = [RateView instance];
    rateView.center = CGPointMake(CXScreenWidth/2, CXScreenHeight+CGRectGetHeight(rateView.frame)/2);
    [view addSubview:rateView];
    
    
    [UIView animateWithDuration:0.4 animations:^{
        backView.alpha = 0.2;
        CGPoint windowCenter = CGPointMake(CXScreenWidth/2, CXScreenHeight/2);
        rateView.center = windowCenter;
    }];
}


- (void)dismissInView:(UIView *)view{
    UIView *backView = nil;
    RateView * rateView= nil;
    for (UIView *v in view.subviews) {
        if ([v class] == [self class]){
            rateView = (RateView *)v;
        }
        if(v.tag == 101){
            backView = v;
        }
    }
    
    [UIView animateWithDuration:0.4 animations:^{
        backView.alpha = 0.0;
        rateView.center = CGPointMake(CXScreenWidth/2, CXScreenHeight+CGRectGetHeight(rateView.frame)/2);
    } completion:^(BOOL finished) {
        [backView removeFromSuperview];
        [rateView removeFromSuperview];
    }];
    
}

- (void)starRateView:(CWStarRateView *)starRateView scroePercentDidChange:(CGFloat)newScorePercent{
    if(newScorePercent == 0.0)  return;         //评分为0.0则不进入点击事件
    _descriptionLabel.hidden = NO;
    CGFloat width = CXScreenWidth*0.7;
    CGFloat height = width*0.8;
    [_commentTextView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(height*0.45);
        make.top.mas_equalTo(self.mas_top).mas_offset(height*0.35);
    }];
    if(newScorePercent == 0.1 || newScorePercent == 0.2){
        _descriptionLabel.text = @"较差";
    }else if(newScorePercent == 0.3 || newScorePercent == 0.4){
        _descriptionLabel.text = @"一般";
    }else if(newScorePercent == 0.5 || newScorePercent == 0.6){
        _descriptionLabel.text = @"良好";
    }else if(newScorePercent == 0.7 || newScorePercent == 0.8){
        _descriptionLabel.text = @"推荐";
    }else if(newScorePercent == 0.9 || newScorePercent == 1.0){
        _descriptionLabel.text = @"极佳";
    }else{
        _descriptionLabel.text = @"请评分";
    }
}

@end
