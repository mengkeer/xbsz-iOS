//
//  CourseCollectionViewCell.h
//  xbsz
//
//  Created by 陈鑫 on 17/3/13.
//  Copyright © 2017年 lotus. All rights reserved.
//

#import <UIKit/UIKit.h>

//注 图片比例为3:4  整个cell的高度为图片高度+40(两个label的高度)

#define imageWidth (CX_IS_IPHONE6PLUS ? 180 : CX_IS_IPHONE6 ? 165 : 140)
#define imageHeight (CX_IS_IPHONE6PLUS ? 108 : CX_IS_IPHONE6 ? 99 : 84)
#define cellWidth   imageWidth
#define cellHeight   (imageHeight + 28)


@interface ExerciseCollectionViewCell : UICollectionViewCell

- (void)updateCellWithModel:(id)model;

- (void)registerTouch:(id)delegate;

@end
