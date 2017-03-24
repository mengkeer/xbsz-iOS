//
//  UserInfoViewController.m
//  xbsz
//
//  Created by 陈鑫 on 16/12/16.
//  Copyright © 2016年 lotus. All rights reserved.
//

#import "UserInfoViewController.h"
#import "SetItemView.h"
#import "UIViewController+Authorization.h"

static NSString *cellArrowId = @"SetItemArrowCellId";
static NSString *cellSwitchId = @"cellSwitchCellId";
static NSString *cellDetailTextId  = @"cellDetailTextId";
static NSString *cellTextAndArrowId = @"cellTextAndArrowId";
static NSString *cellImageAndArrowId = @"cellImageAndArrowId";

@interface UserInfoViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@end



@implementation UserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.view.backgroundColor = CXBackGroundColor;
    self.title = @"个人资料";
    
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, CXScreenWidth, CXScreenHeight-64.f)];
    [self.contentView addSubview:tableView];
    tableView.contentSize = CGSizeMake(CXScreenWidth, CXScreenHeight+400);
    tableView.backgroundColor = CXBackGroundColor;
    tableView.delegate = self;
    tableView.separatorColor = CXLineColor;
    tableView.showsVerticalScrollIndicator = NO;
    tableView.dataSource = self;
    
    //高度加400没有特别意思  只是为了保证高度足够高
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, CXScreenWidth, CXScreenHeight+400) byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(CXTopCornerRadius, CXTopCornerRadius)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = CGRectMake(0, 0, CXScreenWidth, CXScreenHeight+400);
    maskLayer.path = maskPath.CGPath;
    tableView.layer.mask = maskLayer;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - UITableView delegate


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0 && indexPath.row == 0)  return 100;
    return 45;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(section == 0 || section == 3)    return 0;
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001f;
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(nonnull UIView *)view forSection:(NSInteger)section{
     view.tintColor = CXBackGroundColor;
}

- (void)tableView:(UITableView *)tableView willDisplayFooterView:(nonnull UIView *)view forSection:(NSInteger)section{
     view.tintColor = CXBackGroundColor;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    
    if(indexPath.section == 3)  return ;
    if(indexPath.section == 0){
        switch (indexPath.row) {
            case 0:
                [self handleImagePicker];
                break;
            default:
                break;
        }
    }
    if(indexPath.section == 1){
        
    }
    
    if(indexPath.section == 2){
        
    }
    
}



