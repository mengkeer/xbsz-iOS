//
//  CampusViewController.m
//  xbsz
//
//  Created by 陈鑫 on 17/2/21.
//  Copyright © 2017年 lotus. All rights reserved.
//

#import "CampusViewController.h"
#import "CXBaseTableView.h"
#import "CampusTableViewCell.h"
#import "CXUser.h"
#import "CampusNote.h"
#import "CampusNoteList.h"
#import "MoreToolBarView.h"
#import "ShareToolBarView.h"
#import "CommentToolBarView.h"
#import "CXNetwork+Note.h"
#import "CampusCommentViewController.h"
#import "IDMPhotoBrowser.h"

static NSInteger limit = 10;

@interface CampusViewController ()<CXBaseTableViewDelegate,UIViewControllerPreviewingDelegate>

@property (nonatomic, strong) CXBaseTableView *tableView;

@property (nonatomic, strong) CampusNoteList *noteList;

@property (nonatomic, strong) NSMutableArray *notes;

@property (nonatomic, strong) NSMutableDictionary *likes;

@property (nonatomic, strong) NSMutableDictionary *loves;
 
@end

@implementation CampusViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = CXWhiteColor;
    [self.contentView addSubview:self.tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.view);
    }];
    
    [self loadDataAtPageIndex:CXFisrtLoadPage];
    _notes = [NSMutableArray array];
    _likes = [NSMutableDictionary dictionary];
    _loves = [NSMutableDictionary dictionary];
    
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshData) name:NotificationCampusNotePublished object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)refreshData{
    [self.tableView loadRefreshData];
}


#pragma mark getter / setter
- (UITableView *)tableView{
    if(!_tableView){
        _tableView = [[CXBaseTableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped enablePullRefresh:YES];
        _tableView.baseDelegate = self;
        _tableView.backgroundColor = CXWhiteColor;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorStyle = NO;
        _tableView.showEmptyTips = YES;
    }
    return _tableView;
}

#pragma mark  CXBaseTableViewDelegate

- (void)loadDataAtPageIndex:(NSUInteger )pageIndex{
    
    @weakify(self);
    
    [CXNetwork getNotesByPageOffset:pageIndex-1 limit:limit success:^(NSObject *obj) {
        weak_self.noteList = [CampusNoteList yy_modelWithDictionary:(NSDictionary *)obj];
        if(pageIndex == 1){
                [weak_self.notes removeAllObjects];
        }
    
        [weak_self.notes addObjectsFromArray:_noteList.notes];
        
        NSInteger total = weak_self.noteList.total;
        
        if([weak_self.notes count] == 0){
            [weak_self.tableView showDefaultImageWithResult:NO];
        }else{
            [weak_self.tableView showRefresh];
        }
        
        if([weak_self.notes count] == total){
            [weak_self.tableView loadNoMoreData];
        }
        
        [weak_self.tableView reloadData];           //重新加载
        if(pageIndex == 1){
            [self.tableView scrollToRow:0 inSection:0 atScrollPosition:UITableViewScrollPositionTop animated:YES];
        }
    } failure:^(NSError *error) {
        if (weak_self.notes.count == 0) {
            [weak_self.tableView showDefaultImageWithResult:YES];
        }else{
            [ToastView showErrorWithStaus:@"加载失败"];
        }
        [weak_self.tableView endRefresh];
    }];
}

#pragma mark UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == [_notes count]) return 49;
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == [_notes count])     return 49;
    return 300;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    CXLog(@"%@",[NSString stringWithFormat:@"点击了第%lu行",indexPath.row])
}




