//
//  YYShopDetailMarkTableViewCell.m
//  lcjfarm
//
//  Created by wyy on 16/9/13.
//  Copyright © 2016年 WYY. All rights reserved.
//


#import "YYShopDetailMarkTableViewCell.h"
#import "YYMarkCollectionViewCell.h"
#import "YYMarkModel.h"

@interface YYShopDetailMarkTableViewCell ()<UICollectionViewDataSource>{
    CGFloat _xMargin;
    CGFloat _itemW;
    CGFloat _itemH;

}

@property (nonatomic, weak) UICollectionView *collectionView;

@property (nonatomic, weak) UIButton *seeAllBtn;

//@property (nonatomic, weak) UIButton *aliPayBtn;
//
//@property (nonatomic, weak) UIButton *wechatBtn;

@property (nonatomic, weak) UILabel *noMarkLabel;

@end

@implementation YYShopDetailMarkTableViewCell
+ (instancetype)shopDetailMarkTableViewCellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"YYShopDetailMarkTableViewCell";
    YYShopDetailMarkTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[YYShopDetailMarkTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    return cell;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        _xMargin = k12WidthMargin;
        _itemW = (kWidthScreen - _xMargin * 6 - 1)/5.0;
        _itemH = _itemW + 5 + 12 + 5;
        //增加控件
        [self addSubviews];
        //添加约束
        [self addConstraints];
        
    }
    return self;
}
/**
 *  增加控件
 */
- (void)addSubviews{
    //增加collectionView
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    
    layout.itemSize = CGSizeMake(_itemW, _itemH);
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = _xMargin;
    layout.sectionInset = UIEdgeInsetsMake(k12HeightMargin, k12WidthMargin, 0, k12WidthMargin);
//UIEdgeInsetsMake(<#CGFloat top#>, <#CGFloat left#>, <#CGFloat bottom#>, <#CGFloat right#>)
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    [self.contentView addSubview:collectionView];
    self.collectionView = collectionView;
//    [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.top.mas_equalTo(self.contentView);
//    }];
    collectionView.dataSource = self;
    
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.scrollEnabled = NO;
    
    [collectionView registerClass:[YYMarkCollectionViewCell class] forCellWithReuseIdentifier:@"YYMarkCollectionViewCell"];
    
    //增加查看全部按钮
    UIButton *seeAllBtn = [[UIButton alloc] init];
    [self.contentView addSubview:seeAllBtn];
    [seeAllBtn setTitle:@"查看全部>>" forState:UIControlStateNormal];
    seeAllBtn.titleLabel.font = [UIFont systemFontOfSize:13.0];
    [seeAllBtn setTitleColor:kGray99TextColor forState:UIControlStateNormal];
    [seeAllBtn bk_addEventHandler:^(id sender) {
        if (self.YYSeeAllMarkBlock) {
            self.YYSeeAllMarkBlock();
        }
        YYLog(@"增加查看全部按钮");
    } forControlEvents:UIControlEventTouchUpInside];
    self.seeAllBtn = seeAllBtn;
    
    //增加商家暂未上传标签label
    UILabel *noMarkLabel = [[UILabel alloc] init];
    [self.contentView addSubview:noMarkLabel];
    noMarkLabel.text = @"商家暂未上传标签";
    noMarkLabel.font = [UIFont systemFontOfSize:15.0];
    noMarkLabel.textColor = kGrayTextColor;
    self.noMarkLabel = noMarkLabel;
    self.noMarkLabel.textAlignment = NSTextAlignmentCenter;
    
    
    //增加去支付宝按钮
//    UIButton *aliPayBtn =  [[UIButton alloc] init];
//    [self.contentView addSubview:aliPayBtn];
//    [aliPayBtn setImage:[UIImage imageNamed:@"home_shop_detail_aliPay"] forState:UIControlStateNormal];
//    [aliPayBtn bk_addEventHandler:^(id sender) {
//        
//        NSURL *url = [NSURL URLWithString:@"alipay://app"];
//        // 如果已经安装了这个应用,就跳转
//        if ([[UIApplication sharedApplication] canOpenURL:url]) {
//            [[UIApplication sharedApplication] openURL:url];
//        }
//        
//    } forControlEvents:UIControlEventTouchUpInside];
//    self.aliPayBtn = aliPayBtn;
    
    //增加去微信按钮
//    UIButton *wechatBtn =  [[UIButton alloc] init];
//    [self.contentView addSubview:wechatBtn];
//    [wechatBtn setImage:[UIImage imageNamed:@"home_shop_detail_wechat"] forState:UIControlStateNormal];
//    [wechatBtn bk_addEventHandler:^(id sender) {
//        //weixin://app/wxdaae92a9cfe5d54c/
//        NSURL *url = [NSURL URLWithString:@"weixin://app"];
//        // 如果已经安装了这个应用,就跳转
//        if ([[UIApplication sharedApplication] canOpenURL:url]) {
//            [[UIApplication sharedApplication] openURL:url];
//        }
//        
//    } forControlEvents:UIControlEventTouchUpInside];
//    self.wechatBtn = wechatBtn;
    
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSInteger count = self.marksArray.count < 20 ? self.marksArray.count : 20;

    NSInteger lines = count/5;
    CGFloat line = count%5;
    if (line != 0) {
        lines += 1;
    }
    
    CGFloat height = k12HeightMargin + _itemH * lines;
    [self.collectionView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(height);
    }];
    return count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"YYMarkCollectionViewCell";
    YYMarkCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    
    YYMarkModel *model = self.marksArray[indexPath.item];
    cell.model = model;
    
    return cell;
    
}
/**
 *  添加约束
 */
- (void)addConstraints{
 
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(self.contentView);
    }];
    
    [self.seeAllBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.contentView);
        make.height.mas_equalTo(k12HeightMargin * 2 + 20);
        make.width.mas_equalTo(200);
        make.top.mas_equalTo(self.collectionView.mas_bottom);
    }];
    
    [self.noMarkLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.contentView);
        make.height.mas_equalTo(k12HeightMargin * 2 + 20);
        make.top.mas_equalTo(self.collectionView.mas_bottom);
    }];
    
//    CGFloat btnMargin = (kWidthScreen - 100 * 2)/4.0;
//    [self.aliPayBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(self.seeAllBtn.mas_bottom);
//        make.size.mas_equalTo(CGSizeMake(100, 30));
//        make.left.mas_equalTo(self.contentView).mas_offset(btnMargin);
//        
//    }];
    
//    [self.wechatBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(self.seeAllBtn.mas_bottom);
//        make.size.mas_equalTo(CGSizeMake(100, 30));
//        make.right.mas_equalTo(self.contentView).mas_offset(-btnMargin);
//    }];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setMarksArray:(NSArray *)marksArray{
    _marksArray = marksArray;
    if (_marksArray.count == 0) {
        self.seeAllBtn.hidden = YES;
        self.noMarkLabel.hidden = NO;
    }
    else{
        self.seeAllBtn.hidden = NO;
        self.noMarkLabel.hidden = YES;
    }
    [self.collectionView reloadData];
}
@end
