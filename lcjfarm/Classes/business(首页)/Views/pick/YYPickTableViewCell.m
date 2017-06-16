//
//  YYPickTableViewCell.m
//  lcjfarm
//
//  Created by wyy on 16/6/29.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import "YYPickTableViewCell.h"
#import "YYPickTableViewModel.h"


#define kShopNameLabelFont [UIFont boldSystemFontOfSize:18.0]

#define kTopGrayViewH 12
#define kShopImageViewH (220/603.0*kNoNavHeight)
#define kShopNameLabelH 18
#define kShopTimeLabelW 75
#define kShopDistanceLabelH 15
#define marginXY 12


@interface YYPickTableViewCell ()
/**
 *  上面部分的View
 */
@property (weak, nonatomic) IBOutlet UIView *topGrayView;
/**
 *  采摘店铺图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *shopImageView;
/**
 *  采摘店铺名称
 */
@property (weak, nonatomic) IBOutlet UILabel *shopNameLabel;
/**
 *  采摘店铺营业时间的背景图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *shopTimeImageView;
/**
 *  采摘店铺营业时间Label
 */
@property (weak, nonatomic) IBOutlet UILabel *shopTimeLabel;
/**
 *  采摘店铺的地址label
 */
@property (weak, nonatomic) IBOutlet UILabel *shopAddressLabel;
/**
 *  采摘店铺的距离店铺
 */
@property (weak, nonatomic) IBOutlet UILabel *shopDistanceLabel;
/**
 *  分割线
 */
@property (weak, nonatomic) IBOutlet UIView *lineView;

@end

@implementation YYPickTableViewCell
+ (instancetype)pickTableViewCellWithTableView:(UITableView *)tableView{
    static NSString *identifier = @"YYPickTableViewCell";
    YYPickTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YYPickTableViewCell" owner:nil options:nil] lastObject];
    }
    return cell;
}
- (void)awakeFromNib {
    
    [super awakeFromNib];
    /**
     *  设置约束
     */
    [self setViewsConstraints];
    /**
     *  设置属性
     */
    [self setViews];
}
#pragma maek 设置约束
/**
 *  设置约束
 */
- (void)setViewsConstraints{
    //上面部分的View
    [self.topGrayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(self.contentView);
        make.height.mas_equalTo(kTopGrayViewH);
    }];
    
    //采摘店铺图片
    [self.shopImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.contentView);
        make.top.mas_equalTo(self.topGrayView.mas_bottom);
        make.height.mas_equalTo(kShopImageViewH);
    }];
    //采摘店铺名称
    [self.shopNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).mas_offset(marginXY);
        make.top.mas_equalTo(self.shopImageView.mas_bottom).mas_offset(marginXY);
        make.height.mas_equalTo(kShopNameLabelH);
    }];
    // 采摘店铺营业时间的背景图片
    [self.shopTimeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kShopTimeLabelW, 15));
        make.top.mas_equalTo(self.shopNameLabel.mas_top).mas_offset(1.5);
    }];
    //采摘店铺营业时间Label
    [self.shopTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(self.shopTimeImageView.size);
        make.top.mas_equalTo(self.shopTimeImageView);
    }];
    //采摘店铺的距离店铺
    [self.shopDistanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView.mas_right).mas_offset(-marginXY);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).mas_offset(-marginXY);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(kShopDistanceLabelH);
    }];
    //采摘店铺的地址label
    [self.shopAddressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).mas_offset(marginXY);
        make.right.mas_equalTo(self.shopDistanceLabel.mas_left);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).mas_offset(-marginXY);
        make.height.mas_equalTo(kShopDistanceLabelH);
    }];
    //分割线
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.contentView);
        make.height.mas_equalTo(0.5);
    }];
}
#pragma mark 设置属性
/**
 *  设置属性
 */
- (void)setViews{
    self.topGrayView.backgroundColor = kViewBgGrayColor;
    
    self.shopNameLabel.textColor = kBlackTextColor;
    self.shopNameLabel.font = kShopNameLabelFont;
    self.shopNameLabel.adjustsFontSizeToFitWidth = YES;
    
    self.shopTimeLabel.textColor = kBlackTextColor;
    
    self.shopAddressLabel.textColor = kBlackTextColor;
//    self.shopAddressLabel.adjustsFontSizeToFitWidth = YES;
    
    self.shopDistanceLabel.textColor = kNavColor;
    self.shopDistanceLabel.textAlignment = NSTextAlignmentRight;
    
    self.lineView.backgroundColor = kGrayLineColor;
    
    
    
}
- (void)setModel:(YYPickTableViewModel *)model{
    _model = model;
    
    //设置cell的内容
    [self.shopImageView sd_setImageWithURL:[NSURL URLWithString:model.imgurl]];
    self.shopNameLabel.text = model.name;
    self.shopTimeLabel.text = model.time;
    self.shopAddressLabel.text = model.address;
    
    NSString *distance = nil;
    int juli = model.juli.intValue;
    if (juli > 1000) {
        distance = [NSString stringWithFormat:@"%.1f千米", juli / 1000.0];
    }
    else{
        distance = [NSString stringWithFormat:@"%d米",juli];
    }
    self.shopDistanceLabel.text = distance;
    
    //设置cell里面控件的位置
    CGFloat shopNameMaxLabelW = kWidthScreen - marginXY * 2 - kShopTimeLabelW - 5;
    CGFloat shopNameLabelW = [self calculateLabelWidthWithString:model.name andMaxStringW:shopNameMaxLabelW];
    [self.shopNameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(shopNameLabelW);
    }];
    [self.shopTimeImageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.shopNameLabel.mas_right).mas_offset(5);
    }];
    [self.shopTimeLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.shopTimeImageView);
    }];
}
#pragma mark 计算采摘店铺名称的宽度
/**
 *  计算采摘店铺名称的宽度
 */
- (CGFloat)calculateLabelWidthWithString:(NSString *)string andMaxStringW:(CGFloat)maxStringW{
    
    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
    attr[NSFontAttributeName] = kShopNameLabelFont;
    CGFloat stringW = [string boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, kShopNameLabelH) options:NSStringDrawingUsesLineFragmentOrigin attributes:attr context:nil].size.width;
    CGFloat lastStringW;
    if (stringW > maxStringW) {
        lastStringW = maxStringW;
    }
    else{
        lastStringW = stringW;
    }
    
    return lastStringW;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
