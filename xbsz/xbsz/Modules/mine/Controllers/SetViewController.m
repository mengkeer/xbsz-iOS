//
//  SetViewController.m
//  xbsz
//
//  Created by 陈鑫 on 16/12/15.
//  Copyright © 2016年 lotus. All rights reserved.
//

#import "SetViewController.h"
#import "SetItemView.h"




static NSString *cellArrowId = @"SetItemArrowCellId";
static NSString *cellSwitchId = @"cellSwitchCellId";
static NSString *cellDetailTextId  = @"cellDetailTextId";
static NSString *cellTextAndArrowId = @"cellTextAndArrowId";

@interface SetViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>

@end

@implementation SetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = CXBackGroundColor;
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, CXScreenWidth, CXScreenHeight-64.f)];
    [self.contentView addSubview:tableView];
    tableView.contentSize = CGSizeMake(CXScreenWidth, CXScreenHeight+200);
    tableView.backgroundColor = CXBackGroundColor;
    tableView.delegate = self;
    tableView.separatorColor = CXLineColor;
    tableView.showsVerticalScrollIndicator = NO;
    tableView.dataSource = self;
    
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, CXScreenWidth, CXScreenHeight+200) byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(CXTopCornerRadius, CXTopCornerRadius)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = CGRectMake(0, 0, CXScreenWidth, CXScreenHeight+200);
    maskLayer.path = maskPath.CGPath;
    tableView.layer.mask = maskLayer;

    
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
    
    
    
}


#pragma mark - UITableView dataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section == 0)    return 2;
    else if(section == 1)   return 6;
    else if(section == 2)   return 4;
    else if(section == 3)   return 4;
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}


