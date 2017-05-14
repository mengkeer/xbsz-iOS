//
//  CXPage.h
//  xbsz
//
//  Created by lotus on 2017/5/12.
//  Copyright © 2017年 lotus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CXPage : NSObject

@property (nonatomic, assign) NSInteger currentPage; //current 当前分页
@property (nonatomic, assign) NSInteger pageSize; //size 每页显示资讯数
@property (nonatomic, assign) NSInteger count; //total_rows 资讯总条数
@property (nonatomic, assign) NSInteger totalPage; //total_pages 资讯总页数

@end
