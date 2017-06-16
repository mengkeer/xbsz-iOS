//
//  DiscoverViewController.m
//  xbsz
//
//  Created by lotus on 2016/12/14.
//  Copyright © 2016年 lotus. All rights reserved.
//

#import "DiscoverViewController.h"
#import "CampusViewController.h"
#import "RecommendViewController.h"
#import "TZImagePickerController.h"
#import "NewPostViewController.h"

@interface DiscoverViewController () <TZImagePickerControllerDelegate>

@property (nonatomic, strong) UIButton *cameraBtn;

@end

@implementation DiscoverViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];
    self.automaticallyAdjustsScrollViewInsets = NO;
}


- (void)autoTheme{
    self.titleScrollViewColor = [CXUserDefaults instance].mainColor;
    self.contentView.backgroundColor = [CXUserDefaults instance].mainColor;
    self.view.backgroundColor = [CXUserDefaults instance].mainColor;
    
    NSInteger themeType = [CXUserDefaults instance].themeType;
    if(themeType == 2){
        self.norColor =  [CXUserDefaults instance].textColor;
        self.selColor = CXMainColor;
        self.underLineColor = CXMainColor;
    }else{
        self.norColor = CXHexAlphaColor(0xFFFFFF, 0.7);
        self.selColor = CXWhiteColor;
        self.underLineColor = CXWhiteColor;
    }
    [self refreshDisplay];
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.titleScrollViewColor = [CXUserDefaults instance].mainColor;
    self.contentView.backgroundColor = [CXUserDefaults instance].mainColor;
    self.view.backgroundColor = [CXUserDefaults instance].mainColor;
    
    /**
     如果_isfullScreen = Yes，这个方法就不好使。
     
     设置整体内容的frame,包含（标题滚动视图和内容滚动视图）
     */
    [self setUpContentViewFrame:^(UIView *contentView) {
        contentView.frame = CGRectMake(0, 20, CXScreenWidth, CXScreenHeight - CXStatusBarHeight);
        contentView.backgroundColor = CXMainColor;
    }];
    
    // 添加所有子控制器
    [self setUpAllViewController];
    
    [self setUpTitleEffect:^(UIColor *__autoreleasing *titleScrollViewColor, UIColor *__autoreleasing *norColor, UIColor *__autoreleasing *selColor, UIFont *__autoreleasing *titleFont, CGFloat *titleHeight, CGFloat *titleWidth){
        *titleScrollViewColor = CXMainColor;
        NSInteger themeType = [CXUserDefaults instance].themeType;
        if(themeType == 2){
            *norColor =  [CXUserDefaults instance].textColor;
            *selColor = CXMainColor;
        }else{
            *norColor = CXHexAlphaColor(0xFFFFFF, 0.6);
            *selColor = CXWhiteColor;
        }
        *titleWidth = 75;;
        *titleFont = CXSystemFont(16);
        *titleHeight = CXDisplayTitleHeight;
    }];
    
    // 标题渐变
    // *推荐方式(设置标题渐变)
    [self setUpTitleGradient:^(YZTitleColorGradientStyle *titleColorGradientStyle, UIColor *__autoreleasing *norColor, UIColor *__autoreleasing *selColor) {
//        titleColorGradientStyle = YZTitleColorGradientStyleFill;
    }];
    
    [self setUpUnderLineEffect:^(BOOL *isUnderLineDelayScroll, CGFloat *underLineH, UIColor *__autoreleasing *underLineColor,BOOL *isUnderLineEqualTitleWidth) {
        
        //        *isUnderLineDelayScroll = YES;
        NSInteger themeType = [CXUserDefaults instance].themeType;
        if(themeType == 2){
            *underLineColor = CXMainColor;
        }else{
            *underLineColor = CXWhiteColor;
        }
        *isUnderLineEqualTitleWidth = YES;
        *isUnderLineEqualTitleWidth = YES;
        *underLineH = 2;
    }];
    
   [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(autoTheme) name:NotificationThemeChanged object:nil];
        
    self.selectIndex = 0;
    
    [self.view addSubview:self.cameraBtn];
    [_cameraBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(32);
        make.top.mas_equalTo(self.view.mas_top).mas_offset(20);
        make.right.mas_equalTo(self.view.mas_right).mas_offset(-15);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Private
// 添加所有子控制器
- (void)setUpAllViewController
{
    
    //校园
    CampusViewController *vc1 = [CampusViewController controller];
    vc1.title = @"校园";
    [self addChildViewController:vc1];
    
//    //推荐
//    RecommendViewController *vc2 = [RecommendViewController controller];
//    vc2.title = @"推荐";
//    [self addChildViewController:vc2];
//    
//    
//    
//    //动态
//    RecommendViewController *vc3 = [RecommendViewController controller];
//    vc3.title = @"动态";
//    [self addChildViewController:vc3];
    
}

- (UIButton *)cameraBtn{
    if(!_cameraBtn){
        _cameraBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cameraBtn setImage:[UIImage imageNamed:@"camera"] forState:UIControlStateNormal];
        [_cameraBtn addTarget:self action:@selector(postNote) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cameraBtn;
}

- (void)postNote{
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:self];
//    imagePickerVc.allowCrop = YES;
    imagePickerVc.photoWidth = CXScreenWidth*CXMainScale;
    imagePickerVc.allowPickingGif = YES;
    imagePickerVc.allowPickingOriginalPhoto = YES;
    imagePickerVc.autoDismiss = NO;
    
    NSInteger themeType = [CXUserDefaults instance].themeType;
    if(themeType != 2){
        imagePickerVc.navigationBar.barTintColor = [CXUserDefaults instance].mainColor;
    }
    
    imagePickerVc.cropRect = CGRectMake(0 , (CXScreenHeight- CXScreenWidth)/2, CXScreenWidth, CXScreenWidth);
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}


- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto{
    [picker dismissViewControllerAnimated:NO completion:nil];
    NewPostViewController *postVC = [NewPostViewController controller];
    postVC.sharedImage = photos[0];
    [self presentViewController:postVC animated:YES completion:nil];
}

- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingGifImage:(UIImage *)animatedImage sourceAssets:(id)asset{
    [picker dismissViewControllerAnimated:NO completion:nil];
    NewPostViewController *postVC = [NewPostViewController controller];
    postVC.sharedImage = animatedImage;
    [self presentViewController:postVC animated:YES completion:nil];
}

- (void)tz_imagePickerControllerDidCancel:(TZImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}


@end
