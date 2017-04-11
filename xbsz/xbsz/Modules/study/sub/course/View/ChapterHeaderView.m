//
//  ChapterHeaderView.m
//  xbsz
//
//  Created by lotus on 2017/4/11.
//  Copyright © 2017年 lotus. All rights reserved.
//

#import "ChapterHeaderView.h"

@interface ChapterHeaderView ()

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIButton *foldBtn;

@property (nonatomic, assign) BOOL canFold;

@end

@implementation ChapterHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithReuseIdentifier:reuseIdentifier]){
        [self initChapterHeaderView];
    }
    return self;
}

#pragma mark - initChapterView

- (void)initChapterHeaderView{
    self.contentView.backgroundColor = CXHexAlphaColor(0xF6F6F6, 0.1);
    
    self.contentView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(btnClicked)];
    [self addGestureRecognizer:tap];
    
    [self addSubview:self.titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).mas_offset(15);
        make.centerY.mas_equalTo(self);
    }];
    
    [self addSubview:self.foldBtn];
    [_foldBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self).mas_offset(-15);
        make.centerY.mas_equalTo(self);
    }];
}

#pragma mark - getter/setter

- (UILabel *)titleLabel{
    if(!_titleLabel){
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = CXSystemFont(14);
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.textColor = CXBlackColor;
        _titleLabel.text = @"章节目录";
    }
    return _titleLabel;
}

- (UIButton *)foldBtn{
    if(!_foldBtn){
        _foldBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_foldBtn setImage:[UIImage imageNamed:@"unfoldedChapter"] forState:UIControlStateNormal];
        [_foldBtn setImage:[UIImage imageNamed:@"unfoldedChapter"] forState:UIControlStateHighlighted];
        [_foldBtn addTarget:self action:@selector(btnClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _foldBtn;
}

- (void)setIsFolded:(BOOL)isFolded{
    if(_canFold == NO)  return;
    if(isFolded == NO){
        [_foldBtn setImage:[UIImage imageNamed:@"unfoldedChapter"] forState:UIControlStateNormal];
        [_foldBtn setImage:[UIImage imageNamed:@"unfoldedChapter"] forState:UIControlStateHighlighted];
    }else{
        [_foldBtn setImage:[UIImage imageNamed:@"foldedChapter"] forState:UIControlStateNormal];
        [_foldBtn setImage:[UIImage imageNamed:@"foldedChapter"] forState:UIControlStateHighlighted];
    }
}

#pragma mark - public method
- (void)updateSectionHeader:(NSString *)title section:(NSInteger)section canFold:(BOOL)canFold{
    _titleLabel.text = title;
    _section = section;
    _canFold = canFold;
}

#pragma mark - private mathod
- (void)btnClicked{
    if(_canFold == YES && [_delegate respondsToSelector:@selector(foldHeaderInSection:)]){
        [_delegate foldHeaderInSection:_section];
    }
}

@end
