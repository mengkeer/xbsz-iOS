//
//  InformViewController.m
//  xbsz
//
//  Created by lotus on 2016/12/18.
//  Copyright © 2016年 lotus. All rights reserved.
//

#import "InformViewController.h"

static NSString *cellID = @"InformTableViewCellID";

@interface InformViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *informTexts;

@end

@implementation InformViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = CXWhiteColor;
    self.title = @"通知";
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, CXScreenWidth, CXScreenHeight-64.f)];
    [self.contentView addSubview:_tableView];
    _tableView.contentSize = CGSizeMake(CXScreenWidth, CXScreenHeight-64);
    _tableView.backgroundColor = CXWhiteColor;
    _tableView.delegate = self;
    _tableView.separatorColor = CXLineColor;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.dataSource = self;
    _tableView.separatorStyle =   UITableViewCellSeparatorStyleNone;

    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, CXScreenWidth, CXScreenHeight-64) byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(CXTopCornerRadius, CXTopCornerRadius)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = CGRectMake(0, 0, CXScreenWidth, CXScreenHeight-64);
    maskLayer.path = maskPath.CGPath;
    _tableView.layer.mask = maskLayer;
    
    _informTexts = [NSMutableArray arrayWithObjects:@"本学期即将发布新版本",@"注意:近代史的word版题库只有序章,因为一章可能就几百题，为了做题方便，本软件将近代史题库人为分为四章，但总题数和题目内容不变，欢迎大家核对",@"如果对软件使用有什么问题，或者好的建议，bug反馈，欢迎大家发邮件给我，",@"每学期期末，如果思政有变更的话，欢迎大家把题库发给我，我好更新题库数据",@"开发人员联系方式如下：1812422367@qq.com，同时欢迎各位加我QQ或微信交流学习问题：1812422367 请备注:学习交流",nil];
    [_tableView reloadData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}


- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45.f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
 
    
}


#pragma mark - UITableView dataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_informTexts count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    InformTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if(!cell){
        cell = [[InformTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell updateUI:[_informTexts objectAtIndex:indexPath.row]];
    [cell showLineView:indexPath.row totalRows:[_informTexts count]];
    return cell;
}


@end


@interface InformTableViewCell ()


@property (nonatomic, strong) UIButton *informBtn;

@property (nonatomic, strong) UILabel *contentLabel;

@property (nonatomic, strong) UIView *lineView;

@end

@implementation InformTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initTableViewCell];
    }
    return self;
}

- (void)initTableViewCell{
    self.contentView.backgroundColor = CXWhiteColor;
    [self.contentView addSubview:self.informBtn];
    
    [_informBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).mas_offset(15);
        make.top.mas_equalTo(self.contentView).mas_offset(10);
        make.width.height.mas_equalTo(24);
    }];
    
    
    [self.contentView addSubview:self.contentLabel];
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top).mas_offset(10);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).mas_offset(-10);
        make.left.mas_equalTo(_informBtn.mas_right).mas_offset(15);
        make.height.mas_equalTo(25);
        make.right.mas_equalTo(self.contentView.mas_right).mas_offset(-15);
    }];
    
    
    _lineView = [[UIView alloc] init];
    _lineView.backgroundColor = CXLineColor;
    [self.contentView addSubview:_lineView];
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_informBtn.mas_right).mas_offset(15);
        make.right.mas_equalTo(self.contentView.mas_right);
        make.height.mas_equalTo(1/CXMainScale);
        make.bottom.mas_equalTo(self.contentView.mas_bottom);
    }];
}



#pragma mark - getter/setter

- (UIButton *)informBtn{
    if(!_informBtn){
        _informBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _informBtn.frame = CGRectMake(0, 0, 24, 24);
        [_informBtn setImage:[UIImage imageNamed:@"inform"] forState:UIControlStateNormal];
        [_informBtn setImage:[UIImage imageNamed:@"inform"] forState:UIControlStateHighlighted];
        _informBtn.layer.cornerRadius = 12;
        _informBtn.clipsToBounds = YES;
    }
    return _informBtn;
}

- (UILabel *)contentLabel{
    if(!_contentLabel){
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.font = CXSystemFont(14);
        _contentLabel.textColor = CXHexAlphaColor(0x000000, 0.8);
        _contentLabel.text = @"";
        _contentLabel.numberOfLines = 0;
    }
    return _contentLabel;
}

#pragma mark - public method

- (void)updateUI:(NSString *)text{

    _contentLabel.text = text;
    
    CGRect labelRect = [text boundingRectWithSize:CGSizeMake(CXScreenWidth-15-24-15-15, CGFLOAT_MAX) options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:CXSystemFont(14)} context:nil] ;
    
    NSInteger textHeight = (int)CGRectGetHeight(labelRect);
    NSInteger height = textHeight < 25 ? 25 :textHeight + 1;
    
    [_contentLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(height);
    }];
    
    [_contentLabel sizeToFit];
}

- (void)showLineView:(NSInteger)currentRow totalRows:(NSInteger)totalRows{
    if(currentRow == totalRows - 1){
        _lineView.hidden = YES;
    }else{
        _lineView.hidden = NO;
    }
}

@end
