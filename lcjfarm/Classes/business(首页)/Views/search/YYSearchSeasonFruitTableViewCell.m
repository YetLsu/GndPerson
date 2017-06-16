//
//  YYSearchSeasonFruitTableViewCell.m
//  lcjfarm
//
//  Created by wyy on 16/8/17.
//  Copyright © 2016年 WYY. All rights reserved.
//
#define starW 14
#define starMargin 5

#import "YYSearchSeasonFruitTableViewCell.h"

#import "YYSeasonFruitModel.h"

@interface YYSearchSeasonFruitTableViewCell ()
/**
 *  水果图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *fruitImageView;
/**
 *  水果名称
 */
@property (weak, nonatomic) IBOutlet UILabel *fruitNameLabel;
/**
 *  应季指数Label
 */
@property (weak, nonatomic) IBOutlet UILabel *seasonLabel;
/**
 *  没有星星的ImageView
 */
@property (weak, nonatomic) IBOutlet UIImageView *noStarImageView;

/**
 *  有星星的ImageView
 */
@property (weak, nonatomic) IBOutlet UIImageView *haveStarImageView;
/**
 *  属性Label
 */
@property (weak, nonatomic) IBOutlet UILabel *attributeLabel;
/**
 *  热量Label
 */
@property (weak, nonatomic) IBOutlet UILabel *hotLabel;


@end

@implementation YYSearchSeasonFruitTableViewCell
+ (instancetype)searchSeasonFruitTableViewCellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"YYSearchSeasonFruitTableViewCell";
    YYSearchSeasonFruitTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YYSearchSeasonFruitTableViewCell" owner:nil options:nil] lastObject];
    }
    return cell;
}
- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    //清除所有约束
    [self.contentView removeConstraints:[self.contentView constraints]];
    //设置约束
    [self setConstaints];
    
    //设置子控件的属性
    [self setViews];
    
}
/**
 *  设置约束
 */
- (void)setConstaints{
    //水果图片
    [self.fruitImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).mas_equalTo(12);
        make.size.mas_equalTo(CGSizeMake(90, 76));
        make.top.mas_equalTo(self.contentView.mas_top).mas_offset(12);
    }];
    //水果名称
    CGFloat nameH = 17;
    [self.fruitNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.fruitImageView.mas_right).mas_offset(12);
        make.top.mas_equalTo(self.fruitImageView.mas_top).mas_offset(5);
        make.height.mas_equalTo(nameH);
    }];
    //水果应季指数Label
    [self.seasonLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(50, 10));
        make.left.mas_equalTo(self.fruitNameLabel.mas_right).mas_offset(10);
        make.bottom.mas_equalTo(self.fruitNameLabel);
    }];
    //水果应季指数星级无
    CGFloat starH = 14;
    CGFloat allStarW = starW * 5 + starMargin * 4;
    [self.noStarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(allStarW, starH));
        make.left.mas_equalTo(self.seasonLabel.mas_right);
        make.bottom.mas_equalTo(self.fruitNameLabel);
    }];
    self.noStarImageView.contentMode = UIViewContentModeLeft;
    //水果应季指数星级有
    [self.haveStarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(allStarW, starH));
        make.left.mas_equalTo(self.seasonLabel.mas_right);
        make.bottom.mas_equalTo(self.fruitNameLabel);
    }];
    self.haveStarImageView.contentMode = UIViewContentModeLeft;
    //水果属性Label
    [self.attributeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.fruitNameLabel.mas_bottom).mas_offset(12);
        make.left.mas_equalTo(self.fruitImageView.mas_right).mas_offset(12);
        make.right.mas_equalTo(self.contentView.mas_right).mas_offset(-12);
        make.height.mas_equalTo(13);
    }];
    //水果热量Label
    [self.hotLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.attributeLabel.mas_bottom).mas_offset(12);
        make.left.mas_equalTo(self.fruitImageView.mas_right).mas_offset(12);
        make.right.mas_equalTo(self.contentView.mas_right).mas_offset(-12);
        make.height.mas_equalTo(13);
    }];
    //线
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).mas_offset(12);
        make.right.mas_equalTo(self.contentView.mas_right).mas_offset(-12);
        make.height.mas_equalTo(0.5);
        make.bottom.mas_equalTo(self.contentView.mas_bottom);
    }];

}
#pragma mark 设置子控件的属性
/**
 *  设置子控件的属性
 */
- (void)setViews{
    //水果名称
    self.fruitNameLabel.font = [UIFont boldSystemFontOfSize:17.0];
    self.fruitNameLabel.textColor = kBlackTextColor;
    //水果应季指数Label
    self.seasonLabel.textColor = kBlackTextColor;
    self.seasonLabel.font = [UIFont systemFontOfSize:10.0];
    self.seasonLabel.text = @"应季指数:";
    //水果属性
    self.attributeLabel.textColor = kGray99TextColor;
    self.attributeLabel.font = [UIFont systemFontOfSize:13.0];
    //水果热量
    self.hotLabel.textColor = kGray99TextColor;
    self.hotLabel.font = [UIFont systemFontOfSize:13.0];
    
    self.lineView.backgroundColor = kGrayLineColor;
    
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
    attr[NSFontAttributeName] = [UIFont boldSystemFontOfSize:17.0];
    CGFloat fruitNameW = [fruitName boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, 22) options:NSStringDrawingUsesLineFragmentOrigin attributes:attr context:nil].size.width;
    [self.fruitNameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(fruitNameW);
    }];
    
    //设置星级
    CGFloat star = model.exponent.floatValue;
    NSInteger starNumber = (NSInteger)star;
    CGFloat haveStarW = star * starW + starNumber * starMargin;
    [self.haveStarImageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(haveStarW);
    }];
    [self.haveStarImageView setContentScaleFactor:2];
    self.haveStarImageView.layer.masksToBounds = YES;
    
    //属性
    self.attributeLabel.text = model.acid_alk;
    
    //水果热量
    self.hotLabel.text = [NSString stringWithFormat:@"热量：%@卡路里/100g", model.calorie];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
