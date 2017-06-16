//
//  PhotoBrowserViewController.h
//  SuperM
//
//  Created by hanx on 16/8/29.
//  Copyright © 2016年 hanx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoBrowserViewController : UIViewController
@property (nonatomic,assign) NSInteger index;

@property (nonatomic,strong) NSArray *arrayImageStr;

+ (instancetype)photoBrowserWithSelectedIndex:(NSInteger)selectedIndex urls:(NSArray<NSString *> *)urls parentImageViews:(NSArray<UIImageView *> *)parentImageViews;
@end
