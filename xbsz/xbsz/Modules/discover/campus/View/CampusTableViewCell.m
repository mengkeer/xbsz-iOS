//
//  CampusTableViewCell.m
//  xbsz
//
//  Created by 陈鑫 on 17/2/21.
//  Copyright © 2017年 lotus. All rights reserved.
//

#import "CampusTableViewCell.h"
#import "CommentToolBarView.h"
#import <YYImage/YYAnimatedImageView.h>
#import <YYText/YYText.h>


#define  paddingX   (10)
#define  wordsFont   CXSystemFont(12)
#define  boldWordsFont  CXSystemBoldFont(12)

@interface CampusTableViewCell ()

//用户信息View  包含头像 昵称  地点等
@property (nonatomic, strong) UIView *userInfoView;
@property (nonatomic, strong) UIButton *headBtn;
@property (nonatomic, strong) UILabel *nickNameLabel;
//@property (nonatomic, strong) UILabel *locationLabel;         //暂时不显示地址  后续版本考虑添加

//用户分享的图片
@property (nonatomic, strong) UIImageView *sharedImageView;
@property (nonatomic, strong) CommentToolBarView *toolBarView;      //点赞 留言 分享 更多等功能

@property (nonatomic, strong) UIView *lineView;     //工具栏下的分割线

@property (nonatomic, strong) UIView *likedInfoView;
@property (nonatomic, strong) UIImageView *likedImgaeView;
@property (nonatomic, strong) UILabel *likeNumLabel;        //显示点赞数量

@property (nonatomic, strong) YYLabel *sharedWordsLabel;          //用户分享时的留言
@property (nonatomic, strong) NSMutableAttributedString *words;

@property (nonatomic, strong) UILabel *moreReplyLabel;          //更多回复提示

@property (nonatomic, strong) UILabel *dateLabel;       //发布日期

@property (nonatomic, strong) CampusNote *note;

@property (nonatomic, copy) CellActionBlock actionBlock;


@end

@implementation CampusTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
//    self.contentView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initTableViewCell];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

#pragma mark private method

- (void)initTableViewCell{
    
    [self.contentView addSubview:self.userInfoView];
    
    [_userInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self.contentView);
        make.height.mas_equalTo(50);
        make.left.top.right.mas_equalTo(self.contentView);
    }];
    
    [_headBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).mas_offset(8);
        make.centerY.mas_equalTo(_userInfoView.mas_centerY);
    }];
    
    [_nickNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_headBtn.mas_right).mas_offset(15);
        make.centerY.mas_equalTo(_userInfoView.mas_centerY).mas_offset(-8);
    }];
    
    [_dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_headBtn.mas_right).mas_offset(15);
        make.centerY.mas_equalTo(_userInfoView.mas_centerY).mas_offset(8);
    }];
    
    
    [self.contentView addSubview:self.sharedImageView];

    
    [_sharedImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_userInfoView.mas_bottom);
        make.left.right.mas_equalTo(self.contentView);
    }];
    
    [self.contentView addSubview:self.toolBarView];
    
    [_toolBarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.contentView);
        make.top.mas_equalTo(_sharedImageView.mas_bottom);
        make.height.mas_equalTo(45);
    }];

    [self.contentView addSubview:self.lineView];
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_toolBarView.mas_bottom);
        make.left.mas_equalTo(self.contentView).mas_offset(paddingX);
        make.right.mas_equalTo(self.contentView).mas_offset(-paddingX);
        make.height.mas_equalTo(1/CXMainScale);
    }];
    
    //添加已点赞人数
    [self.contentView addSubview:self.likedInfoView];
    [_likedInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_lineView.mas_bottom);
        make.left.mas_equalTo(self.contentView.mas_left).mas_offset(paddingX);
        make.right.mas_equalTo(self.contentView.mas_right).mas_offset(-paddingX);
