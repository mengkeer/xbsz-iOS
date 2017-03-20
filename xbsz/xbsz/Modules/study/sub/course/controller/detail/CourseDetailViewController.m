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
        make.height.mas_equalTo(200);
        make.top.mas_equalTo(self.customNavBarView.mas_bottom);
    }];
    
    [_imageView setYy_imageURL:[NSURL URLWithString:_course.imageUrl]];
    
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
            CXLog(@"朋友圈分享");
            break;
        case ShareToolBarActionTyepWechat:
            CXLog(@"微信分享");
            break;
        case ShareToolBarActionTyepQQ:
            CXLog(@"QQ分享");
            break;
        case ShareToolBarActionTyepQzone:
            CXLog(@"QQ空间分享");
            break;
        case ShareToolBarActionTyepWeibo:
            CXLog(@"微博分享");
            break;
        case ShareToolBarActionTyepSystem:
            CXLog(@"系统分享");
            break;
        case ShareToolBarActionTyepCancel:
            [[ShareToolBarView instance] dismissInView:self.view.window];
            break;
        default:
            break;
    }
}

#pragma mark - RateViewDelegate

- (void)rateView:(CGFloat)scorePoint contnet:(NSString *)content{
    CXLog(@"评分为%.1f 评论内容为:%@",scorePoint,content);
}


#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGPoint nowOffset = scrollView.contentOffset;
    
    CGPoint center = _imageView.center;             //图片的center
    
    CXLog(@"ContentSzie = %f ,%f",scrollView.contentSize.width,scrollView.contentSize.height);
    CXLog(@"上一级的height = %lf",scrollView.frame.size.height);

    //    CXLog(@"ContentOffset = %f ,%f",scrollView.contentOffset.x,scrollView.contentOffset.y);
//    CXLog(@"ContentInset = %f",scrollView.contentInset.bottom);
    
    
//    CXLog(@"Y偏移量= %lf 图片的centerY = %lf",nowOffset.y,center.y);
    if(nowOffset.y >= 0.0 && center.y > ([self getStartOriginY]-100)){
        CGFloat top =  _imageView.center.y - nowOffset.y <= -36 ? -36 : _imageView.center.y - nowOffset.y ;
        CGFloat gap = _imageView.center.y - top;
        _imageView.center = CGPointMake(CXScreenWidth/2, top);
        scrollView.contentOffset = CGPointZero;
        
        CGRect frame = _infoViewController.view.frame;
        _infoViewController.view.frame = CGRectMake(0,frame.origin.y-gap, CXScreenWidth, CGRectGetHeight(frame)+gap);
//        frame = _infoViewController.view.frame;
//        [_infoViewController setUpContentViewFrame:^(UIView *contentView) {
//            contentView.frame = frame;
//        }];
        
//        CGRect frame2 = scrollView.frame;
//        scrollView.frame = CGRectMake(frame.origin.x, 0, frame2.size.width, frame2.size.height+gap);
    }else{
        if(nowOffset.y <= 0.0 && center.y >= -36 && center.y < 164){
             CGFloat top =  _imageView.center.y - nowOffset.y >164 ? 164 : _imageView.center.y - nowOffset.y ;
            CGFloat gap = _imageView.center.y - top;
            _imageView.center = CGPointMake(CXScreenWidth/2, top);
            scrollView.contentOffset = CGPointZero;
            
            if(center.y >= 164)     return;
            CGRect frame = _infoViewController.view.frame;
            _infoViewController.view.frame = CGRectMake(0,frame.origin.y-gap, CXScreenWidth, CGRectGetHeight(frame)+gap);
//            frame = _infoViewController.view.frame;
//            [_infoViewController setUpContentViewFrame:^(UIView *contentView) {
//                contentView.frame = frame;
//            }];
//            CGRect frame2 = scrollView.frame;
//             scrollView.frame = CGRectMake(frame.origin.x, 0, frame2.size.width, frame2.size.height+gap);
        }
    }
}


@end
