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
#import <MessageUI/MessageUI.h>
#import "AppUtil.h"
#import "AboutViewController.h"
#import "UpdateInfoViewController.h"
#import "AppIconViewController.h"

#import <StoreKit/StoreKit.h>

static NSString *cellArrowId = @"SetItemArrowCellId";
static NSString *cellSwitchId = @"cellSwitchCellId";
static NSString *cellDetailTextId  = @"cellDetailTextId";
static NSString *cellTextAndArrowId = @"cellTextAndArrowId";

@interface SetViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,MFMailComposeViewControllerDelegate,SKStoreProductViewControllerDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSString *purchaseID;

@end

@implementation SetViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self autoTheme];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置";
    self.view.backgroundColor = CXBackGroundColor;
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, CXScreenWidth, CXScreenHeight-CX_PHONE_NAVIGATIONBAR_HEIGHT)];
    [self.contentView addSubview:_tableView];
    _tableView.contentSize = CGSizeMake(CXScreenWidth, CXScreenHeight+300);
    _tableView.backgroundColor = CXBackGroundColor;
    _tableView.delegate = self;
    _tableView.separatorColor = CXLineColor;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.dataSource = self;
    _tableView.estimatedRowHeight = 0;
    _tableView.estimatedSectionFooterHeight = 0;
    _tableView.estimatedSectionHeaderHeight = 0;
    
    
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
        return 15.f;
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
    if (indexPath.section == 1){
        if(indexPath.row == 0){
            [self selectTheme];
            return;
        }
        if(indexPath.row == 1){
            [self selectBgColor];
            return;
        }
        if(indexPath.row == 2){
            [self selectFont];
            return;
        }
        if(indexPath.row == 3){
            [self cleanCache];
            return;
        }
    } else if(indexPath.section == 2){
        if(indexPath.row == 0){
            [self.navigationController pushViewController:[AboutViewController controller] animated:YES];
            return;
        }else if(indexPath.row == 1){
            if([MFMailComposeViewController canSendMail]){
                [self sendEmail];
            }else{
                [ToastView showErrorWithStaus:@"未设置系统邮件账号，请手动发送邮件至1812422367@qq.com"];
            }
            return;
        }else if(indexPath.row == 2){
            SKStoreProductViewController *storeViewContorller = [[SKStoreProductViewController alloc]init];
            storeViewContorller.delegate=self;
            [ToastView showProgressBar:@"Loading..."];
            
            [storeViewContorller loadProductWithParameters:@{SKStoreProductParameterITunesItemIdentifier:APPID}
                                        completionBlock:^(BOOL result,NSError*error)   {
                if(error)  {
                    NSLog(@"error %@ with userInfo %@",error,[error userInfo]);
                }else{
                    [self presentViewController:storeViewContorller animated:YES completion:^{
                        [ToastView dismiss];
                    }];
                }
            }];
            return;
            
        }
    }else if(indexPath.section == 3){
        if(indexPath.row == 2){
            [self.navigationController pushViewController:[UpdateInfoViewController controller] animated:YES];
            return;
        }
    }
}


