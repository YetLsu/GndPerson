//
//  YYFruitNewsTableViewCell.h
//  lcjfarm
//
//  Created by wyy on 16/7/13.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import <UIKit/UIKit.h>


@class YYFruitNewsModel;
@interface YYFruitNewsTableViewCell : UITableViewCell

@property (nonatomic, strong) YYFruitNewsModel *model;

+ (instancetype)fruitNewsTableViewCellWithTableView:(UITableView *)tableView;
@end
