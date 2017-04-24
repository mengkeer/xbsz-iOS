//
//  ChapterTableViewCell.m
//  xbsz
//
//  Created by lotus on 2017/4/24.
//  Copyright © 2017年 lotus. All rights reserved.
//

#import "ExerciseChapterTableViewCell.h"

static NSInteger imageWidth = 32;

@interface ExerciseChapterTableViewCell ()

@property (nonatomic, strong) UIImageView *iconImageView;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *numLabel;

@end

@implementation ExerciseChapterTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if([super initWithStyle:style reuseIdentifier:reuseIdentifier]){
//        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initChapterCell];
    }
    return self;
}

- (void)initChapterCell{
    [self.contentView addSubview:self.iconImageView];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = CXLineColor;
    [self.contentView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).mas_offset(15);
        make.right.mas_equalTo(self.contentView.mas_right).mas_offset(-15);;
        make.height.mas_equalTo(1/CXMainScale);
        make.top.mas_equalTo(self.contentView.mas_top);
    }];
    
    [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(imageWidth);
        make.left.mas_equalTo(self.contentView).mas_offset(15);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
    }];
    
    [self.contentView addSubview:self.titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.left.mas_equalTo(_iconImageView.mas_right).mas_offset(15);
        make.width.mas_equalTo(100);
    }];
    
    [self.contentView addSubview:self.numLabel];
    [_numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView).mas_offset(-15);
        make.width.mas_equalTo(60);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
    }];
}

#pragma mark - getter/setter

- (UIImageView *)iconImageView{
    if(!_iconImageView){
        _iconImageView = [[UIImageView alloc] init];
        _iconImageView.backgroundColor = CXClearColor;
        _iconImageView.contentMode = UIViewContentModeScaleAspectFit;
        _iconImageView.layer.cornerRadius = imageWidth/2;
        _iconImageView.clipsToBounds = YES;
    }
    return _iconImageView;
}

- (UILabel *)titleLabel{
    if(!_titleLabel){
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = CXBlackColor;
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.font = CXSystemFont(15);
    }
    return _titleLabel;
}

- (UILabel *)numLabel{
    if(!_numLabel){
        _numLabel = [[UILabel alloc] init];
        _numLabel.textColor = CXLightGrayColor;
        _numLabel.font = CXSystemFont(12);
        _numLabel.textAlignment = NSTextAlignmentRight;
    }
    return _numLabel;
}

#pragma mark - public method

- (void)updateUI:(NSInteger)index title:(NSString *)title num:(NSInteger)num{
    _iconImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"chapter_%ld",index]];
    if(title != nil && [title length] != 0){
        _titleLabel.text = title;
    }else{
        _titleLabel.text = [NSString stringWithFormat:@"第%ld章",index+1];
    }
    
    _numLabel.text = [NSString stringWithFormat:@"共%ld题",num];
}

@end
