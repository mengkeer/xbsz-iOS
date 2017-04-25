//
//  QuestionCollectionViewCell.h
//  xbsz
//
//  Created by lotus on 2017/4/25.
//  Copyright © 2017年 lotus. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol QuestionTableViewDelegate <NSObject>

@required

- (void)selectOption:(NSInteger)index;

@end

@interface QuestionCollectionViewCell : UICollectionViewCell

@property (nonatomic, weak) id<QuestionTableViewDelegate> selectDelegate;

@end
