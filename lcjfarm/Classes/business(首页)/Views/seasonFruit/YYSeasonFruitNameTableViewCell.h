//
//  YYSeasonFruitNameTableViewCell.h
//  lcjfarm
//
//  Created by wyy on 16/8/11.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YYSeasonFruitModel;
@interface YYSeasonFruitNameTableViewCell : UITableViewCell

@property (nonatomic, strong) YYSeasonFruitModel *model;

+ (instancetype)seasonFruitNameTableViewCellWithTableView:(UITableView *)tableView;

@end
