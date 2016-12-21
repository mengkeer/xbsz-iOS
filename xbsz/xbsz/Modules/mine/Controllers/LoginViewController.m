//
//  LoginViewController.m
//  xbsz
//
//  Created by lotus on 2016/12/21.
//  Copyright © 2016年 lotus. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@property (nonatomic,strong) UIButton *closeBtn;
@property (nonatomic,strong) UIImageView *appNameIV;
@property (nonatomic,strong) UILabel *loginTypeLabel;
@property (nonatomic,strong) UITextField *userNameField;
@property (nonatomic,strong) UITextField *passwordFiled;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:CXBackGroundColor];
    
    [self createUI];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - private method

- (void)createUI{
    [self.view addSubview:self.closeBtn];
    [self.view addSubview:self.appNameIV];
    [self.view addSubview:self.loginTypeLabel];
    [_loginTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_appNameIV.mas_bottom).mas_offset(50);
        make.height.mas_equalTo(12);
        make.centerX.mas_equalTo(self.view);
    }];
    
    [self.view addSubview:self.userNameField];
    [_userNameField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_loginTypeLabel.mas_bottom).mas_offset(25);
        make.height.mas_equalTo(45);
        make.left.mas_equalTo(self.view.mas_left).mas_offset(20);
        make.right.mas_equalTo(self.view.mas_right).mas_offset(-20);
    }];
    
    [self.view layoutIfNeeded];
    
    //设置上半部分圆角
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:_userNameField.bounds byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight cornerRadii:CGSizeMake(4, 4)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = _userNameField.bounds;
    maskLayer.path = maskPath.CGPath;
    
    //设置边框
    CAShapeLayer *borderLayer = [[CAShapeLayer alloc] init];
    borderLayer.frame = _userNameField.bounds;
    borderLayer.path = maskPath.CGPath;
    borderLayer.strokeColor = CXLightGrayColor.CGColor;   // 边框颜色
    borderLayer.fillColor = CXClearColor.CGColor;
    
    _userNameField.layer.mask = maskLayer;
    [_userNameField.layer addSublayer:borderLayer];
    

    
    
    
    
}


#pragma mark - getter / setter

- (UIButton *)closeBtn{
    if(!_closeBtn){
        _closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _closeBtn.titleLabel.font = CXSystemFont(16);
        _closeBtn.frame = CGRectMake(CXScreenWidth - 40, 27, 30, 30);
        [_closeBtn setImage:[UIImage imageNamed:@"common_close"] forState:UIControlStateNormal];
        [[_closeBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }];
    }
    return _closeBtn;
}

- (UIImageView *)appNameIV{
    if(!_appNameIV){
        _appNameIV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"set_app_name"]];//#f16c4d
        _appNameIV.frame = CGRectMake((CXScreenWidth-180)/2, 70, 180, 50);
    }
    return _appNameIV;
}

- (UILabel *)loginTypeLabel{
    if(!_loginTypeLabel){
        _loginTypeLabel = [[UILabel alloc] init];
        _loginTypeLabel.font = CXSystemFont(12);
        _loginTypeLabel.text = @"上次登录方式:QQ授权登录";
        _loginTypeLabel.textColor = CXHexColor(0xf16c4d);
    }
    return _loginTypeLabel;
}

- (UITextField *)userNameField{
    if(!_userNameField){
        _userNameField = [[UITextField alloc] init];
        _userNameField.placeholder = @"手机号或邮箱";
        _userNameField.backgroundColor = CXWhiteColor;
        _userNameField.clearButtonMode=UITextFieldViewModeWhileEditing;
        [_userNameField setFont:[UIFont systemFontOfSize:16.0]];
        [_userNameField setTextColor:CXLightGrayColor];
//        [_userNameField set];
    
        
        UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 20)];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"set_user"]];
        imageView.frame = CGRectMake(10, 0, 20, 20);
        [leftView addSubview:imageView];
        
        _userNameField.leftView = leftView;
        _userNameField.leftViewMode=UITextFieldViewModeAlways; //此处用来设置leftview现实时机
    }
    return _userNameField;
}


@end
