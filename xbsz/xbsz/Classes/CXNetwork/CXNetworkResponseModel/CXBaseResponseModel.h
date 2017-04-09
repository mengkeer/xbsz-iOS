//
//  CXBaseResponseModel.h
//  xbsz
//
//  Created by lotus on 2017/4/8.
//  Copyright © 2017年 lotus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CXBaseResponseModel : NSObject

@property (nonatomic, assign) NSInteger  code;        // 请求结果码, 0表示成功, 其他表示失败
@property (nonatomic, strong) NSString * errMsg;   // 请求返回说明, 一般用于错误

@property (nonatomic, strong) NSDictionary *data;

@end
