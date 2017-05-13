//
//  SetViewController.m
//  xbsz
//
//  Created by 陈鑫 on 16/12/15.
//  Copyright © 2016年 lotus. All rights reserved.
//

#import "SetViewController.h"
#import "SetItemTableViewCell.h"
#import <AudioToolbox/AudioToolbox.h>
#import "AppUtil.h"

static NSString *cellArrowId = @"SetItemArrowCellId";
static NSString *cellSwitchId = @"cellSwitchCellId";
static NSString *cellDetailTextId  = @"cellDetailTextId";
static NSString *cellTextAndArrowId = @"cellTextAndArrowId";

@interface SetViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation SetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置";
    self.view.backgroundColor = CXBackGroundColor;
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, CXScreenWidth, CXScreenHeight-64.f)];
    [self.contentView addSubview:_tableView];
    _tableView.contentSize = CGSizeMake(CXScreenWidth, CXScreenHeight+300);
    _tableView.backgroundColor = CXBackGroundColor;
    _tableView.delegate = self;
    _tableView.separatorColor = CXLineColor;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.dataSource = self;
    
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, CXScreenWidth, CXScreenHeight+300) byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(CXTopCornerRadius, CXTopCornerRadius)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = CGRectMake(0, 0, CXScreenWidth, CXScreenHeight+400);
    maskLayer.path = maskPath.CGPath;
    _tableView.layer.mask = maskLayer;

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - UITableView delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(section != 0){
        return 20.f;
    }
    return 0.001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001f;
}
- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section {
    view.tintColor = CXBackGroundColor;
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    view.tintColor = CXBackGroundColor;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.section == 1){
        if(indexPath.row == 2){
            [self selectFont];
            return;
        }
        if(indexPath.row == 3){
            [self cleanCache];
            return;
        }
    }else if(indexPath.section == 2){
        if(indexPath.row == 1){
            
        }
    }
    
}


