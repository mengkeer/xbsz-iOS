//
//  PhotoViewController.h
//  SuperM
//
//  Created by hanx on 16/8/29.
//  Copyright © 2016年 hanx. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol PhotoViewControllerDelegate <NSObject>
@optional
-(void)imageDidClick;

@end

@interface PhotoViewController : UIViewController

@property (nonatomic,assign) NSInteger index;

@property (nonatomic,strong) UIImageView *imageView;

@property (nonatomic,weak) id<PhotoViewControllerDelegate> delegate;

- (instancetype)initWithImage:(NSString *)imageStr index:(NSInteger)index;
- (instancetype)initWithImage:(NSString *)imageStr index:(NSInteger)index placeHoldImage:(UIImage*)image;
@end
