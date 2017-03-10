//
//  ShareToolBarView.m
//  xbsz
//
//  Created by 陈鑫 on 17/3/9.
//  Copyright © 2017年 lotus. All rights reserved.
//

#import "MoreToolBarView.h"

static NSString *cellID = @"CollectionCellID";


@interface MoreToolBarView ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, copy) ToolBarActionBlock actionBlock;

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) UILabel *cancleLabel;

@property (nonatomic, copy) NSArray *topImages;             //第一层图片名称

@property (nonatomic, copy) NSArray *bottomImages;




@end

@implementation MoreToolBarView

- (instancetype)init{
    if(self = [super init]){
        [self initMoreToolBar];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self initMoreToolBar];
    }
    return self;
}


- (void)initMoreToolBar{
    
    [self addSubview:self.collectionView];
    

    [self addSubview:self.cancleLabel];
    
    
    
    
}

#pragma mark - getter/setter

- (UICollectionView *)topCollectionView{
    if(!_collectionView){
        _collectionView = [[UICollectionView alloc] init];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
    }
    return _collectionView;
}






-(void)updateUIWithModel:(id)model action:(ToolBarActionBlock)actionBlock{
    _actionBlock = actionBlock;
}

#pragma mark - UICollectionDelegate



#pragma mark - UICollectionDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if(section == 0)    return [_topImages count];
    else    return [_bottomImages count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    cell.backgroundColor = CXRedColor;
    return cell;
}


@end
