//
//  ChapterHeaderView.h
//  xbsz
//
//  Created by lotus on 2017/4/11.
//  Copyright © 2017年 lotus. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol  ChapterHeaderDelegate <NSObject>

- (void)foldHeaderInSection:(NSInteger)section;

@end

@interface ChapterHeaderView : UITableViewHeaderFooterView

@property (nonatomic, copy) NSString *title;

@property (nonatomic, assign) NSInteger section;

@property (nonatomic, assign) BOOL isFolded;

@property (nonatomic, weak) id<ChapterHeaderDelegate> delegate;

- (void)updateSectionHeader:(NSString *)title section:(NSInteger)section canFold:(BOOL)canFold;

@end
