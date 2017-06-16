//
//  YYLikeShopTableViewCell.m
//  lcjfarm
//
//  Created by wyy on 16/7/5.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import "YYLikeShopTableViewCell.h"
#import "YYFruitShopModel.h"
#import "YYPickTableViewModel.h"

@interface YYLikeShopTableViewCell ()
/**
 *  商铺图片ImageView
 */
@property (weak, nonatomic) IBOutlet UIImageView *shopImageView;
/**
 *  商铺名字Label
 */
@property (weak, nonatomic) IBOutlet UILabel *shopNameLabel;
/**
 *  商铺距离Label
 */
@property (weak, nonatomic) IBOutlet UILabel *shopDistanceLabel;

@property (weak, nonatomic) IBOutlet UIView *lineView;

@end

@implementation YYLikeShopTableViewCell
+ (instancetype)likeShopTableViewCellWithTableView:(UITableView *)tableView{
    static NSString *identifier = @"YYLikeShopTableViewCell";
    YYLikeShopTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YYLikeShopTableViewCell" owner:nil options:nil] lastObject];
    }
    return cell;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    
    // 商铺图片ImageView
    self.shopImageView.layer.cornerRadius = 10;
    self.shopImageView.layer.masksToBounds = YES;
    
    //商铺名字Label
    self.shopNameLabel.numberOfLines = 0;
    self.shopNameLabel.textColor = kBlackTextColor;
    self.shopNameLabel.font = [UIFont systemFontOfSize:15];
    
    //商铺距离Label
    self.shopDistanceLabel.textColor = kNavColor;
    self.shopDistanceLabel.font = [UIFont systemFontOfSize:15.0];
    
    //线
    self.lineView.backgroundColor = kGrayLineColor;
    
}
/**
 *  店铺模型
 */
- (void)setShopModel:(YYFruitShopModel *)shopModel{
    _shopModel = shopModel;
    [self.shopImageView sd_setImageWithURL:[NSURL URLWithString:shopModel.imgurl]];
    self.shopNameLabel.text = shopModel.name;
    
    NSString *distance = nil;
    int juli = shopModel.juli.intValue;
    if (juli > 1000) {
        distance = [NSString stringWithFormat:@"%.1f千米", juli / 1000.0];
    }
    else{
        distance = [NSString stringWithFormat:@"%d米",juli];
    }
    self.shopDistanceLabel.text = distance;
}
/**
 *  采摘果园模型
 */
- (void)setPickModel:(YYPickTableViewModel *)pickModel{
    _pickModel = pickModel;
    self.shopImageView.image = [UIImage imageNamed:pickModel.imgurl];
    self.shopNameLabel.text = pickModel.name;
    self.shopDistanceLabel.text = @">100M";

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