#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_notes count]+1;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.row == [_notes count]){
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"normalCellID"];
        if(cell == nil){
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"normalCellID"];
            cell.contentView.backgroundColor = CXWhiteColor;
        }
        return cell;
    }
    
    CampusTableViewCell *cell;
    cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if(cell == nil){
        cell = [[CampusTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellID"];
    }
    CampusNote *note = [_notes objectAtIndex:indexPath.row];
    if([_likes objectForKey:note.noteID] == nil){
        [_likes setObject:@"0" forKey:note.noteID];
    }
    BOOL hasLiked = [[_likes objectForKey:note.noteID] isEqualToString:@"1"] ? YES:NO;
    [cell updateUIWithModel:[_notes objectAtIndex:indexPath.row] hasLiked:hasLiked action:^(id cell,id model, CommentCellActionType actionType) {
        [self handleAction:actionType model:(CampusNote *)model cell:cell];
    }];
    if(CX3DTouchOpened)       [cell registerTouch:self];
    return cell;
}

#pragma mark private method

- (void)handleAction:(CommentCellActionType)type model:(CampusNote *)model cell:(id)cell{
    switch (type) {
        case CellActionTypeLike:
            if([[_likes objectForKey:model.noteID] isEqualToString:@"1"] == YES){
                [ToastView showErrorWithStaus:@"已经赞过了"];
            }else{
                CXLog(@"开始点赞");
                [_likes setValue:@"1" forKey:model.noteID];
            }
            break;
        case CellActionTypeReply:
            [self gotoCommentViewController:model];
            break;
        case CellActionTypeShare:{
            [[ShareToolBarView instance] updateUIWithModel:model action:^(ShareToolBarActionTyep actionType) {
                [self handleShareAction:actionType model:model];
            }];
            [[ShareToolBarView instance] showInView:self.view.window];
            break;
        }
        case CellActionTypeMore:{
            [[MoreToolBarView instance] updateUIWithModel:model action:^(MoreToolBarActionTyep actionType) {
                [self handleMoreAction:actionType model:model cell:cell];
            }];
            BOOL loved = [[_loves objectForKey:model.noteID] isEqualToString:@"1"] ? YES:NO;
            BOOL liked = [[_likes objectForKey:model.noteID] isEqualToString:@"1"] ? YES:NO;
            [[MoreToolBarView instance] updateUIByLoved:loved liked:liked];
            [[MoreToolBarView instance] showInView:self.view.window];
            break;
        }
        case CellActionTypeUserInfo:
            break;
        case CellActionTypeSourceImage:{
            NSMutableArray *photos = [NSMutableArray new];
            
            IDMPhoto *photo = [IDMPhoto photoWithURL:[NSURL URLWithString:CXNoteImageUrlByname(model.img)]];
            photo.caption = model.subject;
            [photos addObject:photo];
        
            UIImageView *sourceImageView = ((CampusTableViewCell *)cell).sharedImageView;

            IDMPhotoBrowser *browser = [[IDMPhotoBrowser alloc] initWithPhotos:photos animatedFromView:sourceImageView];
            browser.view.backgroundColor = CXBlackColor;
            browser.scaleImage = sourceImageView.image;
            browser.displayToolbar = NO;
            browser.usePopAnimation = YES;
            browser.displayDoneButton = NO;
            browser.dismissOnTouch = YES;
            browser.autoHideInterface = NO;

            [self presentViewController:browser animated:YES completion:nil];
            
            break;
        }
        case CellActionTypeComment:
            [self gotoCommentViewController:model];
            break;
        default:
            break;
    }
}

- (void)handleShareAction:(ShareToolBarActionTyep) actionType model:(CampusNote *)model{
    switch (actionType) {
        case ShareToolBarActionTyepPYQ:
            [ToastView showSuccessWithStaus:@"朋友圈分享"];
            break;
        case ShareToolBarActionTyepWechat:
            [ToastView showSuccessWithStaus:@"微信分享"];
            break;
        case ShareToolBarActionTyepQQ:
            [ToastView showSuccessWithStaus:@"QQ分享"];
            break;
        case ShareToolBarActionTyepQzone:
            [ToastView showSuccessWithStaus:@"QQ空间分享"];
            break;
        case ShareToolBarActionTyepWeibo:
            [ToastView showSuccessWithStaus:@"微博分享"];
            break;
        case ShareToolBarActionTyepSystem:
            [ToastView showSuccessWithStaus:@"系统分享"];
            break;
        case ShareToolBarActionTyepCancel:
            [[ShareToolBarView instance] dismissInView:self.view.window];
            break;
        default:
            break;
    }
}

- (void)handleMoreAction:(MoreToolBarActionTyep) actionType model:(CampusNote *)model cell:(id) cell{
    switch (actionType) {
        case MoreToolBarActionTypeSave:
            if([[_loves objectForKey:model.noteID] isEqualToString:@"1"] == YES){
                [ToastView showErrorWithStaus:@"已经保存了"];
            }else{
                UIImageWriteToSavedPhotosAlbum(((CampusTableViewCell *)cell).sharedImageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), (__bridge void *)self);
                [_loves setValue:@"1" forKey:model.noteID];
            }
            break;
        case MoreToolBarActionTyepDislike:
            CXLog(@"不感兴趣");
            break;
        case MoreToolBarActionTyepDigup:{
            if([[_likes objectForKey:model.noteID] isEqualToString:@"1"] == YES){
                [ToastView showErrorWithStaus:@"已经赞过了"];
            }else{
                CXLog(@"开始点赞");
                //注：此处需要手动出发toolbar栏里的点赞效果
                [self digUpWithModel:model];
                [_likes setValue:@"1" forKey:model.noteID];
            }
            break;
        }
        case MoreToolBarActionTyepDigdown:{
            if([[_noteList.dislikes objectForKey:model.noteID] isEqualToString:@"1"] == YES){
                [ToastView showErrorWithStaus:@"已经踩过了"];
            }else{
                CXLog(@"开始踩");
                [_noteList.dislikes setValue:@"1" forKey:model.noteID];
            }
            break;
        }
        case MoreToolBarActionTyepReport:
            CXLog(@"举报");
            break;
        case MoreToolBarActionTyepCancel:
            [[MoreToolBarView instance] dismissInView:self.view.window];
            break;
        default:
            break;
    }
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if(error == nil){
        [ToastView showStatus:@"保存成功" delay:0.8];
    }else{
        [ToastView showStatus:@"保存失败" delay:0.8];
    }
}

