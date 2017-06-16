//
//  YYPickIntroTableViewCell.h
//  lcjfarm
//
//  Created by wyy on 16/7/5.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import <UIKit/UIKit.h>


@class YYPickTableViewModel;
@interface YYPickIntroTableViewCell : UITableViewCell
@property (nonatomic, strong) YYPickTableViewModel *model;

+ (instancetype)pickIntroTableViewCellWithTableView:(UITableView *)tableView;
@end
