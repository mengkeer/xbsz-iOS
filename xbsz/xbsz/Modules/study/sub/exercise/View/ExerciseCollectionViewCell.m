//
//  CourseCollectionViewCell.m
//  xbsz
//
//  Created by 陈鑫 on 17/3/13.
//  Copyright © 2017年 lotus. All rights reserved.
//

#import "ExerciseCollectionViewCell.h"
#import "Exercise.h"

@interface ExerciseCollectionViewCell ()

@property (nonatomic, strong) YYAnimatedImageView *imageView;

@property (nonatomic, strong) UILabel *titleLabel;

@end


@implementation ExerciseCollectionViewCell


- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self initCollectionCell];
    }
    return self;
}

- (void)initCollectionCell{
    
    self.contentView.backgroundColor = CXWhiteColor;
    
    [self.contentView addSubview:self.imageView];
    [self.contentView addSubview:self.titleLabel];
    
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(imageWidth);
        make.height.mas_equalTo(imageHeight);
        make.left.right.mas_equalTo(self.contentView);
        make.top.mas_equalTo(self.contentView.mas_top);
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_imageView.mas_bottom).mas_offset(4);
        make.left.right.mas_equalTo(self.contentView);
        make.height.mas_equalTo(24);
    }];
    
 
}


#pragma mark - getter/setter

- (YYAnimatedImageView *)imageView{
    if(!_imageView){
        _imageView = [[YYAnimatedImageView alloc] init];
        _imageView.userInteractionEnabled = YES;
        _imageView.layer.cornerRadius = 4;
        _imageView.clipsToBounds = YES;
    }
    return _imageView;
}


- (UILabel *)titleLabel{
    if(!_titleLabel){
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = CXSystemFont(12);
        _titleLabel.textColor = CXBlackColor;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}


#pragma mark - public method

- (void)updateCellWithModel:(id)model{
    Exercise *exercise = (Exercise *)model;
    _titleLabel.text = exercise.title;
    NSURL *url = [NSURL URLWithString:exercise.icon];
    [_imageView yy_setImageWithURL:url options:0];
}

- (void)registerTouch:(id)delegate{
    [delegate registerForPreviewingWithDelegate:delegate sourceView:_imageView];
}

@end
