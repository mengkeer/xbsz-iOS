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

@property (nonatomic, strong) UILabel *semesterLabel;

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
    [self.contentView addSubview:self.semesterLabel];
    
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(imageWidth);
        make.height.mas_equalTo(imageHeight);
        make.left.right.mas_equalTo(self.contentView);
        make.top.mas_equalTo(self.contentView.mas_top);
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_imageView.mas_bottom);
        make.left.right.mas_equalTo(self.contentView);
        make.height.mas_equalTo(20);
    }];
    
    [_semesterLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_titleLabel.mas_bottom);
        make.left.right.mas_equalTo(self.contentView);
        make.height.mas_equalTo(20);
        make.bottom.mas_equalTo(self.contentView.mas_bottom);
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

- (UILabel *)semesterLabel{
    if(!_semesterLabel){
        _semesterLabel = [[UILabel alloc] init];
        _semesterLabel.textColor = CXLightGrayColor;
        _semesterLabel.font = CXSystemFont(10);
        _semesterLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _semesterLabel;
}


#pragma mark - public method

- (void)updateCellWithModel:(id)model{
    Exercise *exercise = (Exercise *)model;
    _titleLabel.text = exercise.title;
    _semesterLabel.text = [NSString stringWithFormat:@"%@·最新",exercise.semester];
    NSURL *url = [NSURL URLWithString:exercise.icon];
    [_imageView yy_setImageWithURL:url options:0];
}

- (void)registerTouch:(id)delegate{
    [delegate registerForPreviewingWithDelegate:delegate sourceView:_imageView];
}

@end
