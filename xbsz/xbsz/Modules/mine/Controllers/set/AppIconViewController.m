//
//  AppIconViewController.m
//  xbsz
//
//  Created by lotus on 2017/12/20.
//  Copyright © 2017年 lotus. All rights reserved.
//

#import "AppIconViewController.h"

@interface AppIconViewController ()

@property (nonatomic, strong) NSMutableArray *iconArr;
@property (nonatomic, copy) NSArray *iconNameArr;


@end

@implementation AppIconViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"应用图标设置";
    self.customNavBarView.backgroundColor = CXHexAlphaColor(0xF6F6F6, 0.2);
    self.titleLabel.textColor = CXHexAlphaColor(0x000000, 0.2);
    _iconArr = [NSMutableArray array];
    _iconNameArr = @[@"icon_shiki",@"icon_saber",@"icon_mai1",@"icon_unknown1",@"icon_unknown2",@"icon_mai2",@"icon_unknown3"];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"set_app_bg"]];
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.showsVerticalScrollIndicator = YES;
    scrollView.backgroundColor = CXClearColor;
    [self.view addSubview:scrollView];
    CGFloat width = CXScreenWidth/6.5;
    CGFloat height = width+30;
    CGFloat originX = width/2;
    CGFloat originY = 30.f+CX_PHONE_NAVIGATIONBAR_HEIGHT;
    NSString *iconName = [CXUserDefaults instance].iconName;
    for(NSInteger i = 0;i< _iconNameArr.count;i++){
        NSString *imageName = [_iconNameArr objectAtIndex:i];
        AppIconView *iconView = [[AppIconView alloc] initWithFrame:CGRectMake(originX, originY, width, height)];
        iconView.tag = 100+i;
        [iconView updateUIByIconName:imageName isSelected:[imageName isEqualToString:iconName]];
        [scrollView addSubview:iconView];
        originX += (width + width/2);
        if(originX >= CXScreenWidth-10) originX = width/2;
        if((i+1)/4 != i/4){
            originY += (height+15);
        }
        [scrollView addSubview:iconView];
        [_iconArr addObject:iconView];
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClick:)];
        iconView.userInteractionEnabled = YES;
        [iconView addGestureRecognizer:tapGesture];
    }

    UIButton *resetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    resetBtn.frame = CGRectMake(CXScreenWidth-70-15, CX_PHONE_STATUSBAR_HEIGHT, 70, 44);
    [resetBtn setTitle:@"恢复默认" forState:UIControlStateNormal];
    resetBtn.titleLabel.font = CXSystemFont(16);
    [resetBtn setTitleColor:CXHexAlphaColor(0x000000, 0.3) forState:UIControlStateNormal];
    [self.customNavBarView addSubview:resetBtn];
    [resetBtn addTarget:self action:@selector(didResetBtn) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didClick:(UITapGestureRecognizer *)gesture{
    NSInteger tag = gesture.view.tag;
    [CXUserDefaults instance].iconName = [_iconNameArr objectAtIndex:gesture.view.tag % 100];
    for(NSInteger i = 0;i < _iconArr.count;i++){
        NSString *imageName = [_iconNameArr objectAtIndex:i];
        AppIconView *view = [_iconArr objectAtIndex:i];
        [view updateUIByIconName:imageName isSelected:tag%100 == i];
        if(tag % 100 == i){
            [self setAppIconWithName:imageName];
        }
    };
}

- (void)didResetBtn{
    [CXUserDefaults instance].iconName = nil;
    for(NSInteger i = 0;i < _iconArr.count;i++){
        NSString *imageName = [_iconNameArr objectAtIndex:i];
        AppIconView *view = [_iconArr objectAtIndex:i];
        [view updateUIByIconName:imageName isSelected:[imageName isEqualToString:[CXUserDefaults instance].iconName ]];
        if(i == _iconArr.count - 1){
            [self setAppIconWithName:nil];
        }
    };
}

- (void)setAppIconWithName:(NSString *)iconName {
    if (![[UIApplication sharedApplication] supportsAlternateIcons]) {
        [ToastView showStatus:@"该功能需iOS10.3以上系统才支持"];
        return;
    }
    
    if ([iconName isEqualToString:@""]) {
        iconName = nil;
    }
    [UIApplication sharedApplication];
    [[UIApplication sharedApplication] setAlternateIconName:iconName completionHandler:^(NSError * _Nullable error) {
    }];
    [ToastView showSuccessWithStaus:@"更换成功"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

@interface AppIconView ()

@property (nonatomic, strong) UIImageView *iconImageView;

@property (nonatomic, strong) UILabel *statusLabel;

@property (nonatomic, strong) UIImageView *selectedImageView;

@end

@implementation AppIconView

- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self initSubView];
    }
    return self;
}

- (void)initSubView{
    _iconImageView = [[UIImageView alloc] init];
    [self addSubview:_iconImageView];
    [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(self);
        make.bottom.mas_equalTo(self.mas_bottom).mas_offset(-30);;
    }];
    _iconImageView.layer.cornerRadius = 12;
    _iconImageView.clipsToBounds = YES;
    
    _statusLabel = [[UILabel alloc] init];
    _statusLabel.textColor = [UIColor lightGrayColor];
    _statusLabel.textAlignment = NSTextAlignmentCenter;
    _statusLabel.text = @"已选择";
    _statusLabel.font = CXSystemFont(15);
    [self addSubview:_statusLabel];
    [_statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self);
        make.height.mas_equalTo(30);
    }];
    
    _selectedImageView = [[UIImageView alloc] init];
    _selectedImageView.image = [UIImage imageNamed:@"set_icon_selected"];
    [self addSubview:_selectedImageView];
    [_selectedImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(30);
        make.centerX.mas_equalTo(self.mas_centerX);
        make.bottom.mas_equalTo(self.mas_bottom);
    }];
}
- (void)updateUIByIconName:(NSString *)iconName isSelected:(BOOL)isSelected{
    _iconImageView.image = [UIImage imageNamed:iconName];
    if(isSelected == YES){
        _statusLabel.hidden = NO;
        _selectedImageView.hidden = NO;
    }else{
        _statusLabel.hidden = YES;
        _selectedImageView.hidden = YES;
    }
}

@end
