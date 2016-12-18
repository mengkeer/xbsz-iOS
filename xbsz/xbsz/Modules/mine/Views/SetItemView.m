//
//  SetItemView.m
//  xbsz
//
//  Created by 陈鑫 on 16/12/15.
//  Copyright © 2016年 lotus. All rights reserved.
//

#import "SetItemView.h"

@interface SetItemView ()

@property (nonatomic,strong) UILabel  *titleLabel;


@property (nonatomic,assign) SetItemType type;

@property (nonatomic,strong) UISwitch *iSwitch;

@property (nonatomic,strong) UIButton *rightArrow;




@end


@implementation SetItemView


- (instancetype)initWithFrame:(CGRect )frame{
    self = [super initWithFrame:frame];
    if(self){
    }
    return self;
}

- (void)setHeadImage:(UIImage *)image{
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    [imageView cornerRadius:self.height*0.7*0.5 borderWidth:0 borderColor:nil];
    
    [self addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(_rightArrow.mas_left).mas_offset(-5);
        make.height.and.width.mas_equalTo(self.height*0.7);
        make.centerY.mas_equalTo(self.mas_centerY);
    }];

}

//当type为SetItemTypeImageAndArrow  image为用户缩略头像  否则为row左侧图标
- (void)setTitle:(NSString *)title andDetailText:(NSString *)detailText andType:(SetItemType)type andImage:(UIImage *)image{
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.text = title;
    _titleLabel.font =  CXSetItemFont;
    _titleLabel.textColor = CXBlackColor;
    [self addSubview:_titleLabel];

    
    if(image != nil){
        
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        [self addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.mas_equalTo(self).mas_offset(15);
            make.width.height.mas_equalTo(24);
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
        
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.mas_equalTo(imageView.mas_right).mas_offset(8);
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
        
    }else{
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.mas_equalTo(self).mas_offset(15);
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
    }
    
    
    if(type == SetItemTypeSwitch){
        
        _iSwitch = [[UISwitch alloc] init];
        _iSwitch.on = YES;
        _iSwitch.onTintColor = CXMainColor;
        [self addSubview:_iSwitch];
        [_iSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.mas_right).mas_offset(-15);
            make.height.mas_offset(30);
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
        
    }else if(type == SetItemTypeArrow){
        
        _rightArrow = [UIButton buttonWithType:UIButtonTypeCustom];
        [_rightArrow setImage:[UIImage imageNamed:@"common_right_arrow"] forState:UIControlStateNormal];
        [_rightArrow setImage:[UIImage imageNamed:@"common_right_arrow"] forState:UIControlStateHighlighted];
        [self addSubview:_rightArrow];
        
        [_rightArrow mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.mas_right).mas_offset(-8);
            make.centerY.mas_equalTo(self.mas_centerY);
            make.width.height.mas_equalTo(25);
        }];

        
    }else if(type == SetItemTypeTextAndArrow){
        
        _rightArrow = [UIButton buttonWithType:UIButtonTypeCustom];
        [_rightArrow setImage:[UIImage imageNamed:@"common_right_arrow"] forState:UIControlStateNormal];
        [_rightArrow setImage:[UIImage imageNamed:@"common_right_arrow"] forState:UIControlStateHighlighted];
        [self addSubview:_rightArrow];
        
        [_rightArrow mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.mas_right).mas_offset(-8);
            make.centerY.mas_equalTo(self.mas_centerY);
            make.width.height.mas_equalTo(25);
        }];
        
        
        UILabel *detailLabel = [[UILabel alloc] init];
        detailLabel.font =  CXSetItemDetailFont;
        detailLabel.text = detailText;
        detailLabel.textColor = [UIColor lightGrayColor];
        detailLabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:detailLabel];
        [detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(14);
            make.width.mas_equalTo(self.width/2);
            make.centerY.mas_equalTo(self.mas_centerY);
            make.right.mas_equalTo(_rightArrow.mas_left).mas_offset(-5);
        }];
        

        
    }else if(type == SetItemTypeDetailText){
        
        UILabel *detailLabel = [[UILabel alloc] init];
        detailLabel.font =  CXSetItemDetailFont;
        detailLabel.text = detailText;
        detailLabel.textColor = [UIColor lightGrayColor];
        [self addSubview:detailLabel];
        [detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(14);
            make.centerY.mas_equalTo(self.mas_centerY);
            make.right.mas_equalTo(self.mas_right).mas_offset(-15);
        }];
        
    }else{
        
        _rightArrow = [UIButton buttonWithType:UIButtonTypeCustom];
        [_rightArrow setImage:[UIImage imageNamed:@"common_right_arrow"] forState:UIControlStateNormal];
        [_rightArrow setImage:[UIImage imageNamed:@"common_right_arrow"] forState:UIControlStateHighlighted];
        [self addSubview:_rightArrow];
        
        [_rightArrow mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.mas_right).mas_offset(-8);
            make.centerY.mas_equalTo(self.mas_centerY);
            make.width.height.mas_equalTo(25);
        }];
        
    }
    
}

@end
