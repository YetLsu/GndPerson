//
//  YYSeasonFruitMessageTableViewCell.h
//  lcjfarm
//
//  Created by wyy on 16/8/11.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YYSeasonFruitModel;
@interface YYSeasonFruitMessageTableViewCell : UITableViewCell
@property (nonatomic, strong) YYSeasonFruitModel *model;

+ (instancetype)seasonFruitMessageTableViewCellWithTableView:(UITableView *)tableView;
@end
