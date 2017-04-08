//
//  UserCenterViewController.m
//  xbsz
//
//  Created by lotus on 2016/12/11.
//  Copyright © 2016年 lotus. All rights reserved.
//

#import "UserCenterViewController.h"
#import "CXSectionButton.h"
#import "SetViewController.h"
#import "UserInfoViewController.h"
#import "InformViewController.h"
#import "LoginViewController.h"

//APP Controller
#import "CXBaseWebViewController.h"
#import "SchoolSceneryViewController.h"

#define SectionHeaderHeight   45

@interface UserCenterViewController ()<UIScrollViewDelegate>

@property (nonatomic,strong) UILabel *nickNamelabel;        //昵称

@property (nonatomic,strong) UIView *infoBgView;        //头像区域的背景view

@property (nonatomic,strong) UIView *dotView;

@property (nonatomic,strong) UIView *infoView;
@property (nonatomic,strong) UILabel *briefLabel;       //简介
@property (nonatomic,strong) UIButton *headBtn;     //头像

@property (nonatomic,strong) UIView *contentView;



@end

@implementation UserCenterViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createUI];
    
}

- (void)createUI{
    
    UIView *navigationView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CXScreenWidth, 64)];
    navigationView.backgroundColor = CXMainColor;
    [self.view addSubview:navigationView];

    
    //创建导航栏
    [self.view addSubview:self.nickNamelabel];
    [_nickNamelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(16);
        make.top.mas_equalTo(self.view.mas_top).mas_offset(34);
        make.centerX.mas_equalTo(self.view.mas_centerX);
    }];
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setImage:[UIImage imageNamed:@"mine_message"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(clickMessage) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:leftBtn];
    [leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.and.height.mas_equalTo(20);
        make.left.mas_equalTo(self.view).mas_offset(15);
        make.top.mas_equalTo(self.view).mas_offset(32);
    }];
    
    _dotView = [[UIView alloc] init];
    _dotView.backgroundColor = CXHexColor(0xff4b4b);
    [_dotView cornerRadius:3 borderWidth:0.f borderColor:nil];
    [self.view addSubview:_dotView];
    [_dotView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.mas_equalTo(6);
        make.left.mas_equalTo(leftBtn.mas_right);
        make.bottom.mas_equalTo(leftBtn.mas_top);
    }];
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setImage:[UIImage imageNamed:@"mine_settings"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(clickSet) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rightBtn];
    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.and.height.mas_equalTo(20);
        make.right.mas_equalTo(self.view).mas_offset(-15);
        make.top.mas_equalTo(self.view).mas_offset(32);
    }];

    //创建用户头像与个性签名
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64.f, CXScreenWidth, CXScreenHeight-64.f-49.f)];
    scrollView.backgroundColor = CXBackGroundColor;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.alwaysBounceVertical = YES;
    scrollView.contentSize = CGSizeMake(CXScreenWidth, 64.f);
    scrollView.delegate = self;
    [self.view addSubview:scrollView];
    
     _infoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CXScreenWidth, 145)];
    _infoView.backgroundColor = CXMainColor;
    
    _infoBgView = [[UIView alloc] init];
    _infoBgView.backgroundColor = CXMainColor;
    [_infoView addSubview:_infoBgView];
    [_infoBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.mas_equalTo(_infoView);
        make.width.mas_equalTo(CXScreenWidth);
        make.height.mas_equalTo(0);
    }];
    
    [_infoView addSubview:self.headBtn];
    [_headBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(_infoView.mas_centerX);
        make.width.and.height.mas_equalTo(90);
        make.top.mas_equalTo(_infoView.mas_top).mas_offset(10);
    }];

    [_infoView addSubview:self.briefLabel];
    [_briefLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_infoView.mas_left).mas_offset(40);
        make.right.mas_equalTo(_infoView.mas_right).mas_offset(-40);
        make.height.mas_equalTo(15);
        make.centerX.mas_equalTo(_infoView.mas_centerX);
        make.centerY.mas_equalTo(_infoView.mas_bottom).mas_offset(-22.5);
    }];
    [_infoView layoutIfNeeded];          //通过在父亲视图中调用layoutIfNeeded立即更新约束

  
    [self updateInfoViewHeight];
    
    UIImageView *rightArrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mine_right_arrow"]];
    rightArrow.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap  = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickInfo)];
    [rightArrow addGestureRecognizer:tap];
    [_infoView addSubview:rightArrow];
    [rightArrow mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(_infoView.mas_right).mas_offset(-15);
        make.width.mas_equalTo(20);
        make.height.mas_equalTo(20);
        make.centerY.mas_equalTo(_headBtn.mas_centerY);
    }];
    
    
    
    [scrollView addSubview:_infoView];
    
    UIView *backView = [[UIView alloc] init];       //内容区域圆角的背景
    backView.backgroundColor = CXMainColor;
    [scrollView addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_infoView.mas_bottom);
        make.width.mas_equalTo(CXScreenWidth);
        make.height.mas_equalTo(CXTopCornerRadius);
    }];
    
    
    CGFloat itemWidth = CXScreenWidth/4;
    [scrollView addSubview:self.contentView];
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_infoView.mas_bottom);
        make.width.mas_equalTo(CXScreenWidth);
        make.height.mas_equalTo(SectionHeaderHeight*2+itemWidth*4+20);
    }];
    
    
    
    [scrollView layoutIfNeeded];               //通过在父亲视图中调用layoutIfNeeded立即更新约束  否则frame属性获取为0
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, CXScreenWidth, _contentView.height) byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(CXTopCornerRadius, CXTopCornerRadius)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = CGRectMake(0, 0, CXScreenWidth, _contentView.height);
    maskLayer.path = maskPath.CGPath;
    _contentView.layer.mask = maskLayer;
    

    scrollView.contentSize = CGSizeMake(CXScreenWidth, _infoView.height+_contentView.height);
    
    [self.view addSubview:scrollView];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


