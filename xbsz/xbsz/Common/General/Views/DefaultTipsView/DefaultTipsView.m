//
//  DeFaultTipsView.m
//  xbsz
//
//  Created by lotus on 25/03/2017.
//  Copyright © 2017 lotus. All rights reserved.
//

#import "DefaultTipsView.h"

@interface DefaultTipsView ()

@property (nonatomic, strong) UIImageView *tipsImageView;
@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, copy) void(^clickBlock)();

@end

@implementation DefaultTipsView

- (instancetype)init {
    return [self initWithFrame:CGRectZero];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.tipsImageView];
        [_tipsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(self);
            make.width.height.mas_equalTo(180);
        }];
        [self addSubview:self.titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(self);
            make.height.mas_equalTo(30);
            make.top.mas_equalTo(_tipsImageView.mas_bottom).mas_offset(20);
        }];
        @weakify(self);
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
            if(weak_self.clickBlock)    weak_self.clickBlock();
        }];
        [self addGestureRecognizer:tap];
        self.backgroundColor = CXWhiteColor;
    }
    return self;
}

#pragma mark - getter/setter

- (UIImageView *)tipsImageView{
    if(!_tipsImageView){
        _tipsImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"loadfailed"]];
    }
    return _tipsImageView;
}

- (UILabel *)titleLabel{
    if(!_titleLabel){
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"未知力量将页面吸入宇宙，请重新尝试";
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = CXSystemFont(13);
        _titleLabel.textColor = CXHexAlphaColor(0x000000, 0.7);
    }
    return _titleLabel;
}

#pragma mark - public method

- (void)updateUIWitImage:(UIImage *)image title:(NSString *)title{
    _tipsImageView.image = image;
    _titleLabel.text = title;
}

- (void)SetClicked:(void (^)())clickBlock{
    _clickBlock = clickBlock;
}



@end
