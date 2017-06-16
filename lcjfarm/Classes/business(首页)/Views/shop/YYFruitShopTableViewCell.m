//
//  YYFruitTableViewCell.m
//  lcjfarm
//
//  Created by wyy on 16/6/27.
//  Copyright © 2016年 WYY. All rights reserved.
//
#define starH 13
#define starW 13.5
#define starMargin 5

#import "YYFruitShopTableViewCell.h"
#import "YYFruitShopModel.h"

@interface YYFruitShopTableViewCell ()
/**
 *  店铺图片ImageView
 */
@property (weak, nonatomic) IBOutlet UIImageView *shopImageView;
/**
 *  图片左间距的约束
 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *shopImageViewConstraint;
/**
 *  水果店名称Label
 */

@property (weak, nonatomic) IBOutlet UILabel *shopTitleLabel;
/**
 *  有星星的imageView
 */
@property (weak, nonatomic) IBOutlet UIImageView *haveStarImageView;
/**
 *  有星星的imageView的宽度约束
 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *haveStarImageConstraintW;

/**
 *  地点Label
 */
@property (weak, nonatomic) IBOutlet UILabel *shopAddressLabel;
/**
 *  距离Label
 */
@property (weak, nonatomic) IBOutlet UILabel *shopDistanceLabel;
/**
 *  下面的分割线
 */
@property (weak, nonatomic) IBOutlet UIView *lineView;

@end

@implementation YYFruitShopTableViewCell
+ (instancetype)fruitShopTableViewCellWithTableView:(UITableView *)tableView{
    static NSString *idenrtifier = @"YYFruitShopTableViewCell";
    YYFruitShopTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:idenrtifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YYFruitShopTableViewCell" owner:nil options:nil] lastObject];
    }
    return cell;
}
- (void)awakeFromNib {
    [super awakeFromNib];
//    YYLog(@"调用awakeFromNib");
//    [self.shopImageView mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(k12WidthMargin);
//    }];
    self.haveStarImageView.contentMode =  UIViewContentModeLeft;
    self.shopTitleLabel.adjustsFontSizeToFitWidth = YES;
    self.shopDistanceLabel.adjustsFontSizeToFitWidth = YES;
    
    self.shopImageViewConstraint.constant = k12WidthMargin;
    self.lineView.backgroundColor = kGrayLineColor;
    self.shopTitleLabel.textColor = kBlackTextColor;
    self.shopAddressLabel.textColor = kGrayTextColor;
    self.shopDistanceLabel.textColor = kNavColor;
}

- (void)setModel:(YYFruitShopModel *)model{
    _model = model;
  
    [self.shopImageView sd_setImageWithURL:[NSURL URLWithString:model.imgurl]];
    self.shopTitleLabel.text = model.name;
    self.shopAddressLabel.text = model.shopAddress;
    
    
    NSString *distance = nil;
    int juli = model.juli.intValue;
    if (juli > 1000) {
        distance = [NSString stringWithFormat:@"%.1f千米", juli / 1000.0];
    }
    else{
        distance = [NSString stringWithFormat:@"%d米",juli];
    }
    self.shopDistanceLabel.text = distance;
    
    /**
     *  五颗星星实的imageView29
     */
    CGFloat starNumber = model.grade.floatValue;
    
    NSInteger marginNumber = (NSInteger)starNumber;
    CGFloat starHaveW = starW * starNumber + starMargin * marginNumber;
    self.haveStarImageConstraintW.constant = starHaveW;
    [self.haveStarImageView setContentScaleFactor:2];
    self.haveStarImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth;//根据你的需求
    self.haveStarImageView.clipsToBounds  = YES;//切掉多余部分
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