//        make.bottom.mas_equalTo(self.contentView.mas_bottom);
        make.height.mas_equalTo(30);
    }];
    
    [_likedImgaeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(12);
        make.left.mas_equalTo(_likedInfoView.mas_left);
        make.centerY.mas_equalTo(_likedInfoView.mas_centerY);
    }];
    
    [_likeNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(12);
        make.left.mas_equalTo(_likedImgaeView.mas_right).mas_offset(4);
        make.centerY.mas_equalTo(_likedInfoView.mas_centerY);
    }];
    
    //添加用户发表图片时的留言
    [self.contentView addSubview:self.sharedWordsLabel];
    [_sharedWordsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_likedInfoView.mas_bottom);
        make.left.mas_equalTo(self.contentView.mas_left).mas_offset(paddingX);
        make.right.mas_equalTo(self.contentView.mas_right).mas_offset(-paddingX);
//        if(_note.total <= 0)      make.bottom.mas_equalTo(self.contentView.mas_bottom);         //判断<=0只是为了容错性更高 并无他意  实际上 total不应该为负数
    }];
//    if(_note.total <= 0)     return;
    //更多回复Label
    [self.contentView addSubview:self.moreReplyLabel];
    [_moreReplyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_sharedWordsLabel.mas_bottom);
        make.height.mas_equalTo(24);
        make.left.mas_equalTo(self.contentView.mas_left).mas_offset(paddingX);
        make.right.mas_equalTo(self.contentView.mas_right).mas_offset(-paddingX);
        make.bottom.mas_equalTo(self.contentView.mas_bottom);
    }];
    
}


#pragma mark getter / setter

- (UIView *)lineView{
    if(!_lineView){
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = CXLineColor;
    }
    return _lineView;
}


- (UIView *)userInfoView{
    if(!_userInfoView){
        _userInfoView = [[UIView alloc] init];
        _userInfoView.backgroundColor = CXWhiteColor;
        _userInfoView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gotoUserInfo)];
        [_userInfoView addGestureRecognizer:tap];
        [_userInfoView addSubview:self.headBtn];
        [_userInfoView addSubview:self.nickNameLabel];
        [_userInfoView addSubview:self.dateLabel];
    }
    return _userInfoView;
}

- (UIButton *)headBtn{
    if(!_headBtn){
        _headBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _headBtn.frame = CGRectMake(0, 0, 36, 36);
          [_headBtn setImage:[[[UIImage imageNamed:@"avatar1.jpg"] imageByResizeToSize:CGSizeMake(36, 36) contentMode:UIViewContentModeScaleToFill] imageByRoundCornerRadius:18] forState:UIControlStateNormal];
        _headBtn.layer.cornerRadius = 18;
        _headBtn.clipsToBounds = YES;
        [_headBtn addTarget:self action:@selector(gotoUserInfo) forControlEvents:UIControlEventTouchUpInside];          //暂时取消头像按钮  击事件
    }
    return _headBtn;
}

- (UILabel *)nickNameLabel{
    if(!_nickNameLabel){
        _nickNameLabel = [[UILabel alloc] init];
        _nickNameLabel.font = CXSystemFont(13);
        _nickNameLabel.text = @"默认昵称";
        _nickNameLabel.textAlignment = NSTextAlignmentLeft;
        _nickNameLabel.textColor = CXBlackColor;
    }
    return _nickNameLabel;
}

- (UILabel *)dateLabel{
    if(!_dateLabel){
        _dateLabel = [[UILabel alloc] init];
        _dateLabel.font = CXSystemFont(11);
        _dateLabel.textColor = CXLightGrayColor;
        _dateLabel.textAlignment = NSTextAlignmentLeft;
        _dateLabel.text = @"20:00";
    }
    return _dateLabel;
}


- (UIImageView *)sharedImageView{
    if(!_sharedImageView){
        _sharedImageView = [[YYAnimatedImageView alloc] init];
    }
    return _sharedImageView;
}

- (CommentToolBarView *)toolBarView{
    if(!_toolBarView){
        _toolBarView = [[CommentToolBarView alloc] initWithFrame:CGRectMake(0, 0, CXScreenWidth, 45)];
    }
    return _toolBarView;
}

- (UIView *)likedInfoView{
    if(!_likedInfoView){
        _likedInfoView = [[UIView alloc] init];
        _likedInfoView.layer.masksToBounds = YES;
        [_likedInfoView addSubview:self.likedImgaeView];
        [_likedInfoView addSubview:self.likeNumLabel];
    }
    return _likedInfoView;
}

