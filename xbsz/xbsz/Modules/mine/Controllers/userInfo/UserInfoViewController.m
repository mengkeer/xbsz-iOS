//
//  UserInfoViewController.m
//  xbsz
//
//  Created by 陈鑫 on 16/12/16.
//  Copyright © 2016年 lotus. All rights reserved.
//

#import "UserInfoViewController.h"
#import "SetItemTableViewCell.h"
#import "UIViewController+Authorization.h"
#import "AuthorizedLoginViewController.h"
#import "NicknameViewController.h"
#import "CXNetwork+User.h"
#import "EmailViewController.h"
#import "PhoneViewController.h"


static NSString *cellArrowId = @"SetItemArrowCellId";
static NSString *cellSwitchId = @"cellSwitchCellId";
static NSString *cellDetailTextId  = @"cellDetailTextId";
static NSString *cellTextAndArrowId = @"cellTextAndArrowId";
static NSString *cellImageAndArrowId = @"cellImageAndArrowId";

@interface UserInfoViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic, strong) UITableView *tableView;

@end



@implementation UserInfoViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.view.backgroundColor = CXBackGroundColor;
    self.title = @"个人资料";
    
    
     _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, CXScreenWidth, CXScreenHeight-64.f)];
    [self.contentView addSubview:_tableView];
    _tableView.contentSize = CGSizeMake(CXScreenWidth, CXScreenHeight+400);
    _tableView.backgroundColor = CXBackGroundColor;
    _tableView.delegate = self;
    _tableView.separatorColor = CXLineColor;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.dataSource = self;
    
    //高度加400没有特别意思  只是为了保证高度足够高
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, CXScreenWidth, CXScreenHeight+400) byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(CXTopCornerRadius, CXTopCornerRadius)];
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
            case 1:{
                [self.navigationController pushViewController:[NicknameViewController controller] animated:YES];
                break;
            }
            case 2:{
                [self selectGender];
                break;
            }
            case 3:{
                [self.navigationController pushViewController:[EmailViewController controller] animated:YES];
                break;
            }
            case 4:{
                [self.navigationController pushViewController:[PhoneViewController controller] animated:YES];
                break;
            }
            default:
                break;
        }
    }
    if(indexPath.section == 1){
        if(indexPath.row == 0){
            [self.navigationController pushViewController:[AuthorizedLoginViewController controller] animated:YES];
        }
    }
    
    if(indexPath.section == 2 && indexPath.row == 0){
        [self quitLogin];
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
    SetItemTableViewCell *cell;
    if(indexPath.section == 0){
        if(indexPath.row == 0){
            cell = [tableView dequeueReusableCellWithIdentifier:cellImageAndArrowId];
            if(!cell){
                 cell = [[SetItemTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellImageAndArrowId];
            }
            [cell updateCell:@"我的头像" detailText:nil type:SetItemTypeImageAndArrow iconImageName:@"set_head"];
            [cell setHeadImage:@"avatar1.jpg"];
        }else if(indexPath.row == 1){
            cell = [tableView dequeueReusableCellWithIdentifier:cellTextAndArrowId];
            if(!cell){
                cell = [[SetItemTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellTextAndArrowId];
            }
            [cell updateCell:@"昵称" detailText:[CXLocalUser instance].nickname type:SetItemTypeTextAndArrow iconImageName:@"set_nick"];
        }else if(indexPath.row == 2){
            cell = [tableView dequeueReusableCellWithIdentifier:cellTextAndArrowId];
            if(!cell){
                cell = [[SetItemTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellTextAndArrowId];
            }
            NSInteger gender = [CXLocalUser instance].gender;
            NSString *title = gender == 1 ? @"男" : (gender == 2 ? @"女" : @"保密");
            [cell updateCell:@"性别" detailText:title type:SetItemTypeTextAndArrow iconImageName:@"set_sex"];
        }else if(indexPath.row == 3){
            cell = [tableView dequeueReusableCellWithIdentifier:cellTextAndArrowId];
            if(!cell){
                cell = [[SetItemTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellTextAndArrowId];
            }

            [cell updateCell:@"邮箱" detailText:[CXLocalUser instance].email type:SetItemTypeTextAndArrow iconImageName:@"set_email"];
        }else if(indexPath.row == 4){
            cell = [tableView dequeueReusableCellWithIdentifier:cellTextAndArrowId];
            if(!cell){
                cell = [[SetItemTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellTextAndArrowId];
            }
            [cell updateCell:@"手机" detailText:[CXLocalUser instance].mobile type:SetItemTypeTextAndArrow iconImageName:@"set_phone"];
        }else if(indexPath.row == 5){
            cell = [tableView dequeueReusableCellWithIdentifier:cellTextAndArrowId];
            if(!cell){
                cell = [[SetItemTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellTextAndArrowId];
            }
            [cell updateCell:@"专业" detailText:@"纺织" type:SetItemTypeTextAndArrow iconImageName:@"set_major"];
        }else if(indexPath.row == 6){
            cell = [tableView dequeueReusableCellWithIdentifier:cellTextAndArrowId];
            if(!cell){
                cell = [[SetItemTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellTextAndArrowId];
            }
            [cell updateCell:@"出生年月" detailText:@"2016-10-22" type:SetItemTypeTextAndArrow iconImageName:@"set_birth"];
        }else{
            cell = [tableView dequeueReusableCellWithIdentifier:cellTextAndArrowId];
            if(!cell){
                cell = [[SetItemTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellTextAndArrowId];
            }
            [cell updateCell:@"个性签名" detailText:@"(＾－＾) 介绍一下自己吧" type:SetItemTypeTextAndArrow iconImageName:@"set_brief"];
        }
        
    }else if(indexPath.section == 1){
        cell = [tableView dequeueReusableCellWithIdentifier:cellTextAndArrowId];
        if(!cell){
            cell = [[SetItemTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellTextAndArrowId];
        }
        NSString *detailText = [JWLocalUser instance].isAuthorized ? [JWLocalUser instance].JWUsername : @"";
        [cell updateCell:@"教务网账号授权" detailText:detailText type:SetItemTypeTextAndArrow iconImageName:@"set_auth"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }else if(indexPath.section == 2){
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"loginCellId"];
        if(!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"loginCellId"];
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(0, 0, CXScreenWidth, 45);
            [btn setTitle:@"退出登录" forState:UIControlStateNormal];
            [btn setTitleColor:CXBlackColor forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(quitLogin) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:btn];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if(indexPath.section == 3){
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"nromalCell"];
        if(!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"nromalCell"];
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CXScreenWidth, 45)];
            view.backgroundColor = CXBackGroundColor;
            [cell.contentView addSubview:view];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
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


#pragma mark - private
//处理头像上传
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
//处理性别设置

- (void)selectGender{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *male = [UIAlertAction actionWithTitle:@"男" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSString *token = [CXLocalUser instance].token;
        NSMutableDictionary *paremeters = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"1",@"gender", nil];
        [CXNetwork updateUserInfo:token parameters:paremeters success:^(NSObject *obj) {
            [ToastView showSuccessWithStaus:@"修改成功"];
             [_tableView reloadData];
        } failure:^(NSError *error) {
            [ToastView showErrorWithStaus:@"修改失败"];
        }];
    }];
    [alert addAction:male];
    
    UIAlertAction *female = [UIAlertAction actionWithTitle:@"女" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSString *token = [CXLocalUser instance].token;
        NSMutableDictionary *paremeters = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"2",@"gender", nil];
        [CXNetwork updateUserInfo:token parameters:paremeters success:^(NSObject *obj) {
            [ToastView showSuccessWithStaus:@"修改成功"];
             [_tableView reloadData];
        } failure:^(NSError *error) {
            [ToastView showErrorWithStaus:@"修改失败"];
        }];
    }];
    [alert addAction:female];
    
    
    UIAlertAction *unknown = [UIAlertAction actionWithTitle:@"保密" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSString *token = [CXLocalUser instance].token;
        NSMutableDictionary *paremeters = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"3",@"gender", nil];
        [CXNetwork updateUserInfo:token parameters:paremeters success:^(NSObject *obj) {
            [ToastView showSuccessWithStaus:@"修改成功"];
            [_tableView reloadData];
        } failure:^(NSError *error) {
            [ToastView showErrorWithStaus:@"修改失败"];
        }];
    }];
    [alert addAction:unknown];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:cancel];
    
    [self presentViewController:alert animated:YES completion:nil];
}

//处理用户登录
- (void)quitLogin{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"退出后不会删除历史数据，下次使用本账号登录将重新载入数据" preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *quit = [UIAlertAction actionWithTitle:@"退出登录" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [[CXLocalUser instance] reset];
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [alert addAction:quit];
    
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:cancel];
    
    [self presentViewController:alert animated:YES completion:nil];
}


@end