#pragma mark - UITableView dataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section == 0)    return 2;
    else if(section == 1)   return 4;
    else if(section == 2){
        if([AppUtil isAfterTimeNode])   return 4;
        else return 2;
    }
    else if(section == 3)   return 4;
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SetItemTableViewCell *cell;
    if(indexPath.section == 0){
        
        if(indexPath.row == 0){
            cell = [tableView dequeueReusableCellWithIdentifier:cellSwitchId];
            if(!cell){
                cell = [[SetItemTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellSwitchId];
            }
            [cell updateCell:@"音效" detailText:nil type:SetItemTypeSwitch iconImageName:@"set_sound"];
            [cell setSwitched:[CXUserDefaults instance].isAudioOpen changed:^(BOOL isOpen) {
                [CXUserDefaults instance].isAudioOpen = isOpen;
            }];
        }else{
            cell = [tableView dequeueReusableCellWithIdentifier:cellSwitchId];
            if(!cell){
                cell = [[SetItemTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellSwitchId];
            }
            [cell updateCell:@"震动" detailText:nil type:SetItemTypeSwitch iconImageName:@"set_shake"];
            [cell setSwitched:[CXUserDefaults instance].isShakeOpen changed:^(BOOL isOpen) {
                [CXUserDefaults instance].isShakeOpen = isOpen;;
                if(isOpen){
                    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
                }
            }];
        }
        
    }else if(indexPath.section == 1){
        if(indexPath.row == 0){
            cell = [tableView dequeueReusableCellWithIdentifier:cellArrowId];
            if(!cell){
                cell = [[SetItemTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellArrowId];
            }
            [cell updateCell:@"主题选择" detailText:nil type:SetItemTypeArrow iconImageName:@"set_theme"];
        }else if(indexPath.row == 1){
            cell = [tableView dequeueReusableCellWithIdentifier:cellArrowId];
            if(!cell){
                cell = [[SetItemTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellArrowId];
            }
            [cell updateCell:@"做题背景" detailText:nil type:SetItemTypeArrow iconImageName:@"set_bg"];
        }else if(indexPath.row == 2){
            cell = [tableView dequeueReusableCellWithIdentifier:cellTextAndArrowId];
            if(!cell){
                cell = [[SetItemTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellTextAndArrowId];
            }
            [cell updateCell:@"字体大小" detailText:[CXUserDefaults instance].sizeDescription type:SetItemTypeTextAndArrow iconImageName:@"set_font"];
        }else if(indexPath.row == 3){
            cell = [tableView dequeueReusableCellWithIdentifier:cellTextAndArrowId];
            if(!cell){
                cell = [[SetItemTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellTextAndArrowId];
            }
            YYImageCache *cache = [YYWebImageManager sharedManager].cache;
            NSString *num = [NSString stringWithFormat:@"%.2lfM",cache.diskCache.totalCost/(1024.0*1024.0)];
            [cell updateCell:@"清除缓存" detailText:num type:SetItemTypeTextAndArrow iconImageName:@"set_clear"];
        }
    }else if(indexPath.section == 2){
        if(indexPath.row == 0){
            cell = [tableView dequeueReusableCellWithIdentifier:cellArrowId];
            if(!cell){
                cell = [[SetItemTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellArrowId];
            }
            [cell updateCell:@"关于「学霸思政APP」" detailText:nil type:SetItemTypeArrow iconImageName:@"set_about"];
        }else if(indexPath.row == 1){
            cell = [tableView dequeueReusableCellWithIdentifier:cellArrowId];
            if(!cell){
                cell = [[SetItemTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellArrowId];
            }
            [cell updateCell:@"反馈与建议" detailText:nil type:SetItemTypeArrow iconImageName:@"set_feedback"];
        }else if(indexPath.row == 2){
            cell = [tableView dequeueReusableCellWithIdentifier:cellArrowId];
            if(!cell){
                cell = [[SetItemTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellArrowId];
            }
            [cell updateCell:@"友情打赏" detailText:nil type:SetItemTypeArrow iconImageName:@"set_smile"];
        }else{
            cell = [tableView dequeueReusableCellWithIdentifier:cellArrowId];
            if(!cell){
                cell = [[SetItemTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellArrowId];
            }
            [cell updateCell:@"给我好评" detailText:nil type:SetItemTypeArrow iconImageName:@"set_good"];
        }
        
    }else if(indexPath.section == 3){
        if(indexPath.row == 0){
            cell = [tableView dequeueReusableCellWithIdentifier:cellDetailTextId];
            if(!cell){
                cell = [[SetItemTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellDetailTextId];
            }
            [cell updateCell:@"当前版本" detailText:@"V1.4" type:SetItemTypeDetailText iconImageName:@"set_version"];
        }else if(indexPath.row == 1){
            cell = [tableView dequeueReusableCellWithIdentifier:cellDetailTextId];
            if(!cell){
                cell = [[SetItemTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellDetailTextId];
            }
            [cell updateCell:@"题库版本" detailText:@"2016-12-16" type:SetItemTypeDetailText iconImageName:@"set_tiku_version"];
        }else if(indexPath.row == 2){
            cell = [tableView dequeueReusableCellWithIdentifier:cellArrowId];
            if(!cell){
                cell = [[SetItemTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellArrowId];
            }
            [cell updateCell:@"更新说明" detailText:nil type:SetItemTypeArrow iconImageName:@"set_updateInfo"];
        }else{
            cell = [tableView dequeueReusableCellWithIdentifier:cellArrowId];
            if(!cell){
                cell = [[SetItemTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellArrowId];
            }
            [cell updateCell:@"检查更新" detailText:nil type:SetItemTypeArrow iconImageName:@"set_check"];
        }
    }else{
        
        NSString *cellId = @"NormalCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        cell.contentView.backgroundColor = CXBackGroundColor;
        return cell;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat sectionHeaderHeight = 20;
    if (scrollView.contentOffset.y <= sectionHeaderHeight && scrollView.contentOffset.y> 0) {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    }else{
        if(scrollView.contentOffset.y >= sectionHeaderHeight){
            scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
        }
    }
}

#pragma  mark - 处理事件

- (void)selectFont{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *male = [UIAlertAction actionWithTitle:@"小号" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [CXUserDefaults instance].questionFontSize = 12;
        [_tableView reloadRow:2 inSection:1 withRowAnimation:UITableViewRowAnimationFade];
    }];
    [alert addAction:male];
    
    UIAlertAction *female = [UIAlertAction actionWithTitle:@"中号" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [CXUserDefaults instance].questionFontSize = 15;
        [_tableView reloadRow:2 inSection:1 withRowAnimation:UITableViewRowAnimationFade];
    }];
    [alert addAction:female];
    
    
    UIAlertAction *unknown = [UIAlertAction actionWithTitle:@"大号" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [CXUserDefaults instance].questionFontSize = 18;
        [_tableView reloadRow:2 inSection:1 withRowAnimation:UITableViewRowAnimationFade];
    }];
    [alert addAction:unknown];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:cancel];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)cleanCache{
    YYImageCache *cache = [YYWebImageManager sharedManager].cache;
    CGFloat nowCahce = cache.diskCache.totalCost;
    if (nowCahce <= 0.00001) {
        [ToastView showErrorWithStaus:@"没有缓存"];
        return;
    }
    [ToastView showProgressBar:@"正在清理"];
    [cache.diskCache removeAllObjects];
//
    nowCahce = cache.diskCache.totalCost;
    if(nowCahce < 0.02){
        [ToastView showBlackSuccessWithStaus:@"清理完成" delay:1.2];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [_tableView reloadRow:3 inSection:1 withRowAnimation:UITableViewRowAnimationFade];
        });
    }
    
//    [cache.diskCache removeAllObjectsWithProgressBlock:^(int removedCount, int totalCount) {
//        if(removedCount/removedCount >0.98){
//            [ToastView showBlackSuccessWithStaus:@"清理完成"];
//            [_tableView reloadRow:3 inSection:1 withRowAnimation:UITableViewRowAnimationFade];
//        }
//        [ToastView showProgressBar:removedCount/totalCount status:@"正在清理"];
//    } endBlock:^(BOOL error) {
//        [ToastView showBlackSuccessWithStaus:@"清理完成"];
//        [_tableView reloadRow:3 inSection:1 withRowAnimation:UITableViewRowAnimationFade];
//    }];
}



@end