- (UIImageView *)likedImgaeView{
    if(!_likedImgaeView){
        _likedImgaeView = [[UIImageView alloc] init];
        _likedImgaeView.image = [UIImage imageNamed:@"like"];
    }
    return _likedImgaeView;
}

- (UILabel *)likeNumLabel{
    if(!_likeNumLabel){
        _likeNumLabel = [[UILabel alloc] init];
        _likeNumLabel.numberOfLines = 1;
        _likeNumLabel.text = @"100次赞";
        _likeNumLabel.font = CXSystemBoldFont(12);
        _likeNumLabel.textColor = CXBlackColor;
    }
    return _likeNumLabel;
}

- (YYLabel *)sharedWordsLabel{
    if(!_sharedWordsLabel){
        _sharedWordsLabel = [[YYLabel alloc] init];
        
        _words = [[NSMutableAttributedString alloc] initWithString:@"嘻嘻"];
        _words.yy_font = wordsFont;
        _sharedWordsLabel.userInteractionEnabled = YES;
        _sharedWordsLabel.numberOfLines = 0;
        _sharedWordsLabel.textVerticalAlignment = YYTextVerticalAlignmentTop;
        _sharedWordsLabel.attributedText = _words;
        _sharedWordsLabel.textColor = CXBlackColor;
//        _sharedWordsLabel.lineBreakMode = NSLineBreakByWordWrapping;
        
        [self addSeeMoreButton];

    }
    return _sharedWordsLabel;
}

- (UILabel *)moreReplyLabel{
    if(!_moreReplyLabel){
        _moreReplyLabel = [[UILabel alloc] init];
        _moreReplyLabel.text = @"";
        _moreReplyLabel.font = CXSystemFont(13);
        _moreReplyLabel.textColor = CXLightGrayColor;
        _moreReplyLabel.textAlignment = NSTextAlignmentLeft;
        _moreReplyLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
            _actionBlock(_note,CellActionTypeComment);
        }];
        [_moreReplyLabel addGestureRecognizer:tap];
    }
    return _moreReplyLabel;
}

//获取一行的高度
- (CGFloat)getLineHeight{
    static CGFloat lineHeight = 0;
    static dispatch_once_t once;
    //只执行一次
    dispatch_once(&once, ^{
        CGSize size  = [@"嘻嘻" sizeWithAttributes:@{NSFontAttributeName:wordsFont}];
        lineHeight = size.height;
    });
    return lineHeight;
}

- (void)autoShowOrHide{
    if(_note.likes <= 0 ){
        [_likedInfoView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0);
        }];
    }else{
        [_likedInfoView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(30);
        }];
    }
    
    if(_note.subject == nil || [_note.subject isEqualToString:@""]){
        [_sharedWordsLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0);
        }];
    }
    
    if(_note.total <= 0){
        [_moreReplyLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0);
        }];
    }else{
        [_moreReplyLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(24);
        }];
    }
    
}

- (void)autoWordsLabel{
    [_words replaceCharactersInRange:[_words.string rangeOfString:_words.string] withAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@: ",_note.user.nickName] attributes:@{NSFontAttributeName:boldWordsFont}]];
    
    [_words appendAttributedString:[[NSAttributedString alloc] initWithString:_note.subject attributes:@{NSFontAttributeName:wordsFont}]];
    
    
//    _words.yy_font = wordsFont;
    
    [_words yy_setTextHighlightRange:[_words.string rangeOfString:_note.user.nickName]
                               color:nil
                     backgroundColor:nil
                           tapAction:^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect){
                               [self gotoUserInfo];
                           }];
    
    [_words yy_setTextHighlightRange:[_words.string rangeOfString:_note.subject]
                             color:nil
                    backgroundColor:nil
                          tapAction:^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect){
                               if(_note.isOpend)    return;
                               _note.isOpend = YES;
                               [self autoSizeToFit];
                           }];
    
    [self autoSizeToFit];
    
    
}

