//
//  YYSearchFruitNewsTableViewCell.h
//  lcjfarm
//
//  Created by wyy on 16/8/17.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import <UIKit/UIKit.h>


@class YYFruitNewsModel;
@interface YYSearchFruitNewsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *lineView;

@property (nonatomic, strong) YYFruitNewsModel *model;

+ (instancetype)YYSearchFruitNewsTableViewCellWithTableView:(UITableView *)tableView;

@end