//
//static NSString *cellArrowId = @"SetItemArrowCellId";
//static NSString *cellSwitchId = @"cellSwitchCellId";
//static NSString *cellDetailTextId  = @"cellDetailTextId";
//static NSString *cellTextAndArrowId = @"cellTextAndArrowId";

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell;
    if(indexPath.section == 0){
        
        if(indexPath.row == 0){
            cell = [tableView dequeueReusableCellWithIdentifier:cellSwitchId];
            if(cell)    return cell;
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellSwitchId];
            SetItemView *item = [[SetItemView alloc] initWithFrame:CGRectMake(0, 0, CXScreenWidth, 45)];
            [item setTitle:@"音效" andDetailText:nil andType:SetItemTypeSwitch andImage:[UIImage imageNamed:@"set_sound"]];
            [cell.contentView addSubview:item];
        }else{
            cell = [tableView dequeueReusableCellWithIdentifier:cellSwitchId];
            if(cell)    return cell;
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellSwitchId];
            SetItemView *item = [[SetItemView alloc] initWithFrame:CGRectMake(0, 0, CXScreenWidth, 45)];
            [item setTitle:@"震动" andDetailText:nil andType:SetItemTypeSwitch andImage:[UIImage imageNamed:@"set_shake"]];
            [cell.contentView addSubview:item];
        }
        
    }else if(indexPath.section == 1){
        
        if(indexPath.row == 0){
            cell = [tableView dequeueReusableCellWithIdentifier:cellArrowId];
            if(cell)    return cell;
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellArrowId];
            SetItemView *item = [[SetItemView alloc] initWithFrame:CGRectMake(0, 0, CXScreenWidth, 45)];
            [item setTitle:@"主题选择" andDetailText:nil andType:SetItemTypeArrow andImage:[UIImage imageNamed:@"set_theme"]];
            [cell.contentView addSubview:item];
        }else if(indexPath.row == 1){
            cell = [tableView dequeueReusableCellWithIdentifier:cellTextAndArrowId];
            if(cell)    return cell;
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellTextAndArrowId];
            SetItemView *item = [[SetItemView alloc] initWithFrame:CGRectMake(0, 0, CXScreenWidth, 45)];
            [item setTitle:@"翻页效果" andDetailText:@"左右滑动" andType:SetItemTypeTextAndArrow andImage:[UIImage imageNamed:@"set_page"]];
            [cell.contentView addSubview:item];
        }else if(indexPath.row == 2){
            cell = [tableView dequeueReusableCellWithIdentifier:cellArrowId];
            if(cell)    return cell;
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellArrowId];
            SetItemView *item = [[SetItemView alloc] initWithFrame:CGRectMake(0, 0, CXScreenWidth, 45)];
            [item setTitle:@"做题背景" andDetailText:nil andType:SetItemTypeArrow andImage:[UIImage imageNamed:@"set_bg"]];
            [cell.contentView addSubview:item];
        }else if(indexPath.row == 3){
            cell = [tableView dequeueReusableCellWithIdentifier:cellTextAndArrowId];
            if(cell)    return cell;
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellTextAndArrowId];
            SetItemView *item = [[SetItemView alloc] initWithFrame:CGRectMake(0, 0, CXScreenWidth, 45)];
            [item setTitle:@"字体大小" andDetailText:@"中" andType:SetItemTypeTextAndArrow andImage:[UIImage imageNamed:@"set_font"]];
            [cell.contentView addSubview:item];
        }else if(indexPath.row == 4){
            cell = [tableView dequeueReusableCellWithIdentifier:cellTextAndArrowId];
            if(cell)    return cell;
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellTextAndArrowId];
            SetItemView *item = [[SetItemView alloc] initWithFrame:CGRectMake(0, 0, CXScreenWidth, 45)];
            [item setTitle:@"错题自动删除次数" andDetailText:@"2次" andType:SetItemTypeTextAndArrow andImage:[UIImage imageNamed:@"set_delete"]];
            [cell.contentView addSubview:item];
        }else if(indexPath.row == 5){
            cell = [tableView dequeueReusableCellWithIdentifier:cellDetailTextId];
            if(cell)    return cell;
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellDetailTextId];
            SetItemView *item = [[SetItemView alloc] initWithFrame:CGRectMake(0, 0, CXScreenWidth, 45)];
            [item setTitle:@"清除缓存" andDetailText:@"12.3M" andType:SetItemTypeTextAndArrow andImage:[UIImage imageNamed:@"set_clear"]];
            [cell.contentView addSubview:item];
        }
        
    
    }else if(indexPath.section == 2){
        
        if(indexPath.row == 0){
            cell = [tableView dequeueReusableCellWithIdentifier:cellArrowId];
            if(cell)    return cell;
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellArrowId];
            SetItemView *item = [[SetItemView alloc] initWithFrame:CGRectMake(0, 0, CXScreenWidth, 45)];
            [item setTitle:@"关于「学霸思政APP」" andDetailText:nil andType:SetItemTypeArrow andImage:[UIImage imageNamed:@"set_about"]];
            [cell.contentView addSubview:item];
        }else if(indexPath.row == 1){
            cell = [tableView dequeueReusableCellWithIdentifier:cellArrowId];
            if(cell)    return cell;
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellArrowId];
            SetItemView *item = [[SetItemView alloc] initWithFrame:CGRectMake(0, 0, CXScreenWidth, 45)];
            [item setTitle:@"给我好评" andDetailText:nil andType:SetItemTypeArrow andImage:[UIImage imageNamed:@"set_good"]];
            [cell.contentView addSubview:item];
        }else if(indexPath.row == 2){
            cell = [tableView dequeueReusableCellWithIdentifier:cellArrowId];
            if(cell)    return cell;
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellArrowId];
            SetItemView *item = [[SetItemView alloc] initWithFrame:CGRectMake(0, 0, CXScreenWidth, 45)];
            [item setTitle:@"反馈与建议" andDetailText:nil andType:SetItemTypeArrow andImage:[UIImage imageNamed:@"set_feedback"]];
            [cell.contentView addSubview:item];
        }else{
            cell = [tableView dequeueReusableCellWithIdentifier:cellArrowId];
            if(cell)    return cell;
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellArrowId];
            SetItemView *item = [[SetItemView alloc] initWithFrame:CGRectMake(0, 0, CXScreenWidth, 45)];
            [item setTitle:@"友情打赏" andDetailText:nil andType:SetItemTypeArrow andImage:[UIImage imageNamed:@"set_smile"]];
            [cell.contentView addSubview:item];
        }
        
    }else if(indexPath.section == 3){
        if(indexPath.row == 0){
            cell = [tableView dequeueReusableCellWithIdentifier:cellDetailTextId];
            if(cell)    return cell;
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellDetailTextId];
            SetItemView *item = [[SetItemView alloc] initWithFrame:CGRectMake(0, 0, CXScreenWidth, 45)];
            [item setTitle:@"当前版本" andDetailText:@"V1.4" andType:SetItemTypeDetailText andImage:[UIImage imageNamed:@"set_version"]] ;
            [cell.contentView addSubview:item];
        }else if(indexPath.row == 1){
            cell = [tableView dequeueReusableCellWithIdentifier:cellDetailTextId];
            if(cell)    return cell;
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellDetailTextId];
            SetItemView *item = [[SetItemView alloc] initWithFrame:CGRectMake(0, 0, CXScreenWidth, 45)];
            [item setTitle:@"题库版本" andDetailText:@"2016-12-16" andType:SetItemTypeDetailText andImage:[UIImage imageNamed:@"set_tiku_version"]];
            [cell.contentView addSubview:item];
        }else if(indexPath.row == 2){
            cell = [tableView dequeueReusableCellWithIdentifier:cellArrowId];
            if(cell)    return cell;
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellArrowId];
            SetItemView *item = [[SetItemView alloc] initWithFrame:CGRectMake(0, 0, CXScreenWidth, 45)];
            [item setTitle:@"更新说明" andDetailText:nil andType:SetItemTypeArrow andImage:[UIImage imageNamed:@"set_updateInfo"]];
            [cell.contentView addSubview:item];
        }else{
            cell = [tableView dequeueReusableCellWithIdentifier:cellDetailTextId];
            if(cell)    return cell;
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellDetailTextId];
            SetItemView *item = [[SetItemView alloc] initWithFrame:CGRectMake(0, 0, CXScreenWidth, 45)];
            [item setTitle:@"检查更新" andDetailText:nil andType:SetItemTypeArrow andImage:[UIImage imageNamed:@"set_check"]];
            [cell.contentView addSubview:item];
        }
    }else{
        
        NSString *cellId = @"NormalCell";
        cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        cell.contentView.backgroundColor = CXBackGroundColor;
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



@end
