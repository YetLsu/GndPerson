//
//  YYPickTableViewCell.h
//  lcjfarm
//
//  Created by wyy on 16/6/29.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YYPickTableViewModel;

@interface YYPickTableViewCell : UITableViewCell
@property (nonatomic, strong) YYPickTableViewModel *model;

+ (instancetype)pickTableViewCellWithTableView:(UITableView *)tableView;
@end
