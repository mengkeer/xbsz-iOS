//
//  AboutViewController.m
//  xbsz
//
//  Created by lotus on 2017/5/14.
//  Copyright © 2017年 lotus. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()

@property (nonatomic, strong) UIImageView *iconImageView;

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *versionLabel;

@property (nonatomic, strong) UILabel *authorLabel;
@property (nonatomic, strong) UILabel *contactLabel;

@property (nonatomic, strong) UILabel *copyrightLabel;

@end

@implementation AboutViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self showTopLineView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"软件相关";
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.showsVerticalScrollIndicator  = YES;
    scrollView.alwaysBounceVertical = YES;
    scrollView.backgroundColor = CXBackGroundColor;
    scrollView.contentSize = CGSizeMake(CXScreenWidth, CXScreenHeight-64);
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, CXScreenWidth, CXScreenHeight-64) byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(CXTopCornerRadius, CXTopCornerRadius)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = CGRectMake(0, 0, CXScreenWidth, CXScreenHeight-64);
    maskLayer.path = maskPath.CGPath;
    scrollView.layer.mask = maskLayer;
    
    
    [self.contentView addSubview:scrollView];
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_equalTo(self.contentView);
        make.top.mas_equalTo(self.customNavBarView.mas_bottom);
    }];
    
    UIView *bgView = [[UIView alloc] init];
    bgView.backgroundColor = CXWhiteColor;
    [scrollView addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(scrollView.mas_top);
        make.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(CXScreenHeight-64);
    }];
    
    
    [scrollView addSubview:self.iconImageView];
    [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(scrollView.mas_top).mas_offset(72);
        make.width.height.mas_equalTo(100);
        make.centerX.mas_equalTo(self.view.mas_centerX);
    }];
    
    [scrollView addSubview:self.nameLabel];
    [scrollView addSubview:self.versionLabel];
    [scrollView addSubview:self.authorLabel];
    [scrollView addSubview:self.contactLabel];
    [scrollView addSubview:self.copyrightLabel];

    
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.width.mas_equalTo(CXScreenWidth/2);
        make.height.mas_equalTo(30);
        make.top.mas_equalTo(_iconImageView.mas_bottom).mas_offset(12);
    }];
    
    [_versionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.width.mas_equalTo(CXScreenWidth/2);
        make.height.mas_equalTo(15);
        make.top.mas_equalTo(_nameLabel.mas_bottom).mas_offset(12);
    }];
    
    [_authorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.left.mas_equalTo(self.view.mas_left).mas_offset(30);
        make.right.mas_equalTo(self.view.mas_right).mas_offset(-30);
        make.height.mas_equalTo(15);
        make.top.mas_equalTo(_versionLabel.mas_bottom).mas_offset(20);
    }];
    
    [_contactLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.left.mas_equalTo(self.view.mas_left).mas_offset(30);
        make.right.mas_equalTo(self.view.mas_right).mas_offset(-30);
        make.height.mas_equalTo(15);
        make.top.mas_equalTo(_authorLabel.mas_bottom).mas_offset(12);
    }];
    
    [scrollView layoutIfNeeded];
    
    [_copyrightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(scrollView.mas_centerX);
        make.left.mas_equalTo(scrollView.mas_left).mas_offset(20);
        make.right.mas_equalTo(scrollView.mas_right).mas_offset(-20);
        make.height.mas_equalTo(15);
        make.bottom.mas_equalTo(bgView.mas_bottom).mas_offset(-20);
    }];
       
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - getter/setter

- (UIImageView *)iconImageView{
    if(!_iconImageView){
        NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
        //获取app中所有icon名字数组
        NSArray *iconsArr = infoDict[@"CFBundleIcons"][@"CFBundlePrimaryIcon"][@"CFBundleIconFiles"];
        NSString *iconLastName = [iconsArr lastObject];
        
        _iconImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:iconLastName]];
        _iconImageView.contentMode = UIViewContentModeScaleToFill;
    }
    return _iconImageView;
}

- (UILabel *)nameLabel{
    if(!_nameLabel){
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = CXSystemFont(22);
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.textColor = CXBlackColor2;
        _nameLabel.text = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"];
    }
    return _nameLabel;
}

- (UILabel *)versionLabel{
    if(!_versionLabel){
        _versionLabel = [[UILabel alloc] init];
        _versionLabel.font = CXSystemFont(12);
        _versionLabel.textAlignment = NSTextAlignmentCenter;
        _versionLabel.textColor = CXBlackColor2;
        _versionLabel.text = [NSString stringWithFormat:@"版本 V%@",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
    }
    return _versionLabel;
}

- (UILabel *)authorLabel{
    if(!_authorLabel){
        _authorLabel = [[UILabel alloc] init];
        _authorLabel.font = CXSystemFont(13);
        _authorLabel.textAlignment = NSTextAlignmentCenter;
        _authorLabel.textColor = CXBlackColor2;
        _authorLabel.text = @"by 东华大学信安1301班·么么哒";
    }
    return _authorLabel;
}

- (UILabel *)contactLabel{
    if(!_contactLabel){
        _contactLabel = [[UILabel alloc] init];
        _contactLabel.font = CXSystemFont(13);
        _contactLabel.textAlignment = NSTextAlignmentCenter;
        _contactLabel.textColor = CXBlackColor2;
        _contactLabel.text = @"联系方式:1812422367@qq.com";
    }
    return _contactLabel;
}

- (UILabel *)copyrightLabel{
    if(!_copyrightLabel){
        _copyrightLabel = [[UILabel alloc] init];
        _copyrightLabel.font = CXSystemFont(13);
        _copyrightLabel.textAlignment = NSTextAlignmentCenter;
        _copyrightLabel.textColor = CXBlackColor2;
        _copyrightLabel.text = @"copyright © 2017年 lotus. All rights reserved";
    }
    return _copyrightLabel;
}


@end
