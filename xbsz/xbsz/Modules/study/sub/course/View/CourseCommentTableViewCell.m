//
//  CommentTableViewCell.m
//  xbsz
//
//  Created by lotus on 2017/4/20.
//  Copyright © 2017年 lotus. All rights reserved.
//

#import "CourseCommentTableViewCell.h"

@interface CourseCommentTableViewCell ()


@property (nonatomic, strong) UIButton *avatarBtn;

@property (nonatomic, strong) UILabel *nickLabel;

@property (nonatomic, strong) UILabel *timeLabel;

@property (nonatomic, strong) UILabel *contentLabel;

@property (nonatomic, strong) UIView *lineView;

@end

@implementation CourseCommentTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initTableViewCell];
    }
    return self;
}

- (void)initTableViewCell{
    self.contentView.backgroundColor = CXWhiteColor;
    [self.contentView addSubview:self.avatarBtn];
    
    [_avatarBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).mas_offset(15);
        make.top.mas_equalTo(self.contentView).mas_offset(15);
        make.width.height.mas_equalTo(36);
    }];
    
    [self.contentView addSubview:self.nickLabel];
    [_nickLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_avatarBtn.mas_right).mas_offset(15);
        make.top.mas_equalTo(self.contentView).mas_offset(15);
        make.height.mas_equalTo(20);
    }];
    
    [self.contentView addSubview:self.timeLabel];
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView.mas_right).mas_offset(-15);
        make.top.mas_equalTo(self.contentView).mas_offset(15);
        make.height.mas_equalTo(20);
    }];
    
    [self.contentView addSubview:self.contentLabel];
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_nickLabel.mas_bottom).mas_offset(7.5);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).mas_offset(-7.5);
        make.left.mas_equalTo(_avatarBtn.mas_right).mas_offset(15);
        make.height.mas_equalTo(25);
        make.right.mas_equalTo(self.contentView.mas_right).mas_offset(-15);
    }];
    
    
    _lineView = [[UIView alloc] init];
    _lineView.backgroundColor = CXLineColor;
    [self.contentView addSubview:_lineView];
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_avatarBtn.mas_right).mas_offset(15);
        make.right.mas_equalTo(self.contentView.mas_right);
        make.height.mas_equalTo(1/CXMainScale);
        make.bottom.mas_equalTo(self.contentView.mas_bottom);
    }];
}



#pragma mark - getter/setter

- (UIButton *)avatarBtn{
    if(!_avatarBtn){
        _avatarBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _avatarBtn.frame = CGRectMake(0, 0, 36, 36);
        [_avatarBtn setImage:[[[UIImage imageNamed:@"avatar1.jpg"] imageByResizeToSize:CGSizeMake(36, 36) contentMode:UIViewContentModeScaleToFill] imageByRoundCornerRadius:18] forState:UIControlStateNormal];
        _avatarBtn.layer.cornerRadius = 18;
        _avatarBtn.clipsToBounds = YES;
    }
    return _avatarBtn;
}

- (UILabel *)nickLabel{
    if(!_nickLabel){
        _nickLabel = [[UILabel alloc] init];
        _nickLabel.textAlignment = NSTextAlignmentLeft;
        _nickLabel.font = CXSystemFont(14);
        _nickLabel.textColor = CXHexColor(0x406599);
        _nickLabel.text = @"用户昵称";
    }
    return _nickLabel;
}

- (UILabel *)timeLabel{
    if(!_timeLabel){
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.font = CXSystemFont(12);
        _timeLabel.textColor = CXLightGrayColor;
        _timeLabel.textAlignment = NSTextAlignmentRight;
        _timeLabel.text = @"2017-04-20";
    }
    return _timeLabel;
}

- (UILabel *)contentLabel{
    if(!_contentLabel){
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.font = CXSystemFont(12);
        _contentLabel.textColor = CXBlackColor2;
        _contentLabel.text = @"";
        _contentLabel.numberOfLines = 0;
    }
    return _contentLabel;
}

#pragma mark - public method

- (void)updateUIWithModel:(CourseComment *)model{
    [self.avatarBtn yy_setImageWithURL:[NSURL URLWithString:[NSString getAvatarUrl:model.avatar]] forState:UIControlStateNormal placeholder:CXDefaultAvatar];
    [self.avatarBtn yy_setImageWithURL:[NSURL URLWithString:[NSString getAvatarUrl:model.avatar]] forState:UIControlStateHighlighted placeholder:CXDefaultAvatar];
    
    _nickLabel.text = model.nickname;
    _timeLabel.text = [model.time convertToLocalTime];
    _contentLabel.text = model.content;
    
    CGRect labelRect = [model.content boundingRectWithSize:CGSizeMake(CXScreenWidth-15-36-15-15, CGFLOAT_MAX) options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:CXSystemFont(12)} context:nil] ;
    
    NSInteger textHeight = (int)CGRectGetHeight(labelRect);
    NSInteger height = textHeight < 25 ? 25 :textHeight + 1;
  
    [_contentLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(height);
    }];
    
    [_contentLabel sizeToFit];
}

- (void)showLineView:(NSInteger)currentRow totalRows:(NSInteger)totalRows{
    if(currentRow == totalRows - 1){
        _lineView.hidden = YES;
    }else{
        _lineView.hidden = NO;
    }
}

@end
