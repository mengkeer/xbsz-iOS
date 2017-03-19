//
//  ShareToolView.m
//  xbsz
//
//  Created by lotus on 19/03/2017.
//  Copyright © 2017 lotus. All rights reserved.
//

#import "ShareToolBarView.h"
#import "ToolBarCell.h"

static NSString *cellID = @"CollectionCellID";

static int height = 170;            //UICollectionView的高度
static int gap = 20;                   //行列间距
static int cellWidth = 60;              //Cell宽度
static int cellHeight = 90;             //Cell高度

static ShareToolBarView *sharedObj;


@interface ShareToolBarView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, copy) ShareToolBarActionBlock actionBlock;

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) UILabel *cancleLabel;

@property (nonatomic, strong) NSMutableArray *cellImageNames;             //第一层图片名称

@property (nonatomic, strong) NSMutableArray *cellTitles;

@end

@implementation ShareToolBarView

+ (instancetype)instance{
    @synchronized (self){
        if (sharedObj == nil){
            if (sharedObj == nil)
                sharedObj = [[ShareToolBarView alloc] initWithFrame:CGRectZero];
        }
    }
    return sharedObj;
}

- (instancetype)init{
    return [self initWithFrame:CGRectZero];
}

- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self initShareToolBar];
    }
    return self;
}

- (void)layoutSubviews{
    CGFloat time = 1.5;
    for(ToolBarCell *cell in _collectionView.subviews){
        CGPoint point = cell.center;
        CGPoint newPoint = CGPointMake(point.x, point.y-90);
        cell.center = newPoint;
        time += 0.1;
        [UIView animateWithDuration:time delay:0 usingSpringWithDamping:0.3f initialSpringVelocity:21.f options:0 animations:^{
            cell.center = point;
        } completion:^(BOOL finished) {
            
        }];
    }
}

- (void)initShareToolBar{
    self.backgroundColor = CXClearColor;
    self.frame = CGRectMake(0, 0, CXScreenWidth, height);
    self.center = CGPointMake(CXScreenWidth/2, CXScreenHeight + height/2);
    
    _cellImageNames = [NSMutableArray arrayWithObjects:@"share_pyq",@"share_wechat",@"share_qq",@"share_qzone",@"share_weibo",@"share_system", nil];
    _cellTitles = [NSMutableArray arrayWithObjects:@"微信朋友圈",@"微信好友",@"手机QQ",@"QQ空间",@"新浪微博",@"系统分享",nil];
    
    [self addSubview:self.collectionView];
    [self addSubview:self.cancleLabel];
    [_cancleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self);
        make.height.mas_equalTo(50);
    }];
    
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self);
        make.bottom.mas_equalTo(_cancleLabel.mas_top);
        make.top.mas_equalTo(self.mas_top);
    }];
    [_collectionView reloadData];
}


#pragma mark - public method

- (void)showInView:(UIView *)view{
    
    UIView *backView = [[UIView alloc] init];
    backView.backgroundColor = CXBlackColor;
    backView.alpha = 0.0;
    backView.tag = 101;
    backView.frame = view.frame;
    @weakify(self);
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
        [weak_self dismissInView:view];
    }];
    [backView addGestureRecognizer:tap];
    
    [view addSubview:backView];
    [view addSubview:self];
    self.center = CGPointMake(CXScreenWidth/2, CXScreenHeight + height/2);;
    
    [UIView animateWithDuration:0.3 animations:^{
        backView.alpha = 0.2;
        self.center = CGPointMake(CXScreenWidth/2, CXScreenHeight-height/2);
    }];
 
}

- (void)dismissInView:(UIView *)view{
    
    for (UIView *v in view.subviews) {
        if ([v class] == [self class] || v.tag == 101 ){
            [v removeFromSuperview];
        }
    }
}

#pragma mark - getter/setter

- (UICollectionView *)collectionView{
    if(!_collectionView){
        UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, CXScreenWidth, height) collectionViewLayout:layout];
        _collectionView.backgroundColor = CXBackGroundColor;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.alwaysBounceHorizontal = YES;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        [_collectionView registerClass:[ToolBarCell class] forCellWithReuseIdentifier:cellID];
    }
    return _collectionView;
}

- (UILabel *)cancleLabel{
    if(!_cancleLabel){
        _cancleLabel = [[UILabel alloc] init];
        _cancleLabel.text = @"取消";
        _cancleLabel.font = CXSystemFont(15);
        _cancleLabel.textAlignment = NSTextAlignmentCenter;
        _cancleLabel.backgroundColor = CXWhiteColor;
        _cancleLabel.textColor = CXHexAlphaColor(0x000000, 0.9);
        _cancleLabel.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender){
            if(_actionBlock)    _actionBlock(ShareToolBarActionTyepCancel);
        }];
        [_cancleLabel addGestureRecognizer:tap];
    }
    return _cancleLabel;
}


- (void)updateUIWithModel:(CampusNote *)model action:(ShareToolBarActionBlock)actionBlock{
    _collectionView.contentOffset = CGPointMake(0, 0);
    _actionBlock = actionBlock;
}


#pragma mark - UICollectionDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if(!_actionBlock)   return;
    if(indexPath.row == 0){
        _actionBlock(ShareToolBarActionTyepPYQ);
    }else if(indexPath.row == 1){
        _actionBlock(ShareToolBarActionTyepWechat);
    }else if(indexPath.row == 2){
        _actionBlock(ShareToolBarActionTyepQQ);
    }else if(indexPath.row == 3){
        _actionBlock(ShareToolBarActionTyepQzone);
    }else if(indexPath.row == 4){
        _actionBlock(ShareToolBarActionTyepWeibo);
    }else if(indexPath.row == 5){
        _actionBlock(ShareToolBarActionTyepSystem);
    }
}


#pragma mark - UICollctionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(cellWidth , cellHeight);
}

//最小行间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return gap;
}

//最小列间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return gap;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(gap, gap, 10, gap);
}

#pragma mark - UICollectionDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return  [_cellImageNames count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ToolBarCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    [cell updateCellWithImageName:[_cellImageNames objectAtIndex:indexPath.row]
                            title:[_cellTitles objectAtIndex:indexPath.row]];
    return cell;
}


- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath{
    return NO;
}

@end
