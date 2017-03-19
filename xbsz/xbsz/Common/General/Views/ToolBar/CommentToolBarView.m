//
//  ToolBarView.m
//  xbsz
//
//  Created by 陈鑫 on 17/2/21.
//  Copyright © 2017年 lotus. All rights reserved.
//

#import "CommentToolBarView.h"


@interface CommentToolBarView ()

@property (nonatomic, strong) UIButton *likeBtn;
@property (nonatomic, strong) UIButton *replyBtn;
@property (nonatomic, strong) UIButton *shareBtn;
@property (nonatomic, strong) UIButton *moreBtn;
@property (nonatomic, copy)   ToolBarActionBlock actionBlock;

@property (nonatomic, assign) BOOL status;      //点赞按钮可点击状态

@end

@implementation CommentToolBarView

- (instancetype)init{
    self = [super init];
    if(self){
        [self initToolBarView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self initToolBarView];
    }
    return self;

}

- (void)initToolBarView{
    
    [self addSubview:self.likeBtn];
    [self addSubview:self.replyBtn];
    [self addSubview:self.shareBtn];
    [self addSubview:self.moreBtn];
    
    [_likeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(32);
        make.left.mas_equalTo(self.mas_left).mas_offset(6);
        make.centerY.mas_equalTo(self.mas_centerY);
    }];
    
    [_replyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(32);
        make.left.mas_equalTo(_likeBtn.mas_right).mas_offset(6);
        make.centerY.mas_equalTo(self.mas_centerY);
    }];
    
    [_shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(32);
        make.left.mas_equalTo(_replyBtn.mas_right).mas_offset(6);
        make.centerY.mas_equalTo(self.mas_centerY);
    }];
    
    [_moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(32);
        make.right.mas_equalTo(self.mas_right).mas_offset(-4);
        make.centerY.mas_equalTo(self.mas_centerY);
    }];

}

- (UIButton *)likeBtn{
    if(!_likeBtn){
        _likeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_likeBtn setImage:[UIImage imageNamed:@"comment_like"] forState:UIControlStateNormal];
        [_likeBtn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _likeBtn;
}

- (UIButton *)replyBtn{
    if(!_replyBtn){
        _replyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_replyBtn setImage:[UIImage imageNamed:@"comment_reply"] forState:UIControlStateNormal];
        [_replyBtn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _replyBtn;
}

- (UIButton *)shareBtn{
    if(!_shareBtn){
        _shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_shareBtn setImage:[UIImage imageNamed:@"comment_share"] forState:UIControlStateNormal];
        [_shareBtn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _shareBtn;
}

- (UIButton *)moreBtn{
    if(!_moreBtn){
        _moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_moreBtn setImage:[UIImage imageNamed:@"comment_more"] forState:UIControlStateNormal];
        [_moreBtn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _moreBtn;
}
#pragma  mark private method

- (void)btnClicked:(UIButton *)sender{
    if(sender == self.likeBtn){
        //如果已经点过赞了 就退出
        if(!_actionBlock || _status == YES){
            _actionBlock(self,ToolBarClickTypeLike);
            return;
        }
        
        [_likeBtn setImage:[UIImage imageNamed:@"liked"] forState:UIControlStateNormal];
        [_likeBtn.imageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(32);
        }];
        
        [UIView animateWithDuration:1.f delay:0 usingSpringWithDamping:0.2 initialSpringVelocity:8.0f options:0 animations:^{
            [_likeBtn layoutIfNeeded];
        } completion:^(BOOL finished) {
            [_likeBtn setImage:[UIImage imageNamed:@"comment_liked"] forState:UIControlStateNormal];
            [_likeBtn.imageView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.height.mas_equalTo(24);
            }];
            _status = YES;              //点击后将其设为YES
        }];
        _actionBlock(self,ToolBarClickTypeLike);
    }else if(sender == self.replyBtn){
         _actionBlock(self,ToolBarClickTypeReply);
    }else if(sender == self.shareBtn){
         _actionBlock(self,ToolBarClickTypeShare);
    }else if(sender == self.moreBtn){
         _actionBlock(self,ToolBarClickTypeMore);
    }
}

- (void)updateUIByStatus:(BOOL) status action:(ToolBarActionBlock)actionBlock{
    _actionBlock = actionBlock;
    _status = status;
//    CXLog(@"点击状态为%d",status);
    if(status == YES){
        [_likeBtn setImage:[UIImage imageNamed:@"comment_liked"] forState:UIControlStateNormal];
    }else{
        [_likeBtn setImage:[UIImage imageNamed:@"comment_like"] forState:UIControlStateNormal];
    }
}

- (void)setLikeBtnSelect{
    [_likeBtn sendActionsForControlEvents:UIControlEventTouchUpInside];
}
    
@end
