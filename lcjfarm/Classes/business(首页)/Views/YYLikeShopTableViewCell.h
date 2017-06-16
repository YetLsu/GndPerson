//
//  YYLikeShopTableViewCell.h
//  lcjfarm
//
//  Created by wyy on 16/7/5.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import <UIKit/UIKit.h>


@class YYFruitShopModel, YYPickTableViewModel;
@interface YYLikeShopTableViewCell : UITableViewCell

+ (instancetype)likeShopTableViewCellWithTableView:(UITableView *)tableView;
/**
 *  店铺模型
 */
@property (nonatomic, strong) YYFruitShopModel *shopModel;
/**
 *  采摘果园模型
 */
@property (nonatomic,strong) YYPickTableViewModel *pickModel;
@end
