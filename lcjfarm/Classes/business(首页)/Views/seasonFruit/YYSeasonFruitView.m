//
//  YYSeasonFruitView.m
//  lcjfarm
//
//  Created by wyy on 16/7/11.
//  Copyright © 2016年 WYY. All rights reserved.
//
#define starW 14
#define starMargin 5

#import "YYSeasonFruitView.h"

#import "YYSeasonFruitModel.h"

@interface YYSeasonFruitView ()
/**
 *  水果图片ImageView
 */
@property (nonatomic, weak) UIImageView *fruitImageView;
/**
 *  水果名称
 */
@property (nonatomic,weak) UILabel *fruitNameLabel;
/**
 *  水果应季指数Label
 */
@property (nonatomic, weak) UILabel *fruitGradeLabel;
/**
 *  水果应季指数星级有
 */
@property (nonatomic, weak) UIImageView *haveStarImageView;
/**
 *  水果应季指数星级无
 */
@property (nonatomic, weak) UIImageView *noStarImageView;
/**
 *  水果上市时间Label
 */
@property (nonatomic, weak) UILabel *fruitTimeToMarketLabel;
/**
 *  水果热量Label
 */
@property (nonatomic, weak) UILabel *fruitHeatLabel;

@end

@implementation YYSeasonFruitView

/**
 *  创建应季水果的View
 */
+ (instancetype)seasonFruitView{
    YYSeasonFruitView *seasonView = [[YYSeasonFruitView alloc] init];
    return seasonView;
}
/**
 *  创建应季水果的View
 */
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
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
    /**
     *  水果图片ImageView
     */
    CGFloat fruitImageViewH = 250/603.0*kNoNavHeight;
    UIImageView *fruitImageView = [[UIImageView alloc] init];
    fruitImageView.frame = CGRectMake(0, 0, self.width, fruitImageViewH);
    [self addSubview:fruitImageView];
    self.fruitImageView = fruitImageView;
    /**
     *  水果名称
     */
    UILabel *fruitNameLabel = [[UILabel alloc] init];
    CGFloat fruitNameLabelY = fruitImageViewH + 12;
    CGFloat fruitNameLabelH = 22;
    fruitNameLabel.frame = CGRectMake(12, fruitNameLabelY, 0, fruitNameLabelH);
    [self addSubview:fruitNameLabel];
    self.fruitNameLabel = fruitNameLabel;
    /**
     *  水果应季指数Label
     */
    CGFloat fruitGradeLabelH = 10;
    CGFloat fruitGradeLabelW = 50;
    CGFloat fruitGradeLabelY = fruitNameLabelY + (fruitNameLabelH - fruitGradeLabelH);
    UILabel *fruitGradeLabel = [[UILabel alloc] init];
    fruitGradeLabel.frame = CGRectMake(0, fruitGradeLabelY, fruitGradeLabelW, fruitGradeLabelH);
    [self addSubview:fruitGradeLabel];
    self.fruitGradeLabel = fruitGradeLabel;
    self.fruitGradeLabel.text = @"应季指数：";
    /**
     *  水果应季指数星级无
     */
    CGFloat starH = 14;
    CGFloat allStarW = starW * 5 + starMargin * 4;
    CGFloat starY = fruitNameLabelY + (fruitNameLabelH - starH);
    UIImageView *noStarImageView = [[UIImageView alloc] init];
    noStarImageView.frame = CGRectMake(0, starY, allStarW, starH);
    [self addSubview:noStarImageView];
    
    self.noStarImageView = noStarImageView;
    self.noStarImageView.image = [UIImage imageNamed:@"home_seasonStar_no"];
    self.noStarImageView.contentMode = UIViewContentModeLeft;
    /**
     *  水果应季指数星级有
     */
    UIImageView *haveStarImageView = [[UIImageView alloc] init];
    haveStarImageView.frame = CGRectMake(0, starY, allStarW, starH);
    [self addSubview:haveStarImageView];
    self.haveStarImageView = haveStarImageView;
    self.haveStarImageView.image = [UIImage imageNamed:@"home_seasonStar_have"];
    self.haveStarImageView.contentMode = UIViewContentModeLeft;
   
    /**
     *  水果上市时间Label
     */
    CGFloat fruitTimeLabelY = fruitNameLabelY + fruitNameLabelH + 10;
    CGFloat fruitTimeLabelW = self.width - 24;
    CGFloat fruitTimeLabelH = 16;
    UILabel *fruitTimeToMarketLabel = [[UILabel alloc] init];
    fruitTimeToMarketLabel.frame = CGRectMake(12, fruitTimeLabelY, fruitTimeLabelW, fruitTimeLabelH);
    [self addSubview:fruitTimeToMarketLabel];
    self.fruitTimeToMarketLabel = fruitTimeToMarketLabel;
    
    /**
     *  水果热量Label
     */
    CGFloat fruitHeatLabelX = 12;
    CGFloat fruitHeatLabelY = fruitTimeLabelY + fruitTimeLabelH + 10;
    UILabel *fruitHeatLabel = [[UILabel alloc] init];
    fruitHeatLabel.frame = CGRectMake(fruitHeatLabelX, fruitHeatLabelY, fruitTimeLabelW, fruitTimeLabelH);
    [self addSubview:fruitHeatLabel];
    self.fruitHeatLabel = fruitHeatLabel;

   
}
#pragma mark 给子控件添加约束
/**
 *  给子控件添加约束
 */
