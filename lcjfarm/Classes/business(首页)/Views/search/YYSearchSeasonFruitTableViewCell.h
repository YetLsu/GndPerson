//
//  YYSearchSeasonFruitTableViewCell.h
//  lcjfarm
//
//  Created by wyy on 16/8/17.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YYSeasonFruitModel;
@interface YYSearchSeasonFruitTableViewCell : UITableViewCell

@property (nonatomic, strong) YYSeasonFruitModel *model;

/**
 *  线
 */
@property (weak, nonatomic) IBOutlet UIView *lineView;

+ (instancetype)searchSeasonFruitTableViewCellWithTableView:(UITableView *)tableView;


@end
