//
//  QuestionTableViewCell.m
//  xbsz
//
//  Created by lotus on 2017/4/25.
//  Copyright © 2017年 lotus. All rights reserved.
//

#import "QuestionTableViewCell.h"
#import "StudyUtil.h"

static NSInteger symbolWidth = 35;

@interface QuestionTableViewCell ()

@property (nonatomic, strong) UILabel *symbolLabel;     //符号 A，B，C，D等

@property (nonatomic, strong) UILabel *optionLabel;

@property (nonatomic, assign) BOOL isSingle;

@end

@implementation QuestionTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if([super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self initQuestionCell];
    }
    return self;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier isSingle:(BOOL)isSingle{
    _isSingle = isSingle;
    return [self initWithStyle:style reuseIdentifier:reuseIdentifier];
}

- (void)initQuestionCell{
    [self.contentView addSubview:self.symbolLabel];
    [self.contentView addSubview:self.optionLabel];
    [_symbolLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).mas_offset(15);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.width.height.mas_equalTo(symbolWidth);
    }];
    
    [_optionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_symbolLabel.mas_right).mas_offset(10);
        make.top.mas_equalTo(self.contentView.mas_top).mas_offset(10);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).mas_offset(-10);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.right.mas_equalTo(self.contentView.mas_right).mas_offset(-15);
        make.height.mas_equalTo(20);
    }];
}

- (UILabel *)symbolLabel{
    if(!_symbolLabel){
        _symbolLabel = [[UILabel alloc] init];
        _symbolLabel.font = CXSystemFont(22);
        _symbolLabel.textColor = CXBlackColor;
        _symbolLabel.textAlignment = NSTextAlignmentCenter;
        if(_isSingle){
            _symbolLabel.layer.borderWidth = 1;
            _symbolLabel.layer.cornerRadius = symbolWidth/2;
            _symbolLabel.layer.borderColor = CXBlackColor.CGColor;
            _symbolLabel.clipsToBounds = YES;
        }else{
            _symbolLabel.layer.borderWidth = 1;
            _symbolLabel.layer.cornerRadius = 6;
            _symbolLabel.layer.borderColor = CXBlackColor.CGColor;
            _symbolLabel.clipsToBounds = YES;
        }
       
    }
    return _symbolLabel;
}

- (UILabel *)optionLabel{
    if(!_optionLabel){
        _optionLabel = [[UILabel alloc] init];
        _optionLabel.textAlignment = NSTextAlignmentLeft;
        _optionLabel.font = CXSystemFont(15);
        _optionLabel.textColor = CXBlackColor;
        _optionLabel.numberOfLines = 0;
    }
    return _optionLabel;
}

- (void)updateUIWithIndex:(NSInteger)index option:(NSString *)option{
    NSString *symbolText = [StudyUtil indexConvertToSymbol:index];
    _symbolLabel.text = symbolText;
    [self updateOptionUI:QuestionStatusSingleDefault];
    
    NSInteger textHeight = [self getTitleHeight:option];
    [_optionLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(textHeight);
    }];
    [_optionLabel sizeToFit];
}

- (void)showSingleRightAnswer:(NSInteger)index answer:(NSString *)answer{
    if([StudyUtil isSingleRightAnswer:index answer:answer]){
        [self updateOptionUI:QuestionStatusSingleRight];
    }else{
        [self updateOptionUI:QuestionStatusSingleDefault];
    }
}

- (void)showSinglePracticeResult:(NSInteger)index
       selectedIndex:(NSInteger)selectedIndex
              answer:(NSString *)answer{
    
    if([StudyUtil isSingleRightAnswer:index answer:answer]){
        [self updateOptionUI:QuestionStatusSingleRight];
    }else{
        if(index == selectedIndex){
            [self updateOptionUI:QuestionStatusSingleWrong];
            return;
        }
        [self updateOptionUI:QuestionStatusSingleDefault];
    }
}

