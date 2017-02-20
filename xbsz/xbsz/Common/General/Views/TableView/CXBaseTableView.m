//
//  CXBaseTableView.m
//  xbsz
//
//  Created by lotus on 20/02/2017.
//  Copyright © 2017 lotus. All rights reserved.
//

#import "CXBaseTableView.h"

@interface CXBaseTableView ()

@property (nonatomic, assign) BOOL pullRefreshEnabled;      //是否允许上拉刷新




@end

@implementation CXBaseTableView

- (id)initWithFrame:(CGRect)frame enablePullRefresh:(BOOL)enable{
    self = [super initWithFrame:frame style:UITableViewStylePlain];
    if(self){
        _pullRefreshEnabled = enable;
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style enablePullRefresh:(BOOL)enable{
    self = [super initWithFrame:frame style:style];
    if(self){
        _pullRefreshEnabled = enable;
        self.showEmptyTips = NO;
    }
    return self;
}

- (void)initBaseTableView{
    self.emptyDataSetSource = self;
    self.emptyDataSetDelegate = self;
}

- (void)setBaseDelegate:(id<CXBaseTableViewDelegate>)baseDelegate{
    _baseDelegate = baseDelegate;
    self.delegate = baseDelegate;
    self.dataSource = baseDelegate;
}




#pragma mark DZNEmptyDataSetDelegate

- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView{
    return _showEmptyTips;
}

- (void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view{
    CXLog(@"点击了默认空白页");
}


#pragma DZNEmptyDataSetDataSource

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{
    return [UIImage imageNamed:@"empty_placeholder"];
}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView{
    NSString *text = @"Please Allow Photo Access";
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:18.0f],
                                 NSForegroundColorAttributeName: [UIColor darkGrayColor]};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView{
    NSString *text = @"This allows you to share photos from your library and save photos to your camera roll.";
    
    NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    paragraph.alignment = NSTextAlignmentCenter;
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:14.0f],
                                 NSForegroundColorAttributeName: [UIColor lightGrayColor],
                                 NSParagraphStyleAttributeName: paragraph};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}


- (CAAnimation *)imageAnimationForEmptyDataSet:(UIScrollView *)scrollView{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath: @"transform"];
    
    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    animation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI_2, 0.0, 0.0, 1.0)];
    
    animation.duration = 0.25;
    animation.cumulative = YES;
    animation.repeatCount = MAXFLOAT;
    
    return animation;
}

- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView{
    return -self.tableHeaderView.frame.size.height/2.0f;
}

- (CGFloat)spaceHeightForEmptyDataSet:(UIScrollView *)scrollView{
    return 20.0f;
}






@end