//getter  setter
- (UILabel *)nickNamelabel{
    if(!_nickNamelabel){
        _nickNamelabel = [[UILabel alloc] init];
        _nickNamelabel.text = @"请登录";
        _nickNamelabel.font = CXSystemFont(16);
        _nickNamelabel.textAlignment = NSTextAlignmentCenter;
    }
    return _nickNamelabel;
}

- (UIButton *)headBtn{
    if(!_headBtn){
        _headBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_headBtn setImage:[[[UIImage imageNamed:@"avatar1.jpg"] imageByResizeToSize:CGSizeMake(58, 58) contentMode:UIViewContentModeScaleToFill] imageByRoundCornerRadius:29] forState:UIControlStateNormal];
        [_headBtn setBackgroundImage:[UIImage imageNamed:@"mine_bg_avatar"] forState:UIControlStateNormal];
        _headBtn.layer.cornerRadius = 45;
        _headBtn.clipsToBounds = YES;
        [_headBtn addTarget:self action:@selector(clickLogin) forControlEvents:UIControlEventTouchUpInside];
    }
    return _headBtn;
}

- (UILabel *)briefLabel{
    if(!_briefLabel){
        _briefLabel = [[UILabel alloc] init];
        _briefLabel.font = CXSystemFont(12);
        _briefLabel.textColor = CXTextGrayColor;
        _briefLabel.numberOfLines = 2;
        _briefLabel.text = @"虚伪的眼泪会伤害他人,虚伪的笑容只会伤害自己。";
        _briefLabel.alpha = 0.5;
        _briefLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _briefLabel;
}

- (UIView *)contentView{
    if(!_contentView){
        _contentView = [[UIView alloc] init];
        _contentView.backgroundColor = CXWhiteColor;
        
        CGFloat offsetY = 0;
        CGFloat width = CXScreenWidth/4;
        CGFloat height = width;
        
        #pragma mark - 创建我的应用栏
        
        UILabel *mySetionlabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CXScreenWidth, 15)];
        mySetionlabel.text = @"我的应用";
        mySetionlabel.font = CXSystemFont(14);
        mySetionlabel.textAlignment = NSTextAlignmentLeft;
        
        [_contentView addSubview:mySetionlabel];
        [mySetionlabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_contentView).mas_offset(15);
            make.top.mas_offset(_contentView.top).mas_offset(15);
            make.height.mas_equalTo(15);
        }];
        
        offsetY += 45;
        CGFloat startY = offsetY;
        
        UIView *hLine1 = [[UIView alloc] initWithFrame:CGRectMake(0, offsetY-1/CXMainScale, CXScreenWidth, 1/CXMainScale)];
        hLine1.backgroundColor = CXLineColor;
        [_contentView addSubview:hLine1];
        
 
        
        CXSectionButton *btn1 = [[CXSectionButton alloc] init:CGRectMake(0, offsetY, width, height)
                                                     andImage:[UIImage imageNamed:@"mine1"]
                                                     andTitle:@"我的课表"];
        [btn1 addTarget:self action:@selector(gotoMyCourseTable) forControlEvents:UIControlEventTouchUpInside];
        [_contentView addSubview:btn1];
        
        
        CXSectionButton *btn2 = [[CXSectionButton alloc] init:CGRectMake(width, offsetY, width, height)
                                                     andImage:[UIImage imageNamed:@"mine2"]
                                                     andTitle:@"考试安排"];
        [btn2 addTarget:self action:@selector(gotoMyExam) forControlEvents:UIControlEventTouchUpInside];
        [_contentView addSubview:btn2];
        
        
        CXSectionButton *btn3 = [[CXSectionButton alloc] init:CGRectMake(width*2, offsetY, width, height)
                                                     andImage:[UIImage imageNamed:@"mine3"]
                                                     andTitle:@"成绩查询"];
        [btn3 addTarget:self action:@selector(gotoMyScore) forControlEvents:UIControlEventTouchUpInside];
        [_contentView addSubview:btn3];
        
        
        
        CXSectionButton *btn4 = [[CXSectionButton alloc] init:CGRectMake(width*3, offsetY, width, height)
                                                     andImage:[UIImage imageNamed:@"mine4"]
                                                     andTitle:@"绩点查询"];
        [btn4 addTarget:self action:@selector(gotoMyScorePoint) forControlEvents:UIControlEventTouchUpInside];
        [_contentView addSubview:btn4];
        
        
        offsetY += height;
        UIView *hLine2 = [[UIView alloc] initWithFrame:CGRectMake(0, offsetY-1/CXMainScale, CXScreenWidth, 1/CXMainScale)];
        hLine2.backgroundColor = CXLineColor;
        [_contentView addSubview:hLine2];
        
        
        CXSectionButton *btn5 = [[CXSectionButton alloc] init:CGRectMake(0, offsetY, width, height)
                                                     andImage:[UIImage imageNamed:@"mine5"]
                                                     andTitle:@"借书查询"];
        [btn5 addTarget:self action:@selector(gotoMyBookInfo) forControlEvents:UIControlEventTouchUpInside];
        [_contentView addSubview:btn5];
        
        
        CXSectionButton *btn6 = [[CXSectionButton alloc] init:CGRectMake(width, offsetY, width, height)
                                                     andImage:[UIImage imageNamed:@"mine6"]
                                                     andTitle:@"通讯录"];
        [_contentView addSubview:btn6];
        
        
        CXSectionButton *btn7 = [[CXSectionButton alloc] init:CGRectMake(width*2, offsetY, width, height)
                                                     andImage:[UIImage imageNamed:@"mine7"]
                                                     andTitle:@"失物招领"];
        [_contentView addSubview:btn7];
        
        CXSectionButton *btn8 = [[CXSectionButton alloc] init:CGRectMake(width*3, offsetY, width, height)
                                                     andImage:[UIImage imageNamed:@"mine8"]
                                                     andTitle:@"学费查询"];
        [btn8 addTarget:self action:@selector(gotoMyTuition) forControlEvents:UIControlEventTouchUpInside];
        [_contentView addSubview:btn8];
        
        offsetY += height;
        UIView *hLine3 = [[UIView alloc] initWithFrame:CGRectMake(0, offsetY-1/CXMainScale, CXScreenWidth, 1/CXMainScale)];
        hLine3.backgroundColor = CXLineColor;
        [_contentView addSubview:hLine3];
        
        UIView *vLine1 = [[UIView alloc] initWithFrame:CGRectMake(width, startY , 1/CXMainScale , offsetY-startY)];
        vLine1.backgroundColor = CXLineColor;
        [_contentView addSubview:vLine1];
        
        UIView *vLine2 = [[UIView alloc] initWithFrame:CGRectMake(width*2, startY , 1/CXMainScale , offsetY-startY)];
        vLine2.backgroundColor = CXLineColor;
        [_contentView addSubview:vLine2];
        
        UIView *vLine3 = [[UIView alloc] initWithFrame:CGRectMake(width*3, startY , 1/CXMainScale ,  offsetY-startY)];
        vLine3.backgroundColor = CXLineColor;
        [_contentView addSubview:vLine3];
        
        