- (void)showMutiPracticeResult:(NSInteger)index
                 selectedIndex:(NSString *)selectedIndexs
                        answer:(NSString *)answer{
    

    BOOL isRight = [StudyUtil isMutiRightAnswer:selectedIndexs answer:answer];
    if(isRight){
        NSString *str = [NSString stringWithFormat:@"%ld",index];
        if([selectedIndexs containsString:str]){
            [self updateOptionUI:QuestionStatusMutiRight];
        }else{
            [self updateOptionUI:QuestionStatusMutiDefault];
        }
    }else{
        NSString *str = [NSString stringWithFormat:@"%ld",index];
        if([selectedIndexs containsString:str] && [StudyUtil isSingleRightAnswer:index answer:answer]){
            [self updateOptionUI:QuestionStatusMutiRightWrong];
        }else if([StudyUtil isSingleRightAnswer:index answer:answer] && ![selectedIndexs containsString:str]){
            [self updateOptionUI:QuestionStatusMutiRight];
        }else if(![StudyUtil isSingleRightAnswer:index answer:answer] && [selectedIndexs containsString:str]){
            [self updateOptionUI:QuestionStatusMutiWrong];
        }else{
            [self updateOptionUI:QuestionStatusMutiDefault];
        }
    }
}

- (void)setTemporarySelected:(NSInteger)index selectedIndexs:(NSString *)selectedIndexs{
    if([selectedIndexs containsString:[NSString stringWithFormat:@"%ld",index]]){
        [self updateOptionUI:QuestionStatusMutiSelected];
    }else{
        [self updateOptionUI:QuestionStatusMutiDefault];
    }
}

- (void)updateOptionUI:(QuestionStatus)status{
    
    if(status == QuestionStatusSingleDefault || status == QuestionStatusMutiDefault){
        _symbolLabel.layer.borderWidth = 1;
        _symbolLabel.layer.borderColor = CXBlackColor.CGColor;
        _symbolLabel.textColor = CXBlackColor;
        _symbolLabel.backgroundColor = CXWhiteColor;
        return;
    }
    
    if(status == QuestionStatusSingleRight || status == QuestionStatusMutiRight){
        _symbolLabel.layer.borderWidth = 0;
        _symbolLabel.backgroundColor = CXHexColor(0x08b292);
        _symbolLabel.textColor = CXWhiteColor;
        return;
    }
    
    if(status == QuestionStatusSingleWrong || status == QuestionStatusMutiWrong){
        _symbolLabel.layer.borderWidth = 0;
        _symbolLabel.backgroundColor = CXRedColor;
        _symbolLabel.textColor = CXWhiteColor;
        return;
    }
    
    if(status == QuestionStatusMutiSelected){
        _symbolLabel.layer.borderWidth = 1;
        _symbolLabel.layer.borderColor = CXHexColor(0x08b292).CGColor;
        _symbolLabel.textColor = CXHexColor(0x08b292);
        _symbolLabel.backgroundColor = CXWhiteColor;
        return;
    }
    
    if(status == QuestionStatusMutiRightWrong){
        UIColor *color = [UIColor colorWithPatternImage:[UIImage imageNamed:@"statusRightError"]];
        [_symbolLabel setBackgroundColor:color];
        
        _symbolLabel.layer.borderWidth = 0;
        [_symbolLabel setClipsToBounds:YES];
        return;
    }
    
    

}

- (NSInteger)getTitleHeight:(NSString *)text{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:3];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [text length])];
    _optionLabel.attributedText = attributedString;
    
    CGSize size = CGSizeMake(CXScreenWidth-15-symbolWidth-10-15, CGFLOAT_MAX);
    CGRect labelRect = [text boundingRectWithSize:size
                                          options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin
                                       attributes:@{NSFontAttributeName:CXSystemFont(15),NSParagraphStyleAttributeName:paragraphStyle} context:nil] ;
    
    NSInteger textHeight = (int)CGRectGetHeight(labelRect)+1;
    
    if(textHeight<30)   return 30;
    
    return textHeight;
}

@end