#pragma mark - UITableView dataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section == 0)    return 2;
    else if(section == 1)   return 4;
    else if(section == 2){
        if([AppUtil isAfterAppUpperTimeNode])   return 3;
        else return 2;
    }
    else if(section == 3)   return 3;
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
            cell = [tableView dequeueReusableCellWithIdentifier:cellTextAndArrowId];
            if(!cell){
                cell = [[SetItemTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellTextAndArrowId];
            }
            [cell updateCell:@"主题选择" detailText:[CXUserDefaults instance].themeDescription type:SetItemTypeTextAndArrow iconImageName:@"set_theme"];
        }else if(indexPath.row == 1){
            cell = [tableView dequeueReusableCellWithIdentifier:cellTextAndArrowId];
            if(!cell){
                cell = [[SetItemTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellTextAndArrowId];
            }
            [cell updateCell:@"做题背景" detailText:[CXUserDefaults instance].bgDescription type:SetItemTypeTextAndArrow iconImageName:@"set_bg"];
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
            NSInteger wkNum = [AppUtil getCacheSize];
            NSString *num = [NSString stringWithFormat:@"%.2lfM",(cache.diskCache.totalCost+wkNum)/(1024.0*1024.0)];
            [cell updateCell:@"清除缓存" detailText:num type:SetItemTypeTextAndArrow iconImageName:@"set_clear"];
        }
    } else if(indexPath.section == 2){
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
            [cell updateCell:@"给我好评" detailText:nil type:SetItemTypeArrow iconImageName:@"set_good"];
        }else{
            cell = [tableView dequeueReusableCellWithIdentifier:cellArrowId];
            if(!cell){
                cell = [[SetItemTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellArrowId];
            }
            [cell updateCell:@"友情打赏" detailText:nil type:SetItemTypeArrow iconImageName:@"set_smile"];
        }
        
    }else if(indexPath.section == 3){
        if(indexPath.row == 0){
            cell = [tableView dequeueReusableCellWithIdentifier:cellDetailTextId];
            if(!cell){
                cell = [[SetItemTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellDetailTextId];
            }
            [cell updateCell:@"当前版本" detailText:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"] type:SetItemTypeDetailText iconImageName:@"set_version"];
        }else if(indexPath.row == 1){
            cell = [tableView dequeueReusableCellWithIdentifier:cellDetailTextId];
            if(!cell){
                cell = [[SetItemTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellDetailTextId];
            }
            [cell updateCell:@"题库版本" detailText:@"每学期自动更新" type:SetItemTypeDetailText iconImageName:@"set_tiku_version"];
        }else{
            cell = [tableView dequeueReusableCellWithIdentifier:cellArrowId];
            if(!cell){
                cell = [[SetItemTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellArrowId];
            }
            [cell updateCell:@"更新说明" detailText:nil type:SetItemTypeArrow iconImageName:@"set_updateInfo"];
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
    
    UIAlertAction *type1 = [UIAlertAction actionWithTitle:@"小号" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [CXUserDefaults instance].questionFontSize = 12;
        [_tableView reloadRow:2 inSection:1 withRowAnimation:UITableViewRowAnimationFade];
    }];
    [alert addAction:type1];
    
    UIAlertAction *type2 = [UIAlertAction actionWithTitle:@"中号" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [CXUserDefaults instance].questionFontSize = 15;
        [_tableView reloadRow:2 inSection:1 withRowAnimation:UITableViewRowAnimationFade];
    }];
    [alert addAction:type2];
    
    
    UIAlertAction *type3 = [UIAlertAction actionWithTitle:@"大号" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [CXUserDefaults instance].questionFontSize = 18;
        [_tableView reloadRow:2 inSection:1 withRowAnimation:UITableViewRowAnimationFade];
    }];
    [alert addAction:type3];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:cancel];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)cleanCache {
    YYImageCache *cache = [YYWebImageManager sharedManager].cache;
    CGFloat nowCahce = cache.diskCache.totalCost;
    if (nowCahce <= 0.00001) {
        [ToastView showErrorWithStaus:@"没有缓存"];
        return;
    }
    [ToastView showProgressBar:@"正在清理"];
    [cache.diskCache removeAllObjects];
    [AppUtil cleanCache];


    nowCahce = cache.diskCache.totalCost;
    if(nowCahce < 0.02){
        [ToastView showBlackSuccessWithStaus:@"清理完成" delay:1.2];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [_tableView reloadRow:3 inSection:1 withRowAnimation:UITableViewRowAnimationFade];
        });
    }
    
}