#pragma mark - 创建校园应用栏
        
        UIView *separateView = [[UIView alloc] initWithFrame:CGRectMake(0, offsetY, CXScreenWidth, 20)];
        separateView.backgroundColor = CXBackGroundColor;
        [_contentView addSubview:separateView];
        
        offsetY += 20;
        
        UILabel *mySetionlabe2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CXScreenWidth, 15)];
        mySetionlabe2.text = @"校园应用";
        mySetionlabe2.font = CXSystemFont(14);
        mySetionlabe2.textAlignment = NSTextAlignmentLeft;
        
        [_contentView addSubview:mySetionlabe2];
        [mySetionlabe2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_contentView).mas_offset(15);
            make.top.mas_equalTo(separateView.mas_bottom).mas_offset(15);
            make.height.mas_equalTo(15);
        }];
        
        offsetY += 45;
        startY = offsetY;
        
        UIView *hLine4 = [[UIView alloc] initWithFrame:CGRectMake(0, offsetY-1/CXMainScale, CXScreenWidth, 1/CXMainScale)];
        hLine4.backgroundColor = CXLineColor;
        [_contentView addSubview:hLine4];
        
        
        
        CXSectionButton *btn9 = [[CXSectionButton alloc] init:CGRectMake(0, offsetY, width, height)
                                                     andImage:[UIImage imageNamed:@"school1"]
                                                     andTitle:@"学工服务"];
        [btn9 addTarget:self action:@selector(gotoStudentService) forControlEvents:UIControlEventTouchUpInside];
        [_contentView addSubview:btn9];
        
        
        CXSectionButton *btn10 = [[CXSectionButton alloc] init:CGRectMake(width, offsetY, width, height)
                                                      andImage:[UIImage imageNamed:@"school2"]
                                                      andTitle:@"校园讲座"];
        [_contentView addSubview:btn10];
        [btn10 addTarget:self action:@selector(gotoSchoolLecture) forControlEvents:UIControlEventTouchUpInside];
        
        
        CXSectionButton *btn11 = [[CXSectionButton alloc] init:CGRectMake(width*2, offsetY, width, height)
                                                      andImage:[UIImage imageNamed:@"school3"]
                                                      andTitle:@"校园风光"];
        [btn11 addTarget:self action:@selector(gotoSchoolScenery) forControlEvents:UIControlEventTouchUpInside];
        [_contentView addSubview:btn11];
        
        
        
        CXSectionButton *btn12 = [[CXSectionButton alloc] init:CGRectMake(width*3, offsetY, width, height)
                                                      andImage:[UIImage imageNamed:@"school4"]
                                                      andTitle:@"电话黄页"];
        [btn12 addTarget:self action:@selector(gotoYellowPages) forControlEvents:UIControlEventTouchUpInside];
        [_contentView addSubview:btn12];
        
        
        offsetY += height;
        UIView *hLine5 = [[UIView alloc] initWithFrame:CGRectMake(0, offsetY-1/CXMainScale, CXScreenWidth, 1/CXMainScale)];
        hLine5.backgroundColor = CXLineColor;
        [_contentView addSubview:hLine5];
        
        
        
        CXSectionButton *btn13 = [[CXSectionButton alloc] init:CGRectMake(0, offsetY, width, height)
                                                     andImage:[UIImage imageNamed:@"school5"]
                                                     andTitle:@"空余教室"];
        [btn13 addTarget:self action:@selector(gotoFreeClassroom) forControlEvents:UIControlEventTouchUpInside];
        [_contentView addSubview:btn13];
    
        
        
        CXSectionButton *btn14 = [[CXSectionButton alloc] init:CGRectMake(width, offsetY, width, height)
                                                      andImage:[UIImage imageNamed:@"school6"]
                                                      andTitle:@"书目检索"];
        [btn14 addTarget:self action:@selector(gotoBookFind) forControlEvents:UIControlEventTouchUpInside];
        [_contentView addSubview:btn14];
        
        
        CXSectionButton *btn15 = [[CXSectionButton alloc] init:CGRectMake(width*2, offsetY, width, height)
                                                      andImage:[UIImage imageNamed:@"school7"]
                                                      andTitle:@"就业服务"];
        [btn15 addTarget:self action:@selector(gotoEmployment) forControlEvents:UIControlEventTouchUpInside];
        [_contentView addSubview:btn15];
        
        CXSectionButton *btn16 = [[CXSectionButton alloc] init:CGRectMake(width*3, offsetY, width, height)
                                                      andImage:[UIImage imageNamed:@"school8"]
                                                      andTitle:@"表白墙"];
        [_contentView addSubview:btn16];
        
        offsetY += height;
        UIView *hLine6 = [[UIView alloc] initWithFrame:CGRectMake(0, offsetY-1/CXMainScale, CXScreenWidth, 1/CXMainScale)];
        hLine6.backgroundColor = CXLineColor;
        [_contentView addSubview:hLine6];
        
        UIView *vLine4 = [[UIView alloc] initWithFrame:CGRectMake(width, startY , 1/CXMainScale , offsetY-startY)];
        vLine4.backgroundColor = CXLineColor;
        [_contentView addSubview:vLine4];
        
        UIView *vLine5 = [[UIView alloc] initWithFrame:CGRectMake(width*2, startY , 1/CXMainScale , offsetY-startY)];
        vLine5.backgroundColor = CXLineColor;
        [_contentView addSubview:vLine5];
        
        UIView *vLine6 = [[UIView alloc] initWithFrame:CGRectMake(width*3, startY , 1/CXMainScale ,  offsetY-startY)];
        vLine6.backgroundColor = CXLineColor;
        [_contentView addSubview:vLine6];

        
        
        
        
    }
    return _contentView;
}

