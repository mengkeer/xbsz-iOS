//
//  CXBaseTableView.h
//  xbsz
//
//  Created by lotus on 20/02/2017.
//  Copyright © 2017 lotus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIScrollView+EmptyDataSet.h"

#define InitialLoadPage  1
//设置下拉加载风格
typedef NS_ENUM(NSInteger,LoadMoreFooterStyle){
    LoadMoreFooterStyleNone,        //不加载
    LoadMoreFooterStyleLoading,     //正常加载
    LoadMoreFooterStyleNoMore,      //没有更多数据
};


typedef NS_ENUM(NSInteger,LoadResultStatus){
    LoadResultStatusOK = 0,      //正常加载
    LoadResultStatusNetWrong,    //网路错误,显示网络错误tips
    LoadResultStatusWrongWithOldData,     //加载失败,显示旧的数据
    LoadResultStatusEmptyData                 //空数据
};


@protocol CXBaseTableViewDelegate <NSObject,UITableViewDelegate,UITableViewDataSource>

@optional

- (void)LoadDataAtPageIndex:(NSUInteger )pageIndex;

@end


@interface CXBaseTableView : UITableView<DZNEmptyDataSetDelegate,DZNEmptyDataSetSource>

@property (nonatomic, weak) id<CXBaseTableViewDelegate> baseDelegate;
@property (nonatomic, assign) BOOL showEmptyTips;

- (id)initWithFrame:(CGRect)frame enablePullRefresh:(BOOL)enable;

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style enablePullRefresh:(BOOL)enable;

@end