//根据model中的noteID出发点赞效果  指在MoreToolBar里点赞时出发toolBar点赞按钮的效果
- (void)digUpWithModel:(CampusNote *)model{
    for(CampusTableViewCell *cell in _tableView.visibleCells){
        if([cell.note.noteID isEqualToString:model.noteID]){
            CommentToolBarView *toolbarView = cell.toolBarView;
            [toolbarView setLikeBtnSelect];
        }
    }
}

- (void)gotoCommentViewController:(CampusNote *)note{
    CampusCommentViewController *commentVC = [CampusCommentViewController controller];
    commentVC.note = note;
    [self.navigationController pushViewController:commentVC animated:YES];
}

#pragma mark - 3DTouch Delegate

- (UIViewController *)previewingContext:(id<UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location{
    //防止重复加入
    if ([self.presentedViewController isKindOfClass:[CampusCommentViewController class]]){
        return nil;
    }else{
        CampusCommentViewController *peekViewController = [[CampusCommentViewController alloc] init];
        peekViewController.note = [_notes objectAtIndex:[self getIndexByPreviewing:previewingContext]];
        peekViewController.beforePeekedViewConreoller = self;
        peekViewController.sharedImage = ((YYAnimatedImageView *)[previewingContext sourceView]).image;
        return peekViewController;
    }
}

- (void)previewingContext:(id<UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit{
    CampusCommentViewController *popViewController = [CampusCommentViewController controller];
    popViewController.note = [_notes objectAtIndex:[self getIndexByPreviewing:previewingContext]];
    popViewController.beforePeekedViewConreoller = self;
    popViewController.sharedImage = ((YYAnimatedImageView *)[previewingContext sourceView]).image;
    [self showViewController:popViewController sender:self];
}


- (NSInteger)getIndexByPreviewing:(id<UIViewControllerPreviewing>)previewingContext{
    CampusTableViewCell  *cell = (CampusTableViewCell *)[[[previewingContext sourceView] superview] superview];
    NSIndexPath *indexPath = [_tableView indexPathForCell:cell];
    NSInteger index = indexPath.row;
    return index;
}


@end

