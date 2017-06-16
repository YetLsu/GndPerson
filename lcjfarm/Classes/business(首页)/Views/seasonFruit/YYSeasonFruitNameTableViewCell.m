//
//  YYSeasonFruitNameTableViewCell.m
//  lcjfarm
//
//  Created by wyy on 16/8/11.
//  Copyright © 2016年 WYY. All rights reserved.
//
#define starW 14
#define starMargin 5
#import "YYSeasonFruitNameTableViewCell.h"

#import "YYSeasonFruitModel.h"

@interface YYSeasonFruitNameTableViewCell ()
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
 *  二十四节气图标
 */
@property (nonatomic, weak) UIImageView *dayImageView;
/**
 *  二十四节气文字
 */
@property (nonatomic, weak) UILabel *dayLabel;
@end

@implementation YYSeasonFruitNameTableViewCell
+ (instancetype)seasonFruitNameTableViewCellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"YYSeasonFruitNameTableViewCell";
    YYSeasonFruitNameTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[YYSeasonFruitNameTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
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
    /**
     *  水果名称
     */
    UILabel *fruitNameLabel = [[UILabel alloc] init];
    [self.contentView addSubview:fruitNameLabel];
    self.fruitNameLabel = fruitNameLabel;
    /**
     *  水果应季指数Label
     */
    UILabel *fruitGradeLabel = [[UILabel alloc] init];
    [self.contentView addSubview:fruitGradeLabel];
    self.fruitGradeLabel = fruitGradeLabel;
    self.fruitGradeLabel.text = @"应季指数：";
    /**
     *  水果应季指数星级无
     */
    UIImageView *noStarImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:noStarImageView];
    self.noStarImageView = noStarImageView;
    self.noStarImageView.image = [UIImage imageNamed:@"home_seasonStar_no"];
    self.noStarImageView.contentMode = UIViewContentModeLeft;
    /**
     *  水果应季指数星级有
     */
    UIImageView *haveStarImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:haveStarImageView];
    self.haveStarImageView = haveStarImageView;
    self.haveStarImageView.image = [UIImage imageNamed:@"home_seasonStar_have"];
    self.haveStarImageView.contentMode = UIViewContentModeLeft;
    /**
     *  二十四节气图标
     */
    UIImageView *dayImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:dayImageView];
    self.dayImageView = dayImageView;
    /**
     *  二十四节气文字
     */
    UILabel *dayLabel = [[UILabel alloc] init];
    [self.contentView addSubview:dayLabel];
    self.dayLabel = dayLabel;
}
#pragma mark 给子控件添加约束
/**
 *  给子控件添加约束
 */
- (void)addviewsConstraints{
    //水果名称
    [self.fruitNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(12);
        make.top.mas_equalTo(self.contentView.mas_top).mas_offset(24);
        make.height.mas_equalTo(24);
    }];
    //水果应季指数Label
    [self.fruitGradeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(50, 10));
        make.left.mas_equalTo(self.fruitNameLabel.mas_right).mas_offset(12);
        make.bottom.mas_equalTo(self.fruitNameLabel);
    }];
    //水果应季指数星级无
    CGFloat starH = 14;
    CGFloat allStarW = starW * 5 + starMargin * 4;
    [self.noStarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(allStarW, starH));
        make.left.mas_equalTo(self.fruitGradeLabel.mas_right);
        make.bottom.mas_equalTo(self.fruitNameLabel);
    }];
    
    //二十四节气图标
    CGFloat dayImageViewH = 33;
    CGFloat dayLabelH = 10;
    CGFloat dayH = dayImageViewH + dayLabelH + 5;
    
    CGFloat dayImageViewTop = (72 - dayH)/2.0;
    [self.dayImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(dayImageViewTop);
        make.size.mas_equalTo(CGSizeMake(dayImageViewH, dayImageViewH));
        make.right.mas_equalTo(self.contentView.mas_right).mas_offset(-20);
    }];
    //二十四节气文字
    [self.dayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.dayImageView.mas_bottom).mas_offset(5);
        make.size.mas_equalTo(CGSizeMake(33, dayLabelH));
        make.left.mas_equalTo(self.dayImageView);
    }];
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
    
    //二十四节气文字
    self.dayLabel.textColor = kBlackTextColor;
    self.dayLabel.font = [UIFont systemFontOfSize:10.0];
    self.dayLabel.textAlignment = NSTextAlignmentCenter;

}
/**
 *  设置模型
 */
- (void)setModel:(YYSeasonFruitModel *)model{
    _model = model;

    //水果名称更新约束
    NSString *fruitName = model.name;
    self.fruitNameLabel.text = fruitName;
    
    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
    attr[NSFontAttributeName] = [UIFont boldSystemFontOfSize:22.0];
    CGFloat fruitNameW = [fruitName boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, 22) options:NSStringDrawingUsesLineFragmentOrigin attributes:attr context:nil].size.width + 5;
    [self.fruitNameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(fruitNameW);
    }];
    
    //设置星级
    CGFloat star = model.exponent.floatValue;
    NSInteger starNumber = (NSInteger)star;
    CGFloat haveStarW = star * starW + starNumber * starMargin;
    CGFloat starH = 14;
    [self.haveStarImageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(starH);
        make.left.mas_equalTo(self.fruitGradeLabel.mas_right);
        make.bottom.mas_equalTo(self.fruitNameLabel);
        make.width.mas_equalTo(haveStarW);
    }];
    [self.haveStarImageView setContentScaleFactor:2];
    self.haveStarImageView.layer.masksToBounds = YES;
#warning xiugai
    //二十四节气图标
//    self.dayImageView.image = [UIImage imageNamed:@"discover_fruitNews"];
    //二十四节气文字
//    self.dayLabel.text = @"夏至";
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
