//
//  ToolBarView.m
//  xbsz
//
//  Created by 陈鑫 on 17/2/21.
//  Copyright © 2017年 lotus. All rights reserved.
//

#import "CommentToolBarView.h"


@interface CommentToolBarView ()

@property (nonatomic, strong) UIButton *replyBtn;
@property (nonatomic, strong) UIButton *moreBtn;
@property (nonatomic, copy)   ToolBarActionBlock actionBlock;

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
    
    [self addSubview:self.replyBtn];
    [self addSubview:self.moreBtn];
    
    
    [_replyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(32);
        make.left.mas_equalTo(self.mas_left).mas_offset(6);
        make.centerY.mas_equalTo(self.mas_centerY);
    }];
    
    [_moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(32);
        make.right.mas_equalTo(self.mas_right).mas_offset(-4);
        make.centerY.mas_equalTo(self.mas_centerY);
    }];

}

- (UIButton *)replyBtn{
    if(!_replyBtn){
        _replyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_replyBtn setImage:[UIImage imageNamed:@"comment_reply"] forState:UIControlStateNormal];
        [_replyBtn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _replyBtn;
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
    if(sender == self.replyBtn){
         _actionBlock(self,ToolBarClickTypeReply);
    }else if(sender == self.moreBtn){
         _actionBlock(self,ToolBarClickTypeMore);
    }
}

- (void)updateUIByAction:(ToolBarActionBlock)actionBlock{
    _actionBlock = actionBlock;
}

    
@end
