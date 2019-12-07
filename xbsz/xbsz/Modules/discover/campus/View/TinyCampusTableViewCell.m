////
////  TinyCampusTableViewCell.m
////  xbsz
////
////  Created by lotus on 2017/12/27.
////  Copyright © 2017年 lotus. All rights reserved.
////
//
//#import "TinyCampusTableViewCell.h"
//#import "CampusTableViewCell.h"
//#import <YYImage/YYAnimatedImageView.h>
//#import <YYText/YYText.h>
//
//
//#define  paddingX   (10)
//#define  wordsFont   CXSystemFont(12)
//#define  boldWordsFont  CXSystemBoldFont(12)
//
//@interface TinyCampusTableViewCell ()
//
////用户信息View  包含头像 昵称  地点等
//@property (nonatomic, strong) UIView *userInfoView;
//@property (nonatomic, strong) UIButton *avatarBtn;
//@property (nonatomic, strong) UILabel *nickNameLabel;
//@property (nonatomic, strong) UILabel *dateLabel;       //发布日期
//
//@property (nonatomic, strong) UILabel *contentLabel;        //没有图片时用户的留言
//
//@property (nonatomic, strong) YYLabel *subjectLabel;          //用户分享时的留言
//@property (nonatomic, strong) NSMutableAttributedString *words;
//
//@property (nonatomic, strong) UILabel *moreReplyLabel;          //更多回复提示
//
//@property (nonatomic, strong) UIView *lineView;     //工具栏下的分割线
//
//
//@property (nonatomic, copy) TinyCellActionBlock actionBlock;
//
//
//@end
//
//@implementation TinyCampusTableViewCell
//
//- (void)awakeFromNib {
//    [super awakeFromNib];
//}
//
//- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
//    //    self.contentView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
//    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
//    if(self){
//        self.selectionStyle = UITableViewCellSelectionStyleNone;
//        [self initTableViewCell];
//    }
//    return self;
//}
//
//- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//    [super setSelected:selected animated:animated];
//}
//
//#pragma mark private method
//
//- (void)initTableViewCell{
//    
//    [self.contentView addSubview:self.userInfoView];
//    [_userInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.width.mas_equalTo(self.contentView);
//        make.height.mas_equalTo(50);
//        make.left.top.right.mas_equalTo(self.contentView);
//    }];
//    
//    [_avatarBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(self.contentView).mas_offset(8);
//        make.centerY.mas_equalTo(_userInfoView.mas_centerY);
//        make.width.height.mas_equalTo(36);
//    }];
//    
//    [_nickNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(_avatarBtn.mas_right).mas_offset(15);
//        make.centerY.mas_equalTo(_userInfoView.mas_centerY).mas_offset(-8);
//    }];
//    
//    [_dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(_avatarBtn.mas_right).mas_offset(15);
//        make.centerY.mas_equalTo(_userInfoView.mas_centerY).mas_offset(8);
//    }];
//    
//    [self.contentView addSubview:self.sharedImageView];
//    [_sharedImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(_userInfoView.mas_bottom);
//        make.left.right.mas_equalTo(self.contentView);
//    }];
//    
//    [self.contentView addSubview:self.toolBarView];
//    [_toolBarView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.mas_equalTo(self.contentView);
//        make.top.mas_equalTo(_sharedImageView.mas_bottom);
//        make.height.mas_equalTo(45);
//    }];
//    
//    [self.contentView addSubview:self.lineView];
//    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(_toolBarView.mas_bottom);
//        make.left.mas_equalTo(self.contentView).mas_offset(paddingX);
//        make.right.mas_equalTo(self.contentView).mas_offset(-paddingX);
//        make.height.mas_equalTo(1/CXMainScale);
//    }];
//    
//    //添加用户发表图片时的留言
//    [self.contentView addSubview:self.subjectLabel];
//    [_subjectLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(_lineView.mas_bottom).mas_offset(6);
//        make.left.mas_equalTo(self.contentView.mas_left).mas_offset(paddingX);
//        make.right.mas_equalTo(self.contentView.mas_right).mas_offset(-paddingX);
//        //        if(_note.total <= 0)      make.bottom.mas_equalTo(self.contentView.mas_bottom);         //判断<=0只是为了容错性更高 并无他意  实际上 total不应该为负数
//    }];
//    
//    [self.contentView addSubview:self.moreReplyLabel];
//    [_moreReplyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(_subjectLabel.mas_bottom);
//        make.height.mas_equalTo(24);
//        make.left.mas_equalTo(self.contentView.mas_left).mas_offset(paddingX);
//        make.right.mas_equalTo(self.contentView.mas_right).mas_offset(-paddingX);
//        make.bottom.mas_equalTo(self.contentView.mas_bottom);
//    }];
//    
//}
//
//
//#pragma mark getter / setter
//
//- (UIView *)lineView{
//    if(!_lineView){
//        _lineView = [[UIView alloc] init];
//        _lineView.backgroundColor = CXLineColor;
//    }
//    return _lineView;
//}
//
//
//- (UIView *)userInfoView{
//    if(!_userInfoView){
//        _userInfoView = [[UIView alloc] init];
//        _userInfoView.backgroundColor = CXWhiteColor;
//        _userInfoView.userInteractionEnabled = YES;
//        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gotoUserInfo)];
//        [_userInfoView addGestureRecognizer:tap];
//        [_userInfoView addSubview:self.avatarBtn];
//        [_userInfoView addSubview:self.nickNameLabel];
//        [_userInfoView addSubview:self.dateLabel];
//    }
//    return _userInfoView;
//}
//
//- (UIButton *)avatarBtn{
//    if(!_avatarBtn){
//        _avatarBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        _avatarBtn.frame = CGRectMake(0, 0, 36, 36);
//        [_avatarBtn setImage:[UIImage imageNamed:@"defaultUserPhoto"] forState:UIControlStateNormal];
//        _avatarBtn.layer.cornerRadius = 18;
//        _avatarBtn.clipsToBounds = YES;
//        [_avatarBtn addTarget:self action:@selector(gotoUserInfo) forControlEvents:UIControlEventTouchUpInside];          //暂时取消头像按钮  击事件
//    }
//    return _avatarBtn;
//}
//
//- (UILabel *)nickNameLabel{
//    if(!_nickNameLabel){
//        _nickNameLabel = [[UILabel alloc] init];
//        _nickNameLabel.font = CXSystemFont(13);
//        _nickNameLabel.text = @"默认昵称";
//        _nickNameLabel.textAlignment = NSTextAlignmentLeft;
//        _nickNameLabel.textColor = CXBlackColor;
//    }
//    return _nickNameLabel;
//}
//
//- (UILabel *)dateLabel{
//    if(!_dateLabel){
//        _dateLabel = [[UILabel alloc] init];
//        _dateLabel.font = CXSystemFont(12);
//        _dateLabel.textColor = CXLightGrayColor;
//        _dateLabel.textAlignment = NSTextAlignmentLeft;
//        _dateLabel.text = @"20:00";
//    }
//    return _dateLabel;
//}
//
//
//- (YYAnimatedImageView *)sharedImageView{
//    if(!_sharedImageView){
//        _sharedImageView = [[YYAnimatedImageView alloc] init];
//        _sharedImageView.userInteractionEnabled = YES;
//        _sharedImageView.contentMode = UIViewContentModeScaleAspectFill;
//        _sharedImageView.clipsToBounds = YES;
//        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
//            _actionBlock(self,_note,TinyCommentCellActionTypeSourceImage);
//        }];
//        [_sharedImageView addGestureRecognizer:tap];
//    }
//    return _sharedImageView;
//}
//
//- (CommentToolBarView *)toolBarView{
//    if(!_toolBarView){
//        _toolBarView = [[CommentToolBarView alloc] initWithFrame:CGRectMake(0, 0, CXScreenWidth, 45)];
//        _toolBarView.backgroundColor = CXWhiteColor;
//        [_toolBarView updateUIByAction:^(CommentToolBarView *view, ToolBarActionType actionType) {
//            switch (actionType) {
//                case ToolBarClickTypeReply:
//                    _actionBlock(self,_note,TinyCommentCellActionTypeReply);
//                    break;
//                case ToolBarClickTypeMore:
//                    _actionBlock(self,_note,TinyCommentCellActionTypeMore);
//                    break;
//                default:
//                    break;
//            }
//        }];
//    }
//    return _toolBarView;
//}
//
//- (YYLabel *)subjectLabel{
//    if(!_subjectLabel){
//        _subjectLabel = [[YYLabel alloc] init];
//        
//        _words = [[NSMutableAttributedString alloc] initWithString:@"嘻嘻"];
//        _words.yy_font = wordsFont;
//        _subjectLabel.userInteractionEnabled = YES;
//        _subjectLabel.numberOfLines = 0;
//        _subjectLabel.textVerticalAlignment = YYTextVerticalAlignmentTop;
//        _subjectLabel.attributedText = _words;
//        //        _subjectLabel.lineBreakMode = NSLineBreakByWordWrapping;
//        
//        [self addSeeMoreButton];
//        
//    }
//    return _subjectLabel;
//}
//
//- (UILabel *)moreReplyLabel{
//    if(!_moreReplyLabel){
//        _moreReplyLabel = [[UILabel alloc] init];
//        _moreReplyLabel.text = @"";
//        _moreReplyLabel.font = CXSystemFont(13);
//        _moreReplyLabel.textColor = CXLightGrayColor;
//        _moreReplyLabel.textAlignment = NSTextAlignmentLeft;
//        _moreReplyLabel.userInteractionEnabled = YES;
//        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
//            _actionBlock(self,_note,TinyCommentCellActionTypeComment);
//        }];
//        [_moreReplyLabel addGestureRecognizer:tap];
//    }
//    return _moreReplyLabel;
//}
//
////获取一行的高度
//- (CGFloat)getLineHeight{
//    static CGFloat lineHeight = 0;
//    static dispatch_once_t once;
//    //只执行一次
//    dispatch_once(&once, ^{
//        CGSize size  = [@"嘻嘻" sizeWithAttributes:@{NSFontAttributeName:wordsFont}];
//        lineHeight = size.height;
//    });
//    return lineHeight;
//}
//
//- (void)initConstraint{
//    
//    if(_note.subject == nil || [_note.subject isEqualToString:@""]){
//        [_subjectLabel mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.height.mas_equalTo(0);
//        }];
//    }
//    
//    if(_note.total <= 0){
//        [_moreReplyLabel mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.height.mas_equalTo(0);
//        }];
//    }else{
//        [_moreReplyLabel mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.height.mas_equalTo(24);
//        }];
//    }
//    
//}
//
//- (void)autoWordsLabel{
//    [_words replaceCharactersInRange:[_words.string rangeOfString:_words.string] withAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@: ",_note.user.nickname] attributes:@{NSFontAttributeName:boldWordsFont}]];
//    
//    [_words appendAttributedString:[[NSAttributedString alloc] initWithString:_note.subject attributes:@{NSFontAttributeName:wordsFont}]];
//    
//    
//    [_words yy_setTextHighlightRange:[_words.string rangeOfString:_note.user.nickname]
//                               color:nil
//                     backgroundColor:nil
//                           tapAction:^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect){
//                               [self gotoUserInfo];
//                           }];
//    
//    [_words yy_setTextHighlightRange:[_words.string rangeOfString:_note.subject]
//                               color:nil
//                     backgroundColor:nil
//                           tapAction:^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect){
//                               if(_note.isOpend)    return;
//                               _note.isOpend = YES;
//                               [self autoSizeToFit];
//                           }];
//    
//    [self autoSizeToFit];
//    
//    
//}
//
//- (void)autoSizeToFit{
//    
//    CGRect labelRect = [_words.string boundingRectWithSize:CGSizeMake(CXScreenWidth-2*paddingX, CGFLOAT_MAX) options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:wordsFont} context:nil] ;
//    
//    NSInteger height = (int)CGRectGetHeight(labelRect);
//    _subjectLabel.attributedText = _words;
//    
//    if(_note.isOpend == YES){
//        [_subjectLabel mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.height.mas_equalTo(height+1);
//        }];
//        return;
//    }
//    
//    if(height < 2*[self getLineHeight]){
//        [_subjectLabel mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.height.mas_equalTo(height+1);
//        }];
//        _note.isOpend = YES;
//    }else{
//        [_subjectLabel mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.height.mas_equalTo((int)(2*[self getLineHeight])+1);
//        }];
//    }
//}
//
//#pragma mark private method
//
//- (void)gotoUserInfo{
//    if(_actionBlock)    _actionBlock(self,_note,TinyCommentCellActionTypeUserInfo);
//}
//
//- (void)addSeeMoreButton{
//    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:@"...更多"];
//    
//    YYTextHighlight *hi = [YYTextHighlight new];
//    [hi setColor:[UIColor colorWithRed:0.578 green:0.790 blue:1.000 alpha:1.000]];
//    @weakify(self);
//    hi.tapAction = ^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect) {
//        _note.isOpend = YES;
//        [weak_self autoSizeToFit];
//    };
//    
//    [text yy_setColor:CXHexColor(0x2492fc) range:[text.string rangeOfString:@"更多"]];
//    [text yy_setTextHighlight:hi range:[text.string rangeOfString:@"更多"]];
//    text.yy_font = _subjectLabel.font;
//    
//    YYLabel *seeMore = [YYLabel new];
//    seeMore.attributedText = text;
//    [seeMore sizeToFit];
//    
//    NSAttributedString *truncationToken = [NSAttributedString yy_attachmentStringWithContent:seeMore contentMode:UIViewContentModeCenter attachmentSize:seeMore.size alignToFont:text.yy_font alignment:YYTextVerticalAlignmentCenter];
//    _subjectLabel.truncationToken = truncationToken;
//}
//
//
////注：UITableView重用机制会出问题  解决方案如下:http://www.jianshu.com/p/70d6200b097a
////注：感谢stackoverflowe的解决方案  http://stackoverflow.com/questions/31963753/how-to-set-constraint-in-a-reusable-uitableviewcell?answertab=votes#tab-top
//
//- (void)updateUIWithModel:(CampusNote *)model action:(TinyCellActionBlock)actiobBlock{
//    model.subject = @"作者的话:应大家的要求下一版本去除广告，但是会保留开启关闭广告的按钮，如果这个软件帮助了大家的话，希望大家偶尔主动开启广告帮我多作者的话:应大家的要求下一版本去除广告，但是会保留开启关闭广告的按钮，如果这个软件帮助了大家的话，希望大家偶尔主动开启广告帮我多";
//    _actionBlock = actiobBlock;
//    _note = model;
//    
//    NSURL *url = [NSURL URLWithString:CXNoteImageUrlByname(model.img)];
//    [_avatarBtn yy_setImageWithURL:[NSURL URLWithString:[NSString getAvatarUrl:model.user.avatar]] forState:UIControlStateNormal options:YYWebImageOptionSetImageWithFadeAnimation];
//    _nickNameLabel.text = model.user.nickname;                                //更新昵称
//    _dateLabel.text = [_note.time convertToLocalTime];
//    
//    if(model.img && [model.img isNotBlank]){
//        _sharedImageView.hidden = NO;
//        _moreReplyLabel.hidden = NO;
//        
//        [_sharedImageView yy_setImageWithURL:url options:YYWebImageOptionProgressiveBlur
//         |YYWebImageOptionSetImageWithFadeAnimation];                               //更新分享图片url
//        _moreReplyLabel.text = [NSString stringWithFormat:@"所有%lu条评论",_note.total];
//        
//        [self initConstraint];                          //根据是否有主题 与是否有评论自动隐藏与显示
//        if(_note.subject != nil && [_note.subject isNotBlank])          [self autoWordsLabel];                  //更新帖子主题
//        
//        NSInteger imageWidth = model.width;
//        NSInteger imageHeight = model.height;
//        [_sharedImageView mas_updateConstraints:^(MASConstraintMaker *make) {
//            if(imageWidth > imageHeight){
//                make.height.mas_equalTo(CXScreenWidth * imageHeight/imageWidth).priority(750);
//            }else{
//                make.height.mas_equalTo(CXScreenWidth).priority(750);
//            }
//        }];
//        [_toolBarView mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.left.right.mas_equalTo(self.contentView);
//            make.top.mas_equalTo(_sharedImageView.mas_bottom);
//            make.height.mas_equalTo(45);
//        }];
//        [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(_toolBarView.mas_bottom);
//            make.left.mas_equalTo(self.contentView).mas_offset(paddingX);
//            make.right.mas_equalTo(self.contentView).mas_offset(-paddingX);
//            make.height.mas_equalTo(1/CXMainScale);
//        }];
//    }else{
//        _sharedImageView.hidden = YES;
//        _moreReplyLabel.hidden = YES;
//        
//        [_subjectLabel mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(_userInfoView.mas_bottom).mas_offset(6);
//            make.left.mas_equalTo(self.contentView.mas_left).mas_offset(paddingX);
//            make.right.mas_equalTo(self.contentView.mas_right).mas_offset(-paddingX);
//        }];
//        [self initConstraint];
//        if(_note.subject != nil && [_note.subject isNotBlank])          [self autoWordsLabel];                  //更新帖子主题
//        [_toolBarView mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.left.right.mas_equalTo(self.contentView);
//            make.top.mas_equalTo(_subjectLabel.mas_bottom);
//            make.height.mas_equalTo(45);
//        }];
//        [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(_toolBarView.mas_bottom);
//            make.left.mas_equalTo(self.contentView).mas_offset(paddingX);
//            make.right.mas_equalTo(self.contentView).mas_offset(-paddingX);
//            make.height.mas_equalTo(1/CXMainScale);
//            make.bottom.mas_equalTo(self.contentView.mas_bottom);
//        }];
//    }
//
//}
//
//- (void)registerTouch:(id)delegate{
//    [delegate registerForPreviewingWithDelegate:delegate sourceView:_sharedImageView];
//}
//
//
//@end
//
