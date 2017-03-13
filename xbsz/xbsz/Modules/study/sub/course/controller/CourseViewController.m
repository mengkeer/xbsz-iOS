//
//  CourseViewController.m
//  xbsz
//
//  Created by lotus on 2016/12/30.
//  Copyright © 2016年 lotus. All rights reserved.
//

#import "CourseViewController.h"
#import "CourseCollectionViewCell.h"
#import "CourseSearchBar.h"
#import "Course.h"
#import "CourseList.h"

static int numberOfItems = 3;           //每行的cell个数

static NSString *const cellID = @"CollectionCellID";
static NSString *const headerCellID = @"CollectionHeaderCellID";

#define gap (CX_IS_IPHONE6PLUS ? 20 : 15)

@interface CourseViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) CourseSearchBar *searchBar;

@property (nonatomic, strong) CourseList  *courseList;


@end

@implementation CourseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.contentView addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(self.contentView);
        make.centerX.mas_equalTo(self.contentView.mas_centerX);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
    }];
    
    [self loadData];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)loadData{

    
    NSString *fileName = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"courses.json"];
    NSString *jsonStr = [NSString stringWithContentsOfFile:fileName encoding:NSUTF8StringEncoding error:nil];
    
    _courseList = [CourseList yy_modelWithJSON:jsonStr];

    
    
    [_collectionView reloadData];
    
    
    CXLog(@"开始加载校园动态");
}


#pragma mark - getter/setter

- (UICollectionView *)collectionView{
    if(!_collectionView){
        UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.backgroundColor = CXWhiteColor;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.alwaysBounceVertical = YES;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        [_collectionView registerClass:[CourseCollectionViewCell class] forCellWithReuseIdentifier:cellID];
        
        _collectionView.contentInset = UIEdgeInsetsMake(50, 0, 0, 0);
        
        [self.collectionView addSubview:self.searchBar];
        
//        _collectionView.contentOffset = CGPointMake(0, 0);
        
    
    }
    return _collectionView;
}
//
//- (void)viewDidLayoutSubviews{
//    _collectionView.contentOffset = CGPointMake(0, 0);
//}

- (void)viewWillLayoutSubviews{
    _collectionView.contentOffset = CGPointMake(0, 0);
}

- (CourseSearchBar *)searchBar{
    if(!_searchBar){
        _searchBar = [[CourseSearchBar alloc] initWithFrame:CGRectMake(gap, -30, CXScreenWidth-2*gap, 30)];
    }
    return _searchBar;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    CXLog(@"点击了第%ld行第%ld列",indexPath.section,indexPath.row);
}



#pragma mark - UICollctionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(cellWidth, cellHeight);
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
    return UIEdgeInsetsMake(gap, gap, 0, gap);
}

//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
//    return CGSizeMake(CXScreenWidth, 40);
//}

#pragma mark - UICollectionDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
//    NSInteger nums = [_courseList.courses count]/numberOfItems +1;
//    return [_courseList.courses count] % 3 == 0 ? nums-1 : nums;
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if([_courseList.courses count] > (section+1)*numberOfItems){
        return numberOfItems;
    }else{
        return [_courseList.courses count]%numberOfItems;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;{
    CourseCollectionViewCell *cell = (CourseCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    NSInteger index = (indexPath.section == 0 ? indexPath.row : (indexPath.section)*numberOfItems+indexPath.row);
    [cell updateCellWithModel:[_courseList.courses objectAtIndex:index]];
    return cell;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath{
    return NO;
}




@end