#pragma mark - UITableView dataSource 

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section == 0)    return 8;
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell;
    if(indexPath.section == 0){
        
        if(indexPath.row == 0){
            cell = [tableView dequeueReusableCellWithIdentifier:cellImageAndArrowId];
            if(cell)    return cell;
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellImageAndArrowId];
            SetItemView *item = [[SetItemView alloc] initWithFrame:CGRectMake(0, 0, CXScreenWidth, 100)];
            [item setTitle:@"我的头像" andDetailText:nil andType:SetItemTypeImageAndArrow andImage:[UIImage imageNamed:@"set_head"]];
            [item setHeadImage:[UIImage imageNamed:@"avatar1.jpg"]];
            [cell.contentView addSubview:item];
        }else if(indexPath.row == 1){
            cell = [tableView dequeueReusableCellWithIdentifier:cellTextAndArrowId];
            if(cell)    return cell;
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellTextAndArrowId];
            SetItemView *item = [[SetItemView alloc] initWithFrame:CGRectMake(0, 0, CXScreenWidth, 45)];
            [item setTitle:@"昵称" andDetailText:@"空の境界" andType:SetItemTypeTextAndArrow andImage:[UIImage imageNamed:@"set_nick"]];
            [cell.contentView addSubview:item];
        }else if(indexPath.row == 2){
            cell = [tableView dequeueReusableCellWithIdentifier:cellTextAndArrowId];
            if(cell)    return cell;
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellTextAndArrowId];
            SetItemView *item = [[SetItemView alloc] initWithFrame:CGRectMake(0, 0, CXScreenWidth, 45)];
            [item setTitle:@"性别" andDetailText:@"男" andType:SetItemTypeTextAndArrow andImage:[UIImage imageNamed:@"set_sex"]];
            [cell.contentView addSubview:item];
        }else if(indexPath.row == 3){
            cell = [tableView dequeueReusableCellWithIdentifier:cellTextAndArrowId];
            if(cell)    return cell;
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellTextAndArrowId];
            SetItemView *item = [[SetItemView alloc] initWithFrame:CGRectMake(0, 0, CXScreenWidth, 45)];
            [item setTitle:@"邮箱" andDetailText:@"slotus@vip.qq.com" andType:SetItemTypeTextAndArrow andImage:[UIImage imageNamed:@"set_email"]];
            [cell.contentView addSubview:item];
        }else if(indexPath.row == 4){
            cell = [tableView dequeueReusableCellWithIdentifier:cellTextAndArrowId];
            if(cell)    return cell;
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellTextAndArrowId];
            SetItemView *item = [[SetItemView alloc] initWithFrame:CGRectMake(0, 0, CXScreenWidth, 45)];
            [item setTitle:@"手机" andDetailText:@"13122139590" andType:SetItemTypeTextAndArrow andImage:[UIImage imageNamed:@"set_phone"]];
            [cell.contentView addSubview:item];
        }else if(indexPath.row == 5){
            cell = [tableView dequeueReusableCellWithIdentifier:cellTextAndArrowId];
            if(cell)    return cell;
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellTextAndArrowId];
            SetItemView *item = [[SetItemView alloc] initWithFrame:CGRectMake(0, 0, CXScreenWidth, 45)];
            [item setTitle:@"专业" andDetailText:@"纺织" andType:SetItemTypeTextAndArrow andImage:[UIImage imageNamed:@"set_major"]];
            [cell.contentView addSubview:item];
        }else if(indexPath.row == 6){
            cell = [tableView dequeueReusableCellWithIdentifier:cellTextAndArrowId];
            if(cell)    return cell;
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellTextAndArrowId];
            SetItemView *item = [[SetItemView alloc] initWithFrame:CGRectMake(0, 0, CXScreenWidth, 45)];
            [item setTitle:@"出生年月" andDetailText:@"2016-10-22" andType:SetItemTypeTextAndArrow andImage:[UIImage imageNamed:@"set_birth"]];
            [cell.contentView addSubview:item];
        }else{
            cell = [tableView dequeueReusableCellWithIdentifier:cellTextAndArrowId];
            if(cell)    return cell;
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellTextAndArrowId];
            SetItemView *item = [[SetItemView alloc] initWithFrame:CGRectMake(0, 0, CXScreenWidth, 45)];
            [item setTitle:@"个性签名" andDetailText:@"(＾－＾) 介绍一下自己吧" andType:SetItemTypeTextAndArrow andImage:[UIImage imageNamed:@"set_brief"]];
            [cell.contentView addSubview:item];
        }
        
    }else if(indexPath.section == 1){
        cell = [tableView dequeueReusableCellWithIdentifier:cellTextAndArrowId];
        if(cell)    return cell;
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellTextAndArrowId];
        SetItemView *item = [[SetItemView alloc] initWithFrame:CGRectMake(0, 0, CXScreenWidth, 45)];
        [item setTitle:@"教务网账号授权" andDetailText:@"131340126" andType:SetItemTypeTextAndArrow andImage:[UIImage imageNamed:@"set_auth"]];
        [cell.contentView addSubview:item];

    }else if(indexPath.section == 2){
        cell = [tableView dequeueReusableCellWithIdentifier:@"loginCellId"];
        if(cell)    return cell;
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"loginCellId"];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, 0, CXScreenWidth, 45);
        [btn setTitle:@"退出登录" forState:UIControlStateNormal];
//        [btn setTitleColor:CXRedColor forState:UIControlStateNormal];
        [btn setTitleColor:CXBlackColor forState:UIControlStateNormal];
        [cell.contentView addSubview:btn];
    }else{
        cell = [tableView dequeueReusableCellWithIdentifier:@"nromalCell"];
        if(cell)    return cell;
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"normalCell"];
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CXScreenWidth, 45)];
        view.backgroundColor = CXBackGroundColor;
        [cell.contentView addSubview:view];
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


#pragma mark - provate

- (void)handleImagePicker{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *takePhoto = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if([self cameraAuthorization]){
            UIImagePickerController *take = [[UIImagePickerController alloc] init];
            take.delegate = self;
            take.sourceType = UIImagePickerControllerSourceTypeCamera;
            take.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
            take.allowsEditing = YES;
            [self presentViewController:take animated:YES completion:nil];

        }else{
            [self showAlert:@"无法访问您的相机" message:@"请在”设置-东华微课堂-相机“中启用访问"];
        }
    }];
    [alert addAction:takePhoto];
    
    UIAlertAction *selectPhtot = [UIAlertAction actionWithTitle:@"从手机相册选取" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if([self albumAuthorization]){
            UIImagePickerController *pick = [[UIImagePickerController alloc] init];
            pick.delegate = self;
            pick.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            pick.allowsEditing = YES;
            [self presentViewController:pick animated:YES completion:nil];
        }else{
            [self showAlert:@"无法访问您的相册" message:@"请在”设置-东华微课堂-照片“中启用访问"];
        }
    }];
    [alert addAction:selectPhtot];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:cancel];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)showAlert:(NSString *)text message:(NSString *)message{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:text message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:cancel];
    
    UIAlertAction *goSetting = [UIAlertAction actionWithTitle:@"立即前往" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        [[UIApplication sharedApplication] openURL:url];
    }];
    [alert addAction:goSetting];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    [picker dismissViewControllerAnimated:YES completion:nil];
    
   
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}


@end
