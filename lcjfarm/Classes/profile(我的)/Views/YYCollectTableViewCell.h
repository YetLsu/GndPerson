//
//  YYCollectTableViewCell.h
//  lcjfarm
//
//  Created by wyy on 16/7/14.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YYFruitShopModel, YYPickTableViewModel;
@interface YYCollectTableViewCell : UITableViewCell

@property (nonatomic, strong) YYFruitShopModel *shopModel;

@property (nonatomic, strong) YYPickTableViewModel *pickModel;

+ (instancetype)tableViewCellWithTableView:(UITableView *)tableView;

@end