#pragma mark - private method

- (void)updateInfoViewHeight{
    CGFloat labelHeight = [_briefLabel sizeThatFits:CGSizeMake(_briefLabel.frame.size.width, MAXFLOAT)].height;
    NSNumber *count = @((labelHeight) / _briefLabel.font.lineHeight);
    if([count integerValue]>1){
        _infoView.frame = CGRectMake(0, 0, CXScreenWidth, 160);
        [_briefLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(30);
            make.centerY.mas_equalTo(_infoView.mas_bottom).mas_offset(-30);
        }];
    }
}

- (void)clickMessage{
    [self.navigationController pushViewController:[InformViewController controller] animated:YES];
}

- (void)clickLogin{
    [self presentViewController:[[UINavigationController alloc] initWithRootViewController:[LoginViewController controller]] animated:YES completion:nil];
}

- (void)clickInfo{
    
    [self.navigationController pushViewController:[UserInfoViewController controller] animated:YES];

}

- (void)clickSet{
    
    SetViewController *set = [SetViewController controller];
    [self.navigationController pushViewController:set animated:YES];
}

#pragma mark - UIScrollView Delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGPoint offset = scrollView.contentOffset;
    if(offset.y<0){

        [_infoBgView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(scrollView.contentOffset.y);
            make.height.mas_equalTo(-scrollView.contentOffset.y);
        }];
    }
}

