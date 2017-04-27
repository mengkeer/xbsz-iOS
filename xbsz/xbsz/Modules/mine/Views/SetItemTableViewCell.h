//
//  SetItemView.h
//  xbsz
//
//  Created by 陈鑫 on 16/12/15.
//  Copyright © 2016年 lotus. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger, SetItemType) {
    SetItemTypeArrow,     //带右箭头  可指向下一级
    SetItemTypeSwitch,     //开关
    SetItemTypeDetailText,      //右侧为细小文字
    SetItemTypeTextAndArrow,
    SetItemTypeImageAndArrow        // 右侧为图片和箭头  特指用户头像设置一栏
};


@interface SetItemTableViewCell : UITableViewCell

- (void)updateCell:(NSString *)title
        detailText:(NSString *)detailText
              type:(SetItemType)type
     iconImageName:(NSString *)imageName;

//此方法需在setTitle方法后调用
- (void)setHeadImage:(NSString *)imageUrl;

@end
