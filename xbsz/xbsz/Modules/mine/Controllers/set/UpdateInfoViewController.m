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

@end

@implementation UpdateInfoViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self autoTheme];
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
    
    [self.view addSubview:scrollView];
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

    
    
    [_explainLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).mas_offset(20);
        make.right.mas_equalTo(self.view.mas_right).mas_offset(-20);
        make.top.mas_equalTo(scrollView.mas_top).mas_offset(30);
        make.bottom.mas_equalTo(scrollView.mas_bottom).mas_offset(30);
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
        NSString *text = @"更新时间:2017-05-22\n1.添加更多设置选项，如主题，背景颜色等\n2.新增思政做题功能3.修复若干bug\n注意:更新日志以App Store为准";
        
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:5];
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [text length])];
        _explainLabel.attributedText = attributedString;
        [_explainLabel sizeToFit];
    }
    return _explainLabel;
}


@end
