//
//  UpdateInfoViewController.m
//  xbsz
//
//  Created by lotus on 2017/5/14.
//  Copyright © 2017年 lotus. All rights reserved.
//

#import "UpdateInfoViewController.h"
#import "CXNetworkMonitoring.h"

@interface UpdateInfoViewController ()

@property (nonatomic, strong) UILabel *explainLabel;

@property (nonatomic, strong) UILabel *copyrightLabel;


@end

@implementation UpdateInfoViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self showTopLineView];
    
    if([CXNetworkMonitoring canReachable] == NO){
        _explainLabel.textAlignment = NSTextAlignmentCenter;
        return;
    }
    
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSString *storeString = [NSString stringWithFormat:@"https://itunes.apple.com/lookup?id=%@",APPID];
    [manager GET:storeString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray *array = responseObject[@"results"];
        NSDictionary *dic  = [array firstObject];
        NSString *storeVersion = dic[@"version"];
        NSString *releaseNotes = dic[@"releaseNotes"];      //更新说明
        
        NSString *dateStr = dic[@"currentVersionReleaseDate"];
        
        NSString *currentVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];

        NSString *text = [NSString stringWithFormat:@"当前版本V%@\n\n",currentVersion];
        text = [text stringByAppendingString:[NSString stringWithFormat:@"最新版本V%@ - date at %@\n\n",storeVersion,dateStr]];
         if(releaseNotes == nil){
             text = [text stringByAppendingString:@"更新说明: 暂无"];
         }else{
             text = [text stringByAppendingString:@"更新说明:\n"];
             text = [text stringByAppendingString:releaseNotes];
         }
        
        _explainLabel.text = text;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];

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
        _explainLabel.font = CXSystemFont(13);
        _explainLabel.textAlignment = NSTextAlignmentLeft;
        _explainLabel.textColor = CXHexColor(0x4f4f4f);
        _explainLabel.numberOfLines = 0;
        NSString *text = @"无网络连接，请重新尝试";
        
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
