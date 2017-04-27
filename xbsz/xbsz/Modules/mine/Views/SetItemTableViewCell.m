//
//  SetItemView.m
//  xbsz
//
//  Created by 陈鑫 on 16/12/15.
//  Copyright © 2016年 lotus. All rights reserved.
//

#import "SetItemTableViewCell.h"

@interface SetItemTableViewCell ()

@property (nonatomic, strong) UIImageView *iconImageView;

@property (nonatomic, strong) UILabel  *titleLabel;

@property (nonatomic, strong) UILabel *detailLabel;

@property (nonatomic, assign) SetItemType type;

@property (nonatomic, strong) UISwitch *iSwitch;

@property (nonatomic, strong) UIButton *rightArrow;

@property (nonatomic, strong) UIImageView *headImageView;


@end


@implementation SetItemTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initTableViewCell];
    }
    return self;
}



- (void)initTableViewCell{
    [self.contentView addSubview:self.iconImageView];
    [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).mas_offset(15);
        make.width.height.mas_equalTo(24);
        make.centerY.mas_equalTo(self.mas_centerY);
    }];
    
    [self.contentView addSubview:self.titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_iconImageView.mas_right).mas_offset(8);
        make.centerY.mas_equalTo(self.mas_centerY);
    }];
    
    [self.contentView addSubview:self.iSwitch];
    [_iSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).mas_offset(-15);
        make.height.mas_offset(30);
        make.centerY.mas_equalTo(self.mas_centerY);
    }];
    
    [self.contentView addSubview:self.rightArrow];
    [_rightArrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).mas_offset(-8);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.width.height.mas_equalTo(25);
    }];
    
    [self.contentView addSubview:self.headImageView];
    [_headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(_rightArrow.mas_left).mas_offset(-5);
        make.height.and.width.mas_equalTo(70);
        make.centerY.mas_equalTo(self.mas_centerY);
    }];
    
    [self.contentView addSubview:self.detailLabel];
    [_detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(14);
        make.width.mas_equalTo(self.width/2);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.right.mas_equalTo(_rightArrow.mas_left).mas_offset(-5);
    }];
}

#pragma mark - getter/setter
- (UIImageView *)iconImageView{
    if(!_iconImageView){
        _iconImageView = [[UIImageView alloc] init];
    }
    return _iconImageView;
}

- (UILabel *)titleLabel{
    if(!_titleLabel){
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font =  CXSetItemFont;
        _titleLabel.textColor = CXHexAlphaColor(0x000000, 0.8);
    }
    return _titleLabel;
}

- (UILabel *)detailLabel{
    if(!_detailLabel){
        _detailLabel = [[UILabel alloc] init];
        _detailLabel.font =  CXSetItemDetailFont;
        _detailLabel.textColor = [UIColor lightGrayColor];
        _detailLabel.textAlignment = NSTextAlignmentRight;
    }
    return _detailLabel;
}

- (UISwitch *)iSwitch{
    if(!_iSwitch){
        _iSwitch = [[UISwitch alloc] init];
        _iSwitch.on = YES;
        _iSwitch.onTintColor = CXMainColor;
    }
    return _iSwitch;
}

- (UIImageView *)headImageView{
    if(!_headImageView){
        _headImageView = [[UIImageView alloc] init];
        [_headImageView cornerRadius:35 borderWidth:0 borderColor:nil];
    }
    return _headImageView;
}

- (UIButton *)rightArrow{
    if(!_rightArrow){
        _rightArrow = [UIButton buttonWithType:UIButtonTypeCustom];
        [_rightArrow setImage:[UIImage imageNamed:@"common_right_arrow"] forState:UIControlStateNormal];
        [_rightArrow setImage:[UIImage imageNamed:@"common_right_arrow"] forState:UIControlStateHighlighted];
        _rightArrow.enabled = NO;
    }
    return _rightArrow;
}

#pragma mark - public method

- (void)updateCell:(NSString *)title detailText:(NSString *)detailText type:(SetItemType)type iconImageName:(NSString *)imageName{
 
    self.titleLabel.text = title;
    self.iconImageView.image = [UIImage imageNamed:imageName];
    
    if(type == SetItemTypeSwitch){
        _headImageView.hidden = YES;
        _detailLabel.hidden = YES;
        _rightArrow.hidden = YES;
        _iSwitch.hidden = NO;
    }else{
        _iSwitch.hidden = YES;
    }
    
    if(type == SetItemTypeArrow){
        _rightArrow.hidden = NO;
        
    }
    
    if(type == SetItemTypeTextAndArrow){
        _detailLabel.text = detailText;
        _detailLabel.hidden = NO;
    }
    
    if(type == SetItemTypeDetailText){
        _detailLabel.text = detailText;
        _detailLabel.hidden = NO;
        _rightArrow.hidden = YES;
        [_detailLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.mas_right).mas_offset(-15);
        }];
    }
    
    if(type == SetItemTypeImageAndArrow){
        _headImageView.hidden = NO;
    }else{
        _headImageView.hidden = YES;
    }
}
 
- (void)setHeadImage:(NSString *)imageUrl{
    _headImageView.yy_imageURL = [NSURL URLWithString:imageUrl];
}

@end
