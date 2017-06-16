//
//  YYSeasonFruitMessageTableViewCell.m
//  lcjfarm
//
//  Created by wyy on 16/8/11.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import "YYSeasonFruitMessageTableViewCell.h"

#import "YYSeasonFruitModel.h"

#import "YYSeasonFruitMessageTableViewCellTitleView.h"
#import "YYSeasonFruitMessageBasicView.h"

#import "PNChart.h"

@interface YYSeasonFruitMessageTableViewCell ()
@property (nonatomic, weak) YYSeasonFruitMessageBasicView *timeView;
@property (nonatomic, weak) YYSeasonFruitMessageBasicView *heatView;
@property (nonatomic, weak) YYSeasonFruitMessageBasicView *attributeView;

@property (nonatomic, strong) NSArray *colorsArray;
@end

@implementation YYSeasonFruitMessageTableViewCell
+ (instancetype)seasonFruitMessageTableViewCellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"YYSeasonFruitMessageTableViewCell";
    YYSeasonFruitMessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[YYSeasonFruitMessageTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //添加子控件
        [self addsubViews];
        //给子控件添加约束
        [self addviewsConstraints];
        //设置子控件的属性
        [self setViews];
        
    }
    return self;
}
#pragma mark 添加子控件
/**
 *  添加子控件
 */
- (void)addsubViews{
    //增加基础信息部分的View
    [self addBasicMessageViews];
    
    //增加营养成分标题的View
    CGFloat nutritionMessageViewY = 12 + 18 + 12 + 70 + 24;
    YYSeasonFruitMessageTableViewCellTitleView *nutritionMessageView = [[YYSeasonFruitMessageTableViewCellTitleView alloc] initWithTitle:@"营养成分" andFrame:CGRectMake(0, nutritionMessageViewY, kWidthScreen, 18)];
    [self.contentView addSubview:nutritionMessageView];
    
    //增加存储方式标题的View
    CGFloat storingMessageViewY = nutritionMessageViewY + 18 + 12 + 175 + 24;
    YYSeasonFruitMessageTableViewCellTitleView *storingMessageView = [[YYSeasonFruitMessageTableViewCellTitleView alloc] initWithTitle:@"存储方式" andFrame:CGRectMake(0, storingMessageViewY, kWidthScreen, 18)];
    [self.contentView addSubview:storingMessageView];
    
}
//增加基础信息部分的View
- (void)addBasicMessageViews{
    YYSeasonFruitMessageTableViewCellTitleView *basicMessageView = [[YYSeasonFruitMessageTableViewCellTitleView alloc] initWithTitle:@"基础信息" andFrame:CGRectMake(0, 12, kWidthScreen, 18)];
    [self.contentView addSubview:basicMessageView];
    
    CGFloat basicViewMargin = 10 / 375.0 * kWidthScreen;
    CGFloat basicViewW = (kWidthScreen - 4 * basicViewMargin)/3.0;
    CGFloat basicViewH = 70;
    CGFloat basicViewY = 12 + 18 + 12;
    YYSeasonFruitMessageBasicView *timeView = [[YYSeasonFruitMessageBasicView alloc] initWithFrame:CGRectMake(basicViewMargin, basicViewY, basicViewW, basicViewH) topTitle:@"上市时间" centerTitle:nil bottomTitle:@"月份"];
    [self.contentView addSubview:timeView];
    self.timeView = timeView;
    
    YYSeasonFruitMessageBasicView *heatView = [[YYSeasonFruitMessageBasicView alloc] initWithFrame: CGRectMake(basicViewMargin * 2 + basicViewW, basicViewY, basicViewW, basicViewH) topTitle:@"热量" centerTitle:nil bottomTitle:@"卡路里/100g"];
    [self.contentView addSubview:heatView];
    heatView.frame = CGRectMake(basicViewMargin * 2 + basicViewW, basicViewY, basicViewW, basicViewH);
    self.heatView = heatView;
    
    YYSeasonFruitMessageBasicView *attributeView = [[YYSeasonFruitMessageBasicView alloc] initWithFrame: CGRectMake(basicViewMargin * 3 + basicViewW * 2, basicViewY, basicViewW, basicViewH) topTitle:@"属性" centerTitle:nil bottomTitle:@"碱"];
    [self.contentView addSubview:attributeView];
    attributeView.frame = CGRectMake(basicViewMargin * 3 + basicViewW * 2, basicViewY, basicViewW, basicViewH);
    self.attributeView = attributeView;
}
#pragma mark 给子控件添加约束
/**
 *  给子控件添加约束
 */
- (void)addviewsConstraints{
}
#pragma mark 设置子控件的属性
/**
 *  设置子控件的属性
 */