- (void)selectTheme{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *type1 = [UIAlertAction actionWithTitle:@"樱花粉" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [CXUserDefaults instance].themeType = 1;
        [_tableView reloadRow:0 inSection:1 withRowAnimation:UITableViewRowAnimationFade];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self autoTheme];
        });
    }];
    [alert addAction:type1];
    
    UIAlertAction *type2 = [UIAlertAction actionWithTitle:@"简洁白" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [CXUserDefaults instance].themeType = 2;
        [_tableView reloadRow:0 inSection:1 withRowAnimation:UITableViewRowAnimationFade];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self autoTheme];
        });
    }];
    [alert addAction:type2];
    
    
    UIAlertAction *type3 = [UIAlertAction actionWithTitle:@"水绿色" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [CXUserDefaults instance].themeType = 3;
        [_tableView reloadRow:0 inSection:1 withRowAnimation:UITableViewRowAnimationFade];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
             [self autoTheme];
        });
    }];
    [alert addAction:type3];
    
    UIAlertAction *type4 = [UIAlertAction actionWithTitle:@"橙色" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [CXUserDefaults instance].themeType = 4;
        [_tableView reloadRow:0 inSection:1 withRowAnimation:UITableViewRowAnimationFade];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self autoTheme];
        });
    }];
    [alert addAction:type4];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:cancel];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)selectBgColor{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *type1 = [UIAlertAction actionWithTitle:@"纯白" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [CXUserDefaults instance].bgType = 1;
        [_tableView reloadRow:1 inSection:1 withRowAnimation:UITableViewRowAnimationFade];
    }];
    [alert addAction:type1];
    
    UIAlertAction *type2 = [UIAlertAction actionWithTitle:@"浅灰" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [CXUserDefaults instance].bgType = 2;
        [_tableView reloadRow:1 inSection:1 withRowAnimation:UITableViewRowAnimationFade];
    }];
    [alert addAction:type2];
    
    
    UIAlertAction *type3 = [UIAlertAction actionWithTitle:@"护眼" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [CXUserDefaults instance].bgType = 3;
        [_tableView reloadRow:1 inSection:1 withRowAnimation:UITableViewRowAnimationFade];
    }];
    [alert addAction:type3];
    
    UIAlertAction *type4 = [UIAlertAction actionWithTitle:@"淡青" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [CXUserDefaults instance].bgType = 4;
        [_tableView reloadRow:1 inSection:1 withRowAnimation:UITableViewRowAnimationFade];
    }];
    [alert addAction:type4];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:cancel];
    
    [self presentViewController:alert animated:YES completion:nil];
}


- (void)sendEmail{
    // 邮件服务器
    MFMailComposeViewController *mailCompose = [[MFMailComposeViewController alloc] init];
    // 设置邮件代理
    [mailCompose setMailComposeDelegate:self];
    // 设置邮件主题
    [mailCompose setSubject:@"软件使用反馈"];
    // 设置收件人
    [mailCompose setToRecipients:@[@"1812422367@qq.com"]];
    /**
     *  设置邮件的正文内容
     */
    NSString *emailContent = @"请输入反馈的问题";
    // 是否为HTML格式
    [mailCompose setMessageBody:emailContent isHTML:NO];
    // 弹出邮件发送视图
    [self presentViewController:mailCompose animated:YES completion:nil];
}

- (void)mailComposeController:(MFMailComposeViewController *)controller
          didFinishWithResult:(MFMailComposeResult)result
                        error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled: // 用户取消编辑
            [ToastView showStatus:@"取消发送"];
            break;
        case MFMailComposeResultSaved: // 用户保存邮件
            [ToastView showStatus:@"邮件已保存"];
            break;
        case MFMailComposeResultSent: // 用户点击发送
            [ToastView showBlackSuccessWithStaus:@"发送成功"];
            break;
        case MFMailComposeResultFailed: // 用户尝试保存或发送邮件失败
            [ToastView showErrorWithStaus:@"发送失败"];
            break;
    }
    // 关闭邮件发送视图
    [self dismissViewControllerAnimated:YES completion:nil];
}

//APP Store评分取消
- (void)productViewControllerDidFinish:(SKStoreProductViewController *)viewController{
    [self dismissViewControllerAnimated:YES completion:^{
        CXLog(@"APP Store评分取消");
    }];
}


@end
