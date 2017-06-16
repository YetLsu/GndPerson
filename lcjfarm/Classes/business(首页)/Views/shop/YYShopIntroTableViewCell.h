//
//  YYShopIntroTableViewCell.h
//  lcjfarm
//
//  Created by wyy on 16/7/4.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import <UIKit/UIKit.h>


@class YYFruitShopModel;

@interface YYShopIntroTableViewCell : UITableViewCell
@property (nonatomic, strong) YYFruitShopModel *model;

+ (instancetype)shopIntroTableViewCellWithTableView:(UITableView *)tableView;
@end