- (void)setViews{
}
/**
 *  设置模型
 */
- (void)setModel:(YYSeasonFruitModel *)model{
    self.timeView.centerTitle = model.time;
    
    self.heatView.centerTitle = model.calorie;
    
    self.attributeView.centerTitle = model.attribute;
    //增加扇形图
    [self addPieChatWithModel:model];
    
    //增加存放方式的Label的View
    CGFloat nutritionMessageViewY = 12 + 18 + 12 + 70 + 24;
    CGFloat pieY = nutritionMessageViewY + 18 + 12;
    CGFloat pieH = 175;
    CGFloat labelView1Y = pieY + pieH + 24 + 18 + 12;

    [self addLabelViewWithTitle:[NSString stringWithFormat:@"存放方式：%@", model.storagemode] andFrame:CGRectMake(0, labelView1Y, kWidthScreen, 13)];
    
    //增加保存时间的Label的View
    [self addLabelViewWithTitle:[NSString stringWithFormat:@"保存时间：%@", model.storagetime] andFrame:CGRectMake(0, labelView1Y + 13 + 12, kWidthScreen, 13)];
}
#pragma mark 增加扇形图
/**
 *   增加扇形图
 */
- (void)addPieChatWithModel:(YYSeasonFruitModel *)model{
    
    NSArray *specificArray = [model.specific componentsSeparatedByString:@"|"];
    NSMutableArray *pieItemArray = [NSMutableArray array];
    for (int i = 0; i < 8; i++) {
        [pieItemArray addObject:[PNPieChartDataItem dataItemWithValue:10 color:self.colorsArray[i] description:specificArray[i]]];
    }
    
    
    CGFloat nutritionMessageViewY = 12 + 18 + 12 + 70 + 24;
    CGFloat pieY = nutritionMessageViewY + 18 + 12;
    CGFloat pieW = 175;
    CGFloat pieX = (kWidthScreen - pieW)/2.0;
    
    PNPieChart *pieChat = [[PNPieChart alloc] initWithFrame:CGRectMake(pieX, pieY, pieW, pieW) items:pieItemArray];
    
    pieChat.descriptionTextColor = [UIColor whiteColor];
    pieChat.descriptionTextFont = [UIFont systemFontOfSize:11.0];
    pieChat.descriptionTextShadowColor = [UIColor clearColor];
    pieChat.hideValues = YES;
    [pieChat strokeChart];
    
    [self.contentView addSubview:pieChat];
}
#pragma mark 增加存放方式的Label的View
/**
 *  增加存放方式的Label的View
 */
- (void)addLabelViewWithTitle:(NSString *)title andFrame:(CGRect)ViewFrame{
    UIView *labelView = [[UIView alloc] initWithFrame:ViewFrame];
    [self.contentView addSubview:labelView];
    
    //增加绿色的小圆标
    UIView *circleView = [[UIView alloc] init];
    CGFloat circleViewX = 30/375.0 * kWidthScreen;
    CGFloat circleViewW = 5;
    CGFloat circleViewY = (ViewFrame.size.height - circleViewW)/2.0;
    circleView.frame = CGRectMake(circleViewX, circleViewY, circleViewW, circleViewW);
    circleView.backgroundColor = kNavColor;
    circleView.layer.cornerRadius = 2.5;
    circleView.layer.masksToBounds = YES;
    [labelView addSubview:circleView];
    //增加Label
    UILabel *label = [[UILabel alloc] init];
    [labelView addSubview:label];
    CGFloat labelX = circleViewX + circleViewW + 5;
    CGFloat labelW = kWidthScreen - labelX - 12;
    label.frame = CGRectMake(labelX, 0, labelW, ViewFrame.size.height);
    label.textColor = kNavColor;
    label.font = [UIFont systemFontOfSize:13.0];
    label.text = title;
}
- (NSArray *)colorsArray{
    if (!_colorsArray) {
        UIColor *color0 = kRGBAColor(149, 228, 133, 1);
        UIColor *color1 = kRGBAColor(177, 217, 99, 1);
        UIColor *color2 = kRGBAColor(218, 220, 88, 1);
        UIColor *color3 = kRGBAColor(135, 221, 88, 1);
        UIColor *color4 = kRGBAColor(220, 172, 88, 1);
        UIColor *color5 = kRGBAColor(188, 176, 240, 1);
        UIColor *color6 = kRGBAColor(237, 222, 124, 1);
        UIColor *color7 = kRGBAColor(133, 228, 193, 1);
        
        _colorsArray = @[color0, color1, color2, color3, color4, color5, color6, color7];
    }
    
    return _colorsArray;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