#pragma  mark - private method

- (void)gotoCommonView:(NSString *)title  url:(NSString *)url{
    CXBaseWebViewController *webViewController = [CXBaseWebViewController controller];
    webViewController.title = title;
    webViewController.url = url;
    [self.navigationController pushViewController:webViewController animated:YES];
}

- (void)gotoAuthCommonView:(NSString *)title  url:(NSString *)url{
    if(![[JWLocalUser instance] isAuthorized]){
        [ToastView showErrorWithStaus:@"请先在个人中心授权教务网登陆"];
        return;
    }
    CXBaseWebViewController *webViewController = [CXBaseWebViewController controller];
    webViewController.title = title;
    webViewController.url = url;
    [self.navigationController pushViewController:webViewController animated:YES];
}


- (void)gotoMyCourseTable{
    [self gotoAuthCommonView:@"我的课表" url:JWURLMyCourseTable]; 
}

- (void)gotoMyExam{
    [self gotoAuthCommonView:@"考试安排" url:JWURLMyExamQuery];
}

- (void)gotoMyScore{
    [self gotoAuthCommonView:@"我的成绩" url:JWURLMyScore];
}

- (void)gotoMyScorePoint{
    [self gotoAuthCommonView:@"我的绩点" url:JWURLMyScorePoint];
}

- (void)gotoMyBookInfo{
    [self gotoAuthCommonView:@"借书查询" url:JWURLMyBookInfo];
}

- (void)gotoMyTuition{
    [self gotoAuthCommonView:@"学费查询" url:JWURLMyTuition];
}




- (void)gotoStudentService{
    if(![[JWLocalUser instance] isAuthorized]){
        [ToastView showErrorWithStaus:@"请先在个人中心授权教务网登陆"];
        return;
    }
    NSString *url = [JWURLStudentService stringByReplacingOccurrencesOfString:@"131340126" withString:[JWLocalUser instance].JWUsername];
    [self gotoCommonView:@"学工服务" url:url];
}

- (void)gotoSchoolLecture{
    [self gotoCommonView:@"校园讲座" url:JWURLSchoolLecture];
}

- (void)gotoYellowPages{
    [self gotoCommonView:@"电话黄页" url:JWURLPhoneYellowPages];
}

- (void)gotoFreeClassroom{
    [self gotoCommonView:@"空余教室" url:JWURLFreeClassroom];
}

- (void)gotoEmployment{
     [self gotoCommonView:@"就业服务" url:JWURLEmployment];
}

- (void)gotoBookFind{
    [self gotoCommonView:@"书籍查询" url:JWURLBookFind];
}



- (void)gotoSchoolScenery{
    SchoolSceneryViewController *school = [SchoolSceneryViewController controller];
    school.url = JWURLSchoolScenery;
    [self.navigationController pushViewController:school animated:YES];
}









@end
