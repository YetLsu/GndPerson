//
//  YYCollectTableViewCell.m
//  lcjfarm
//
//  Created by wyy on 16/7/14.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import "YYCollectTableViewCell.h"
#import "YYFruitShopModel.h"
#import "YYPickTableViewModel.h"

@interface YYCollectTableViewCell ()
/**
 *  商铺图片ImageView
 */
@property (weak, nonatomic) IBOutlet UIImageView *shopImageView;
/**
 *  商铺名称Label
 */
@property (weak, nonatomic) IBOutlet UILabel *shopNameLabel;
/**
 *  进入店铺Label
 */
@property (weak, nonatomic) IBOutlet UILabel *gotoShopLabel;

/**
 *  分割线的View
 */
@property (weak, nonatomic) IBOutlet UIView *lineView;

@end

@implementation YYCollectTableViewCell
+ (instancetype)tableViewCellWithTableView:(UITableView *)tableView{
    static NSString *Identifier = @"YYCollectTableViewCell";
    YYCollectTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YYCollectTableViewCell" owner:nil options:nil] lastObject];
    }
    return cell;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.shopImageView.layer.cornerRadius = 5;
    self.shopImageView.layer.masksToBounds = YES;
    
    self.shopNameLabel.textColor = kBlackTextColor;
    self.shopNameLabel.font = [UIFont systemFontOfSize:15.0];
    
    self.gotoShopLabel.text = @">>进入店铺";
    self.gotoShopLabel.textColor = kNavColor;
    self.gotoShopLabel.font = [UIFont systemFontOfSize:15.0];
    
    self.lineView.backgroundColor = kGrayLineColor;
    
}
- (void)setShopModel:(YYFruitShopModel *)shopModel{
    _shopModel = shopModel;
    [self.shopImageView sd_setImageWithURL:[NSURL URLWithString:shopModel.imgurl]];
    self.shopNameLabel.text = shopModel.name;

    
}
- (void)setPickModel:(YYPickTableViewModel *)pickModel{
    _pickModel = pickModel;
    
    [self.shopImageView sd_setImageWithURL:[NSURL URLWithString:pickModel.imgurl]];
    self.shopNameLabel.text = pickModel.name;
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}


@end
