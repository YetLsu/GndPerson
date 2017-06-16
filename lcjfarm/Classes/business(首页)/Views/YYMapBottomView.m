//
//  YYMapBottomView.m
//  lcjfarm
//
//  Created by wyy on 16/7/8.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import "YYMapBottomView.h"
#import "YYFruitShopModel.h"
#import "YYPickTableViewModel.h"

@interface YYMapBottomView ()
/**
 *  店铺名字
 */
@property (weak, nonatomic) IBOutlet UILabel *shopNameLabel;
/**
 *  店铺地址
 */
@property (weak, nonatomic) IBOutlet UILabel *shopAddressLabel;
/**
 *  导航按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *navigationBtn;

@end
@implementation YYMapBottomView

- (void)awakeFromNib{
    [super awakeFromNib];
    
    [self.navigationBtn setTitle:@"地图导航" forState:UIControlStateNormal];
    //设置字体颜色
    self.shopNameLabel.textColor = kBlackTextColor;
    self.shopAddressLabel.textColor = kBlackTextColor;
    [self.navigationBtn setTitleColor:kNavColor forState:UIControlStateNormal];
    
    //设置字体
    self.shopNameLabel.font = [UIFont boldSystemFontOfSize:18.0];
    self.shopAddressLabel.font = [UIFont systemFontOfSize:15.0];
    self.navigationBtn.titleLabel.font = [UIFont boldSystemFontOfSize:20.0];
    
    self.shopNameLabel.adjustsFontSizeToFitWidth = YES;
    self.shopAddressLabel.adjustsFontSizeToFitWidth = YES;
}

- (void)setShopModel:(YYFruitShopModel *)shopModel{
    _shopModel = shopModel;
    self.shopNameLabel.text = shopModel.name;
    self.shopAddressLabel.text = shopModel.shopAddress;
    
}
- (void)setPickModel:(YYPickTableViewModel *)pickModel{
    _pickModel = pickModel;
    self.shopNameLabel.text = pickModel.name;
    self.shopAddressLabel.text = pickModel.address;
}
- (IBAction)navigationBtnClick:sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationNavigationMapClick object:self userInfo:nil];
}

@end
