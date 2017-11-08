//
//  ToolBarCell.m
//  xbsz
//
//  Created by lotus on 18/03/2017.
//  Copyright © 2017 lotus. All rights reserved.
//

#import "ToolBarCell.h"

@interface ToolBarCell ()

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation ToolBarCell : UICollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self initToolBarCell];
    }
    return self;
}

- (void)initToolBarCell{
    self.contentView.backgroundColor = CXClearColor;
    
    [self.contentView addSubview:self.imageView];
    [self.contentView addSubview:self.titleLabel];
        
    
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(self.contentView);
        make.height.mas_equalTo(60);
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.mas_equalTo(self.contentView);
        make.height.mas_equalTo(30);
        make.top.mas_equalTo(_imageView.mas_bottom);
    }];
}

- (UIImageView *)imageView{
    if(!_imageView){
        _imageView = [[UIImageView alloc] init];
        _imageView.layer.cornerRadius = 30;
        _imageView.clipsToBounds = YES;
    }
    return _imageView;
}

- (UILabel *)titleLabel{
    if(!_titleLabel){
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = CXSystemFont(10);
        _titleLabel.textColor = CXHexAlphaColor(0x000000, 0.8);
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (void)updateCellWithImageName:(NSString *)imageName title:(NSString *)title{
    _imageView.image = [UIImage imageNamed:imageName];
    _titleLabel.text = title;
}

@end
