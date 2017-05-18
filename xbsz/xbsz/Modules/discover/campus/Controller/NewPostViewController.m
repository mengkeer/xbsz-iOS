//
//  NewPostViewController.m
//  xbsz
//
//  Created by lotus on 2017/5/15.
//  Copyright © 2017年 lotus. All rights reserved.
//

#import "NewPostViewController.h"
#import "CXAudioPlayer.h"
#import "IQKeyboardManager.h"
#import "TZImagePickerController.h"
#import "CXNetwork+Note.h"

@interface NewPostViewController () <UITextViewDelegate,TZImagePickerControllerDelegate>

@property (nonatomic, strong) UIView *topView;      //阴影区域
@property (nonatomic, strong) UIView *contentView;      //主要内容区域

@property (nonatomic, strong) UIButton *cancelBtn;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *sendBtn;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UITextView *subjectTextView;
@property (nonatomic, strong) UILabel *placeholderLabel;

@property (nonatomic, strong) YYAnimatedImageView *sharedImageView;

@property (nonatomic, strong) UISwitch *uploadSwitch;

@property (nonatomic, assign) BOOL uploadBigIamge;

@end

@implementation NewPostViewController

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [IQKeyboardManager sharedManager].enable = YES;
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    
    _uploadBigIamge = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
  
    _topView = [UIView new];
    _topView.backgroundColor = CXBlackColor;
    _topView.alpha = 0.5;
    [self.view addSubview:_topView];
    [_topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(20+6);
    }];
    
    
    _contentView = [UIView new];
    _contentView.backgroundColor = CXWhiteColor;
    [self.view addSubview:_contentView];
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(_topView.mas_bottom).mas_offset(-6);
    }];

    [_contentView layoutIfNeeded];

    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, CXScreenWidth, _contentView.height) byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(6, 6)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = CGRectMake(0, 0, CXScreenWidth, _contentView.height);
    maskLayer.path = maskPath.CGPath;
    _contentView.layer.mask = maskLayer;
    
    
    UIView *lineView = [UIView new];
    lineView.backgroundColor = CXHexColor(0xe8e8e8);
    [_contentView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(_contentView);
        make.bottom.mas_equalTo(_contentView.mas_top).mas_offset(44);
        make.height.mas_equalTo(1/CXMainScale);
    }];
    
    [_contentView addSubview:self.cancelBtn];
    [_contentView addSubview:self.titleLabel];
    [_contentView addSubview:self.sendBtn];
    
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(75);
        make.height.mas_equalTo(24);
        make.centerX.mas_equalTo(_contentView.mas_centerX);
        make.top.mas_equalTo(_contentView.mas_top).mas_offset(10);
    }];
    
    [_cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(44);
        make.left.mas_equalTo(_contentView.mas_left).mas_offset(5);
        make.top.mas_equalTo(_contentView.mas_top);
    }];
    
    [_sendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(44);
        make.right.mas_equalTo(_contentView.mas_right).mas_offset(-5);
        make.top.mas_equalTo(_contentView.mas_top);
    }];
    
    _scrollView = [UIScrollView new];
    _scrollView.showsVerticalScrollIndicator  = YES;
    _scrollView.alwaysBounceVertical = YES;
    _scrollView.backgroundColor = CXHexColor(0xfafafa);
    _scrollView.contentSize = CGSizeMake(CXScreenWidth, CXScreenHeight-64);
    [_contentView addSubview:_scrollView];
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(_contentView);
        make.top.mas_equalTo(_contentView.mas_top).mas_offset(44);
    }];
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CXScreenWidth, 15+110+20+110+15)];
    bgView.backgroundColor = CXWhiteColor;
    [_scrollView addSubview:bgView];
    
    
    [_scrollView addSubview:self.subjectTextView];
    [_scrollView addSubview:self.sharedImageView];
    
    [_sharedImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_subjectTextView.mas_bottom).mas_offset(20);
        make.left.mas_equalTo(_scrollView.mas_left).mas_offset(15);
        make.height.width.mas_equalTo(110);
    }];
    
    
    UIView *itemView = [[UIView alloc] init];
    itemView.backgroundColor = CXWhiteColor;
    [_scrollView addSubview:itemView];
    [itemView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(bgView.mas_bottom).mas_offset(20);
        make.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(45);
    }];
    
    
    UILabel *uploadLabel = [[UILabel alloc] init];
    uploadLabel.textAlignment = NSTextAlignmentLeft;
    uploadLabel.text = @"上传高清图片";
    uploadLabel.textColor = CXBlackColor2;
    uploadLabel.font = CXSystemFont(16);
    [itemView addSubview:uploadLabel];
    [uploadLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(itemView.mas_left).mas_offset(15);
        make.height.mas_equalTo(24);
        make.centerY.mas_equalTo(itemView.mas_centerY);
        make.width.mas_equalTo(100);
    }];
    
    _uploadSwitch = [[UISwitch alloc] init];
    _uploadSwitch.onTintColor = CXGreenColor;
    [_uploadSwitch addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventTouchUpInside];
    [itemView addSubview:_uploadSwitch];
    [_uploadSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(itemView.mas_right).mas_offset(-15);
        make.height.mas_offset(30);
        make.centerY.mas_equalTo(itemView.mas_centerY);
    }];
 
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - getter/setter

