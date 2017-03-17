//
//  RateView.m
//  xbsz
//
//  Created by 陈鑫 on 17/3/17.
//  Copyright © 2017年 lotus. All rights reserved.
//

#import "RateView.h"
#import "CWStarRateView.h"


@interface RateView ()

@property (nonatomic, strong) CWStarRateView *startRateView;

@property (nonatomic, strong) UILabel *descriptionLabel;

@property (nonatomic, strong) UITextView *commentTextView;

@property (nonatomic, strong) UILabel *submitLabel;


@end

@implementation RateView

- (instancetype)init{
    if(self = [super init]){
        [self initRateView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self initRateView];
    }
    return self;
}


- (void)initRateView{
    self.frame = CGRectMake( 0, 0, CXScreenWidth/2 , 200);
    
    
    
}


@end