- (void)addviewsConstraints{


  
    //水果上市时间
  
    //水果热量Label
    
   
}
#pragma mark 设置子控件的属性
/**
 *  设置子控件的属性
 */
- (void)setViews{
    //水果名称
    self.fruitNameLabel.font = [UIFont boldSystemFontOfSize:22.0];
    self.fruitNameLabel.textColor = kBlackTextColor;
    //水果应季指数Label
    self.fruitGradeLabel.textColor = kBlackTextColor;
    self.fruitGradeLabel.font = [UIFont systemFontOfSize:10.0];
    //水果上市时间
    self.fruitTimeToMarketLabel.textColor = kGray99TextColor;
    self.fruitTimeToMarketLabel.font = [UIFont systemFontOfSize:15.0];
    //水果热量
    self.fruitHeatLabel.textColor = kGray99TextColor;
    self.fruitHeatLabel.font = [UIFont systemFontOfSize:15.0];
    
}
/**
 *  设置模型
 */
- (void)setModel:(YYSeasonFruitModel *)model{
    _model = model;
    [self.fruitImageView sd_setImageWithURL:[NSURL URLWithString:model.imgurl]];

    //水果名称更新约束
    NSString *fruitName = model.name;
    self.fruitNameLabel.text = fruitName;
    
    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
    attr[NSFontAttributeName] = [UIFont boldSystemFontOfSize:22.0];
    CGFloat fruitNameW = [fruitName boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, 22) options:NSStringDrawingUsesLineFragmentOrigin attributes:attr context:nil].size.width + 5;
    self.fruitNameLabel.width = fruitNameW;
    //设置应季指数label
    self.fruitGradeLabel.x = self.fruitNameLabel.x + fruitNameW + 12;
    
    self.noStarImageView.x = self.fruitGradeLabel.x + self.fruitGradeLabel.width + 5;
    

    //设置星级
    CGFloat star = model.exponent.floatValue;
    NSInteger starNumber = (NSInteger)star;
    CGFloat haveStarW = star * starW + starNumber * starMargin;
    self.haveStarImageView.x = self.noStarImageView.x;
    self.haveStarImageView.width = haveStarW;

    [self.haveStarImageView setContentScaleFactor:2];
    self.haveStarImageView.layer.masksToBounds = YES;
    
    //上市时间
//    self.fruitAliasLabel.text = [NSString stringWithFormat:@"别称：%@",model.alias];
    self.fruitTimeToMarketLabel.text = [NSString stringWithFormat:@"上市时间：%@月份",model.time];
    
    //水果热量
    self.fruitHeatLabel.text = [NSString stringWithFormat:@"热量：%@卡路里/100g", model.calorie];

}
@end
