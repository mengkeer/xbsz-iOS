//
//  CourseDetailViewController.m
//  xbsz
//
//  Created by lotus on 14/03/2017.
//  Copyright © 2017 lotus. All rights reserved.
//

#import "CourseDetailViewController.h"
#import "CourseInfoViewController.h"
#import "RateView.h"
#import "ShareToolBarView.h"
#import "CXNetwork+Course.h"
#import <AVKit/AVKit.h>
#import <AVFoundation/AVPlayer.h>

static CGPoint beforeScrollPoint ;

static CGFloat imageHeight = 210;

@interface CourseDetailViewController () <RateViewDelegate,UIScrollViewDelegate>

@property (nonatomic, strong) YYAnimatedImageView *imageView;     //顶部imageView
@property (nonatomic, strong) UIButton *shareBtn;
@property (nonatomic, strong) UIButton *commentBtn;

@property (nonatomic, strong) Course *course;

@property (nonatomic, strong) CourseInfoViewController *infoViewController;

@end

@implementation CourseDetailViewController

- (instancetype)init{
    self = [super init];
    if (self) {
        [self setHidesBottomBarWhenPushed:YES];
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.view bringSubviewToFront:self.navigationController.navigationBar];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.view bringSubviewToFront:self.navigationController.navigationBar];
    self.customNavBarView.backgroundColor = CXBackGroundColor;
    self.title = self.course.title;
    self.view.backgroundColor = CXWhiteColor;
    
    [self.customNavBarView addSubview:self.shareBtn];            //添加分享按钮
    [self.customNavBarView addSubview:self.commentBtn];
    [self.view addSubview:self.imageView];
    
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(imageHeight);
        make.top.mas_equalTo(self.customNavBarView.mas_bottom);
    }];
    
    [_imageView setYy_imageURL:[NSURL URLWithString:_course.icon]];
    
    
    _infoViewController = [CourseInfoViewController controller];
    _infoViewController.course = _course;
    _infoViewController.delegate = self;
    [self addChildViewController:_infoViewController];
    [self.view addSubview:_infoViewController.view];
    [_infoViewController.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(_imageView.mas_bottom);
        make.bottom.mas_equalTo(self.view);
    }];
}


#pragma  mark - public method
- (void)updateDetailWithCourse:(Course *)course{
    _course = course;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - 3DTouch Item
- (NSArray<id<UIPreviewActionItem>> *)previewActionItems{
    
    // 生成UIPreviewAction
    UIPreviewAction *action1 = [UIPreviewAction actionWithTitle:@"认领课程" style:UIPreviewActionStyleDefault handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        NSLog(@"Action 1 selected");
    }];
    
    UIPreviewAction *action2 = [UIPreviewAction actionWithTitle:@"开始学习" style:UIPreviewActionStyleDefault handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        NSLog(@"Action 2 selected");
    }];
    
    UIPreviewAction *action3 = [UIPreviewAction actionWithTitle:@"移除课程" style:UIPreviewActionStyleDestructive handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        NSLog(@"Action 3 selected");
    }];
    
    NSArray *actions = @[action1, action2, action3];
    return actions;
}


#pragma mark - getter/setter

- (UIButton *)shareBtn{
    if(!_shareBtn){
        _shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _shareBtn.frame = CGRectMake(CXScreenWidth - 35, 20, 20, 44);
        [_shareBtn setImage:[UIImage imageNamed:@"course_share"] forState:UIControlStateNormal];
        [_shareBtn setImage:[UIImage imageNamed:@"course_share"] forState:UIControlStateHighlighted];
        [_shareBtn addTarget:self action:@selector(showShareBar) forControlEvents:UIControlEventTouchUpInside];
    }
    return _shareBtn;
}

- (UIButton *)commentBtn{
    if(!_commentBtn){
        _commentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _commentBtn.frame = CGRectMake(CXScreenWidth - 70, 20, 20, 44);
        [_commentBtn setImage:[UIImage imageNamed:@"course_comment"] forState:UIControlStateNormal];
        [_commentBtn setImage:[UIImage imageNamed:@"course_comment"] forState:UIControlStateHighlighted];
        [_commentBtn addTarget:self action:@selector(showCommentDialog) forControlEvents:UIControlEventTouchUpInside];
    }
    return _commentBtn;
}

