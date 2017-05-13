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
    self.contentView.backgroundColor = CXHexColor(0xf7f9fc);
    
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


@interface CourseChapterTableViewCell ()

@property (nonatomic, strong) UILabel *markLabel;

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation CourseChapterTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        self.selectionStyle = UITableViewCellSelectionStyleDefault;
        [self initTableViewCell];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated{
    if(selected == YES){
        self.contentView.backgroundColor = CXHexColor(0xf4fcf8);
        _markLabel.textColor = CXHexColor(0x2cc17b);
        _markLabel.layer.borderColor = CXHexColor(0x2cc17b).CGColor;
        _titleLabel.textColor = CXHexColor(0x2cc17b);
    }else{
        self.contentView.backgroundColor = CXWhiteColor;
        _markLabel.textColor = CXHexColor(0x7f8698);
        _markLabel.layer.borderColor = CXHexColor(0x7f8698).CGColor;
        _titleLabel.textColor = CXHexColor(0x7b8395);
    }
}

- (void)initTableViewCell{
    
    self.contentView.backgroundColor = CXWhiteColor;
    
    [self.contentView addSubview:self.markLabel];
    [self.contentView addSubview:self.titleLabel];
    
    [_markLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).mas_offset(15);
        make.width.mas_equalTo(75);
        make.height.mas_equalTo(18);
        make.centerY.mas_equalTo(self.contentView);
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.markLabel.mas_right).mas_offset(10);
        make.height.mas_equalTo(30);
        make.right.mas_equalTo(self.contentView.mas_right).mas_offset(15);
        make.centerY.mas_equalTo(self.contentView);
    }];
    
    
//    UIView *lineView = [[UIView alloc] init];
//    lineView.backgroundColor = CXLineColor;
//    [self.contentView addSubview:lineView];
//    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.height.mas_equalTo(1/CXMainScale);
//        make.left.mas_equalTo(self.contentView).mas_offset(15);
//        make.right.mas_equalTo(self.contentView);
//        make.bottom.mas_equalTo(self.contentView.mas_bottom);
//    }];
}

- (UILabel *)markLabel{
    if(!_markLabel){
        _markLabel = [[UILabel alloc] init];
        _markLabel.font = CXSystemFont(12);
        _markLabel.textColor = CXHexColor(0x7f8698);
        _markLabel.textAlignment = NSTextAlignmentCenter;
        _markLabel.layer.cornerRadius = 2;
        _markLabel.layer.borderColor = CXHexColor(0x7f8698).CGColor;
        _markLabel.layer.borderWidth = 1;
        _markLabel.clipsToBounds = YES;
        
    }
    return _markLabel;
}

- (UILabel *)titleLabel{
    if(!_titleLabel){
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = CXSystemFont(16);
        _titleLabel.textColor = CXHexColor(0x7b8395);
        _titleLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _titleLabel;
}

- (void)updateUIWithModel:(CourseWare *)model{
    NSString *type = [model.file pathExtension];
    
    CGRect labelRect = [type boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:CXSystemFont(12)} context:nil] ;
    _markLabel.text = type;
    [_markLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(labelRect.size.width+10);
    }];
    
    _titleLabel.text = model.name;
}

@end
