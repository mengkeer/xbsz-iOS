//
//  CXBaseViewController.m
//  xbsz
//
//  Created by lotus on 2016/12/11.
//  Copyright © 2016年 lotus. All rights reserved.
//

#import "CXBaseViewController.h"

@interface CXBaseViewController ()

@property (nonatomic, strong) CADisplayLink *displayLink;
@property (nonatomic, assign) NSInteger scheduleTimes;
@property (nonatomic, assign) CFTimeInterval timestamp;

@end

@implementation CXBaseViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.navigationController.view sendSubviewToBack:self.navigationController.navigationBar];
    self.navigationController.navigationBar.translucent = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:CXBackGroundColor];
    
    //判断是否显示fps
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)setShowFps:(BOOL)showFps{
    _showFps = showFps;
    if(_showFps == YES){
        [self setupDisplayLink];
    }else{
        if(_displayLink)    [_displayLink removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    }
}


- (void)setupDisplayLink {
    //创建CADisplayLink，并添加到当前run loop的NSRunLoopCommonModes
    if(!_displayLink){
        _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(linkTicks:)];
    }
    if(!_fpsLabel){
        _fpsLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
        _fpsLabel.centerX = CXScreenWidth/2+50;
        _fpsLabel.textAlignment = NSTextAlignmentCenter;
//        _fpsLabel.backgroundColor = CXHexAlphaColor(0x000000, 0.4);
        _fpsLabel.backgroundColor = CXClearColor;
        _fpsLabel.textColor = CXGreenColor;
        _fpsLabel.text = @"60.0 FPS";
        _fpsLabel.font = CXSystemFont(12);
//        [_fpsLabel sizeToFit];
    }
    [self.view addSubview:_fpsLabel];
    [self.view bringSubviewToFront:_fpsLabel];
    [_displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)linkTicks:(CADisplayLink *)link{
    //执行次数
    _scheduleTimes ++;
    
    //当前时间戳
    if(_timestamp == 0){
        _timestamp = link.timestamp;
    }
    CFTimeInterval timePassed = link.timestamp - _timestamp;
    
    if(timePassed >= 1.f){
        //fps
        CGFloat fps = _scheduleTimes/timePassed;
//        printf("fps:%.1f, timePassed:%f\n", fps, timePassed);
        _fpsLabel.text = [NSString stringWithFormat:@"%.1f FPS",fps];
        
        //reset
        _timestamp = link.timestamp;
        _scheduleTimes = 0;
    }
}


-(UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait ;
}

- (BOOL)shouldAutorotate{
    return NO;
}

-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    return UIInterfaceOrientationPortrait;
}




@end
