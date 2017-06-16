//
//  UpdateInfoViewController.m
//  xbsz
//
//  Created by lotus on 2017/5/14.
//  Copyright © 2017年 lotus. All rights reserved.
//

#import "UpdateInfoViewController.h"

@interface UpdateInfoViewController ()

@property (nonatomic, strong) UILabel *explainLabel;

@property (nonatomic, strong) UILabel *copyrightLabel;


@end

@implementation UpdateInfoViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self showTopLineView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"更新说明";
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.backgroundColor = CXWhiteColor;
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
        make.left.bottom.right.mas_equalTo(self.view);
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
    
    
    
    [scrollView addSubview:self.explainLabel];
    [scrollView addSubview:self.copyrightLabel];

    
    
    [_explainLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).mas_offset(20);
        make.right.mas_equalTo(self.view.mas_right).mas_offset(-20);
        make.top.mas_equalTo(scrollView.mas_top).mas_offset(30);
        make.bottom.mas_equalTo(scrollView.mas_bottom).mas_offset(30);
    }];
    
    [_copyrightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.left.mas_equalTo(self.view.mas_left).mas_offset(20);
        make.right.mas_equalTo(self.view.mas_right).mas_offset(-20);
        make.height.mas_equalTo(15);
        make.bottom.mas_equalTo(bgView.mas_bottom).mas_offset(-20);
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - getter/setter


- (UILabel *)explainLabel{
    if(!_explainLabel){
        _explainLabel = [[UILabel alloc] init];
        _explainLabel.font = CXSystemFont(17);
        _explainLabel.textAlignment = NSTextAlignmentCenter;
        _explainLabel.textColor = CXBlackColor2;
        _explainLabel.numberOfLines = 0;
        NSString *text = @"更新时间:2017-06-10\n\n1.更新题库为2017上学期思政题库\n2.修复若干bug\n3.如果有建议或建议，请发送邮件至1812422367@qq.com";
        
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:5];
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [text length])];
        _explainLabel.attributedText = attributedString;
        [_explainLabel sizeToFit];
    }
    return _explainLabel;
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
