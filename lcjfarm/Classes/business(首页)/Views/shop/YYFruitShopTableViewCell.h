//
//  YYFruitTableViewCell.h
//  lcjfarm
//
//  Created by wyy on 16/6/27.
//  Copyright © 2016年 WYY. All rights reserved.
//
/**
 *  单元格高度114
 */
#import <UIKit/UIKit.h>

@class YYFruitShopModel;
@interface YYFruitShopTableViewCell : UITableViewCell

@property (nonatomic, strong) YYFruitShopModel *model;

+ (instancetype)fruitShopTableViewCellWithTableView:(UITableView *)tableView;

@end