- (void)autoSizeToFit{
    
    CGRect labelRect = [_words.string boundingRectWithSize:CGSizeMake(CXScreenWidth-2*paddingX, CGFLOAT_MAX) options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:wordsFont} context:nil] ;

    NSInteger height = (int)CGRectGetHeight(labelRect); 
    _sharedWordsLabel.attributedText = _words;
    
    if(_note.isOpend == YES){
        [_sharedWordsLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(height+1);
        }];
//        [self.contentView layoutIfNeeded];  
        return;
    }
    
    if(height < 3*[self getLineHeight]){
        [_sharedWordsLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(height+1);
        }];
        _note.isOpend = YES;
    }else{
        [_sharedWordsLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo((int)(3*[self getLineHeight])+1);
        }];
    }
}

#pragma mark private method

- (void)gotoUserInfo{
    if(_actionBlock)    _actionBlock(_note,CellActionTypeUserInfo);
}

- (void)addSeeMoreButton{
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:@"...更多"];
    
    YYTextHighlight *hi = [YYTextHighlight new];
    [hi setColor:[UIColor colorWithRed:0.578 green:0.790 blue:1.000 alpha:1.000]];
    @weakify(self);
    hi.tapAction = ^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect) {
        _note.isOpend = YES;
        [weak_self autoSizeToFit];
    };
    
    [text yy_setColor:CXLightGrayColor range:[text.string rangeOfString:@"更多"]];
    [text yy_setTextHighlight:hi range:[text.string rangeOfString:@"更多"]];
    text.yy_font = _sharedWordsLabel.font;
    
    YYLabel *seeMore = [YYLabel new];
    seeMore.attributedText = text;
    [seeMore sizeToFit];
    
    NSAttributedString *truncationToken = [NSAttributedString yy_attachmentStringWithContent:seeMore contentMode:UIViewContentModeCenter attachmentSize:seeMore.size alignToFont:text.yy_font alignment:YYTextVerticalAlignmentCenter];
    _sharedWordsLabel.truncationToken = truncationToken;
}


//注：UITableView重用机制会出问题  解决方案如下:http://www.jianshu.com/p/70d6200b097a
//注：感谢stackoverflowe的解决方案  http://stackoverflow.com/questions/31963753/how-to-set-constraint-in-a-reusable-uitableviewcell?answertab=votes#tab-top

- (void)updateUIWithModel:(CampusNote *)model hasLiked:(BOOL)liked action:(CellActionBlock)actiobBlock{
    _actionBlock = actiobBlock;
    _note = model;
    
    NSURL *url = [NSURL URLWithString:model.imageUrl];
    
    [_sharedImageView yy_setImageWithURL:url options:YYWebImageOptionProgressiveBlur
     |YYWebImageOptionSetImageWithFadeAnimation];                               //更新分享图片url
    
    _nickNameLabel.text = model.user.nickName;                                //更新昵称
    _dateLabel.text = [_note.create_at convertToLocalTime];
    _likeNumLabel.text = [NSString stringWithFormat:@"%ld次赞",_note.likes];
    _moreReplyLabel.text = [NSString stringWithFormat:@"所有%lu条评论",_note.total];
    [self autoShowOrHide];
    if(_note.subject != nil && [_note.subject isNotBlank])          [self autoWordsLabel];                  //更新帖子主题
    
    
    CGFloat height = model.height;
    CGFloat width = model.width;
//    CXLog(@"高度为：%d",(int)(CXScreenWidth * height/width));
    
    [_sharedImageView mas_updateConstraints:^(MASConstraintMaker *make) {
          make.height.mas_equalTo(CXScreenWidth * height/width).priority(750);
    }];
    
    [self.toolBarView updateUIByStatus:liked action:^(CommentToolBarView *view, ToolBarActionType actionType) {
        switch (actionType) {
            case ToolBarClickTypeLike:{
                _actionBlock(model,CellActionTypeLike);
                break;
            }
            case ToolBarClickTypeReply:
                _actionBlock(model,CellActionTypeReply);
                break;
            case ToolBarClickTypeShare:
                 _actionBlock(model,CellActionTypeShare);
                break;
            case ToolBarClickTypeMore:
                _actionBlock(model,CellActionTypeMore);
                break;
            default:
                break;
        }
    }];
}


@end