- (UILabel *)titleLabel{
    if(!_titleLabel){
        _titleLabel = [UILabel new];
        _titleLabel.textColor = CXBlackColor2;
        _titleLabel.font = CXSystemFont(16);
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.text = @"新的帖子";
    }
    return _titleLabel;
}

- (UIButton *)cancelBtn{
    if(!_cancelBtn){
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelBtn setImage:[UIImage imageNamed:@"common_close"] forState:UIControlStateNormal];
        _cancelBtn.imageEdgeInsets = UIEdgeInsetsMake(8, 8, 8, 8);
        [_cancelBtn addTarget:self action:@selector(clickCancel) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}

- (UIButton *)sendBtn{
    if(!_sendBtn){
        _sendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sendBtn setImage:[UIImage imageNamed:@"comment_send"] forState:UIControlStateNormal];
        _sendBtn.imageEdgeInsets = UIEdgeInsetsMake(8, 8, 8, 8);
        [_sendBtn addTarget:self action:@selector(clickSend) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sendBtn;
}


- (UITextView *)subjectTextView{
    if (!_subjectTextView) {
        _subjectTextView = [[UITextView alloc] initWithFrame:CGRectMake(15, 15, CXScreenWidth-30, 110)];
        _subjectTextView.backgroundColor = CXWhiteColor;
        _subjectTextView.font = [UIFont systemFontOfSize:15];
        _subjectTextView.textColor = CXBlackColor2;
        _subjectTextView.text = @"";
//        _subjectTextView.returnKeyType = UIReturnKeyNext;
        _subjectTextView.delegate = self;
        _subjectTextView.inputAccessoryView = [[UIView alloc] init];
        [_subjectTextView addSubview:self.placeholderLabel];
    }
    return _subjectTextView;
}

- (YYAnimatedImageView *)sharedImageView{
    if(!_sharedImageView){
        _sharedImageView = [[YYAnimatedImageView alloc] init];
        _sharedImageView.image = _sharedImage;
        _sharedImageView.contentMode = UIViewContentModeScaleToFill;
        _sharedImageView.userInteractionEnabled = YES;
        @weakify(self);
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
            [weak_self changeImage];
        }];
        [_sharedImageView addGestureRecognizer:tap];
    }
    return _sharedImageView;
}


- (UILabel *)placeholderLabel{
    if(!_placeholderLabel){
        _placeholderLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 7, 150, CXSystemFont(15).lineHeight)];
        _placeholderLabel.textColor = CXHexColor(0x707070);
        _placeholderLabel.font = CXSystemFont(15);
        _placeholderLabel.textAlignment = NSTextAlignmentLeft;
        _placeholderLabel.text = @"这一刻的想法...";
    }
    return _placeholderLabel;
}

#pragma mark -- UITextViewDelegate

- (void)textViewDidChange:(UITextView *)textView{
    if ([textView.text length] > 0) {
        _placeholderLabel.hidden = YES;
    }else{
        _placeholderLabel.hidden = NO;
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    return YES;
}


#pragma mark - 处理事件

- (void)clickCancel{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)clickSend{
    if(![[CXLocalUser instance] isLogin]){
        [ToastView showStatus:@"请先登录"];
    }else{
        [CXNetwork publishNote:_sharedImage isBig:_uploadSwitch.isOn subject:[_subjectTextView.text stringByTrim] location:@"东华大学图书馆"
            success:^(NSObject *obj) {
                [ToastView showBlackSuccessWithStaus:@"发送成功"];
                [CXAudioPlayer playSent];
                [[NSNotificationCenter defaultCenter] postNotificationName:NotificationCampusNotePublished object:nil];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self dismissViewControllerAnimated:YES completion:nil];
                });
        } failure:^(NSError *error) {
            [ToastView showBlackSuccessWithStaus:@"发送失败"];
        }];
    }
}

- (void)switchChanged:(UISwitch *)switched{
    if(switched.on){
        _uploadBigIamge = YES;
    }else{
        _uploadBigIamge = NO;
    }
}

- (void)changeImage{
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:self];
    imagePickerVc.allowCrop = YES;
    imagePickerVc.photoWidth = 750;
    imagePickerVc.allowPickingGif = YES;
    imagePickerVc.allowPickingOriginalPhoto = YES;
    
    NSInteger themeType = [CXUserDefaults instance].themeType;
    if(themeType != 2){
        imagePickerVc.navigationBar.barTintColor = [CXUserDefaults instance].mainColor;
    }
    
    imagePickerVc.cropRect = CGRectMake(0 , (CXScreenHeight- CXScreenWidth)/2, CXScreenWidth, CXScreenWidth);
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}

- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto{
    _sharedImage = photos[0];
    
    CATransition *anim = [CATransition animation];
    anim.type = @"rippleEffect";
    anim.duration = 1.0f;
    [_sharedImageView.layer addAnimation:anim forKey:nil];

    _sharedImageView.image = _sharedImage;
}

- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingGifImage:(UIImage *)animatedImage sourceAssets:(id)asset{
    _sharedImage = animatedImage;
    
    CATransition *anim = [CATransition animation];
    anim.type = @"rippleEffect";
    anim.duration = 1.0f;
    [_sharedImageView.layer addAnimation:anim forKey:nil];
    
    _sharedImageView.image = _sharedImage;
}

@end