- (YYAnimatedImageView *)imageView{
    if(!_imageView){
        _imageView = [[YYAnimatedImageView alloc] init];
    }
    return _imageView;
}




#pragma mark  - action method
- (void)showShareBar{
    [[ShareToolBarView instance] updateUIWithModel:nil action:^(ShareToolBarActionTyep actionType) {
        [self handleShareAction:actionType];
    }];
    [[ShareToolBarView instance] showInView:self.view.window];
}

- (void)showCommentDialog{
    [[RateView instance] showInView:[self.view superview]];
    [RateView instance].delegate = self;
}

- (void)handleShareAction:(ShareToolBarActionTyep) actionType{
    switch (actionType) {
        case ShareToolBarActionTyepPYQ:
            [ToastView showSuccessWithStaus:@"朋友圈分享"];
            break;
        case ShareToolBarActionTyepWechat:
            [ToastView showSuccessWithStaus:@"微信分享"];
            break;
        case ShareToolBarActionTyepQQ:
            [ToastView showSuccessWithStaus:@"QQ分享"];
            break;
        case ShareToolBarActionTyepQzone:
            [ToastView showSuccessWithStaus:@"QQ控件分享"];
            break;
        case ShareToolBarActionTyepWeibo:
            [ToastView showSuccessWithStaus:@"微博分享"];
            break;
        case ShareToolBarActionTyepSystem:
            [ToastView showSuccessWithStaus:@"系统分享"];
            break;
        case ShareToolBarActionTyepCancel:
            [[ShareToolBarView instance] dismissInView:self.view.window];
            break;
        default:
            break;
    }
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    beforeScrollPoint = scrollView.contentOffset;
    if(beforeScrollPoint.y < 0)     beforeScrollPoint = CGPointZero;
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGPoint nowOffset = scrollView.contentOffset;
    
    CGPoint center = _imageView.center;             //图片的center
    
    CGFloat y1 = 64 - imageHeight/2;
    CGFloat y2 = 64 + imageHeight/2;
    
    if(nowOffset.y > 0.0 && center.y > ([self getStartOriginY]-imageHeight/2)){
        if(nowOffset.y < beforeScrollPoint.y) return;
        CGFloat paddingY = nowOffset.y  - beforeScrollPoint.y;
        CGFloat top =  _imageView.center.y - paddingY <= y1 ? y1 : _imageView.center.y - paddingY ;
        CGFloat gap = _imageView.center.y - top;
        _imageView.center = CGPointMake(CXScreenWidth/2, top);
        scrollView.contentOffset = beforeScrollPoint;
        
        CGRect frame = _infoViewController.view.frame;
        _infoViewController.view.frame = CGRectMake(0,frame.origin.y-gap, CXScreenWidth, CGRectGetHeight(frame)+gap);
        
    }else{
        if(nowOffset.y <= 0.0 && center.y >= y1 && center.y < y2){
            CGFloat top =  _imageView.center.y - nowOffset.y >y2 ? y2 : _imageView.center.y - nowOffset.y ;
            CGFloat gap = _imageView.center.y - top;
            _imageView.center = CGPointMake(CXScreenWidth/2, top);
            scrollView.contentOffset = CGPointZero;
            
            if(center.y >= y2)     return;
            CGRect frame = _infoViewController.view.frame;
            _infoViewController.view.frame = CGRectMake(0,frame.origin.y-gap, CXScreenWidth, CGRectGetHeight(frame)+gap);
            
        }
    }
}

#pragma  mark - RateViewDelegate

- (void)rateView:(CGFloat)scorePoint contnet:(NSString *)content{
    if(![[CXLocalUser instance] isLogin]){
        [ToastView showBlackSuccessWithStaus:@"请先登录"];
        return;
    }
    NSInteger point = (int)(scorePoint*5);
    
    [CXNetwork addCourseComment:_course.courseID content:content point:point success:^(NSObject *obj) {
        [ToastView showBlackSuccessWithStaus:@"评论成功"];
        [[NSNotificationCenter defaultCenter] postNotificationName:NotificationCourseCommentSubmited object:nil];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)( 1.2* NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [[RateView instance] dismissInView:self.view.superview];
        });
    } failure:^(NSError *error) {
        CXLog(@"评分失败");
    }];
}

@end
