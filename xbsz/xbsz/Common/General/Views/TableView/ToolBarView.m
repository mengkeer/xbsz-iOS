//
//  ToolBarView.m
//  xbsz
//
//  Created by 陈鑫 on 17/2/21.
//  Copyright © 2017年 lotus. All rights reserved.
//

#import "ToolBarView.h"

@interface ToolBarView ()

@property (nonatomic, strong) UIButton *likeBtn;
@property (nonatomic, strong) UIButton *replyBtn;
@property (nonatomic, strong) UIButton *shareBtn;
@property (nonatomic, strong) UIButton *moreBtn;

@end

@implementation ToolBarView

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
    }
    return _likeBtn;
}

- (UIButton *)replyBtn{
    if(!_replyBtn){
        _replyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_replyBtn setImage:[UIImage imageNamed:@"comment"] forState:UIControlStateNormal];
    }
    return _replyBtn;
}

- (UIButton *)shareBtn{
    if(!_shareBtn){
        _shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_shareBtn setImage:[UIImage imageNamed:@"comment_share"] forState:UIControlStateNormal];
    }
    return _shareBtn;
}

- (UIButton *)moreBtn{
    if(!_moreBtn){
        _moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_moreBtn setImage:[UIImage imageNamed:@"more"] forState:UIControlStateNormal];
    }
    return _moreBtn;
}

- (void)updateUIWithModel:(id) model action:(ToolBarActionBlock)actionBlock{
    
}

@end
