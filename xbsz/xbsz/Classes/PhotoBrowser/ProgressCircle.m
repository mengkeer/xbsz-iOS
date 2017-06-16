//
//  ProgressCircle.m
//  SuperM
//
//  Created by hanx on 16/8/31.
//  Copyright © 2016年 hanx. All rights reserved.
//

#import "ProgressCircle.h"

@implementation ProgressCircle

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    if (rect.size.width == 0 || rect.size.height == 0) {
        return;
    }
    
    if (_progress >= 1.0) {
        return;
    }
    
    CGFloat radius = MIN(rect.size.width, rect.size.height) * 0.5;
    CGPoint center = CGPointMake(rect.size.width * 0.5, rect.size.height * 0.5);
    
    [[UIColor colorWithWhite:1 alpha:0.5] setStroke];
    
    CGFloat lineWidth = 2.0;
    UIBezierPath *borderPath = [UIBezierPath bezierPathWithArcCenter:center
                                                              radius:radius - lineWidth * 0.5
                                                          startAngle:0
                                                            endAngle:2 * M_PI
                                                           clockwise:YES];
    borderPath.lineWidth = lineWidth;
    [borderPath stroke];
    
    [[UIColor colorWithWhite:0 alpha:0.3] setFill];
    radius -= lineWidth * 2;
    UIBezierPath *trackPath = [UIBezierPath bezierPathWithArcCenter:center
                                                             radius:radius
                                                         startAngle:0
                                                           endAngle:2 * M_PI
                                                          clockwise:YES];
    [trackPath fill];
    
    [[UIColor colorWithWhite:1 alpha:0.5] set];
    
    CGFloat start = -M_PI_2;
    CGFloat end = start + self.progress * M_PI * 2;
    UIBezierPath *progressPath = [UIBezierPath bezierPathWithArcCenter:center
                                                                radius:radius
                                                            startAngle:start
                                                              endAngle:end
                                                             clockwise:YES];
    [progressPath addLineToPoint:center];
    [progressPath closePath];
    
    [progressPath fill];
}

-(void)setProgress:(CGFloat)progress{
    _progress = progress;
    [self setNeedsDisplay];
}

@end
