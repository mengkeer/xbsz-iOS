//
//  BirthdayViewController.m
//  xbsz
//
//  Created by lotus on 2017/4/23.
//  Copyright © 2017年 lotus. All rights reserved.
//

#import "BirthdayViewController.h"
#import "CXNetwork+User.h"

@interface BirthdayViewController ()

@property (nonatomic, strong) UIButton *saveBtn;

@property (nonatomic, strong) UILabel *birthLabel;

@property (nonatomic, strong) UILabel *dateLabel;

@property (nonatomic, strong) UIDatePicker *datePicker;

@end

@implementation BirthdayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的生日";
    
    [self.customNavBarView addSubview:self.saveBtn];
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, [self getStartOriginY]+15, CXScreenWidth, 44)];
    bgView.backgroundColor = CXWhiteColor;
    [bgView addSubview:self.birthLabel];
    [bgView addSubview:self.dateLabel];
    
    [self.view addSubview:bgView];
    [self.view addSubview:self.datePicker];
    [_datePicker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.view);
        make.height.mas_equalTo(250);
    }];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = CXGrayColor;
    [self.view addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(1/CXMainScale);
        make.bottom.mas_equalTo(_datePicker.mas_top);
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - getter/setter

- (UIButton *)saveBtn{
    if(!_saveBtn){
        _saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        NSString *title = @"保存";
        [_saveBtn setTitle:title forState:UIControlStateNormal];
        [_saveBtn setTitleColor:CXHexColor(0xc6c9d2) forState:UIControlStateNormal];
        _saveBtn.titleLabel.font = CXSystemBoldFont(15);
        CGFloat width = [title sizeWithAttributes:@{NSFontAttributeName:CXSystemBoldFont(15)}].width;
        _saveBtn.frame = CGRectMake(CXScreenWidth-15-width, CX_PHONE_STATUSBAR_HEIGHT, width, 44);
        [_saveBtn addTarget:self action:@selector(saveBirthday) forControlEvents:UIControlEventTouchUpInside];
        [_saveBtn setEnabled:NO];
    }
    return _saveBtn;
}

- (UILabel *)birthLabel{
    if(!_birthLabel){
        _birthLabel = [[UILabel alloc] init];
        _birthLabel.frame = CGRectMake(15, 0, 75, 44);
        _birthLabel.text = @"我的生日";
        _birthLabel.font = CXSystemFont(15);
        _birthLabel.textAlignment = NSTextAlignmentLeft;
        _birthLabel.textColor = CXBlackColor;
    }
    return _birthLabel;
}

- (UILabel *)dateLabel{
    if(!_dateLabel){
        _dateLabel = [[UILabel alloc] init];
        _dateLabel.frame = CGRectMake(CXScreenWidth-15-120, 0, 120, 44);
        _dateLabel.text = [CXLocalUser instance].birthday;
        _dateLabel.font = CXSystemFont(15);
        _dateLabel.textAlignment = NSTextAlignmentRight;
        _dateLabel.textColor = CXBlackColor;
    }
    return _dateLabel;
}

- (UIDatePicker *)datePicker{
    if(!_datePicker){
        _datePicker = [[UIDatePicker alloc] init];
        _datePicker.datePickerMode = UIDatePickerModeDate;
        _datePicker.date = [NSDate date];
        _datePicker.maximumDate = [NSDate date];
        _datePicker.minimumDate = [NSDate dateWithString:@"1980-01-01" format:@"yyyy-MM-dd"];
        _datePicker.backgroundColor = CXBackGroundColor;
        [_datePicker addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged];
    }
    return _datePicker;
}

#pragma mark - private method

- (void)dateChanged:(UIDatePicker *)datePicker{
    NSDate *date = datePicker.date;
    NSString *dateStr = [date stringWithFormat:@"yyyy-MM-dd"];
    _dateLabel.text = dateStr;
    if(_saveBtn.enabled == NO){
        [_saveBtn setTitleColor:CXHexColor(0xfab82b) forState:UIControlStateNormal];
        _saveBtn.enabled = YES;
    }
}

- (void)saveBirthday{
    NSString *token = [CXLocalUser instance].token;
    NSMutableDictionary *paremeters = [NSMutableDictionary dictionaryWithObjectsAndKeys:_dateLabel.text,@"birthday", nil];
    [CXNetwork updateUserInfo:token parameters:paremeters success:^(NSObject *obj) {
        [ToastView showSuccessWithStaus:@"修改成功"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.lcNavigationController popViewController];
        });
    } failure:^(NSError *error) {
        [ToastView showErrorWithStaus:@"修改失败"];
    }];

}

@end
