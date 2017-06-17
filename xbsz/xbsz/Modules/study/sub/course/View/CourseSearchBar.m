//
//  CourseSearchBar.m
//  xbsz
//
//  Created by 陈鑫 on 17/3/13.
//  Copyright © 2017年 lotus. All rights reserved.
//

#import "CourseSearchBar.h"

@interface CourseSearchBar ()

@property (nonatomic, copy) SearchBarActionBlock actionBlock;


@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *tilteLabel;

@property (nonatomic, strong) UIButton *btn;

@end

@implementation CourseSearchBar

- (instancetype)init{
    if(self = [super init]){
        [self initSearchBar];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self initSearchBar];
    }
    return self;
}


- (void)initSearchBar{
    self.userInteractionEnabled = YES;
    self.layer.cornerRadius = 6;
    self.clipsToBounds = YES;
    self.layer.borderColor = CXLightGrayColor.CGColor;
    self.layer.borderWidth = 1/CXMainScale;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(click)];
    [self addGestureRecognizer:tap];
//    
//    [self addSubview:self.imageView];
//    [self addSubview:self.tilteLabel];

    [self addSubview:self.btn];
    
    [_btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(20);
        make.centerX.mas_equalTo(self.mas_centerX);
        make.centerY.mas_equalTo(self.mas_centerY);
    }];
    
    
}


#pragma mark - getter/setter

- (UIImageView *)imageView{
    if(!_imageView){
        _imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"course_search"]];
    }
    return _imageView;
}

- (UILabel *)tilteLabel{
    if(!_tilteLabel){
        _tilteLabel = [[UILabel alloc] init];
        _tilteLabel.textColor = CXLightGrayColor;
        _tilteLabel.font = CXSystemFont(10);
    }
    return _tilteLabel;
}

- (UIButton *)btn{
    if(!_btn){
        _btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btn setImage:[UIImage imageNamed:@"course_search"] forState:UIControlStateNormal];
        [_btn setTitle:@"搜索课程" forState:UIControlStateNormal];
        _btn.titleLabel.font = CXSystemFont(12);
        [_btn setImageEdgeInsets:UIEdgeInsetsMake(0.0, -5, 0.0, 0.0)];
        [_btn setTitleColor:CXLightGrayColor forState:UIControlStateNormal];
        [_btn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn;
}


- (void)setClicked:(SearchBarActionBlock)action{
    _actionBlock = action;
}

- (void)click{
    if(_actionBlock)    _actionBlock();
}

@end
