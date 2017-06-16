//
//  YYDiscoverTableViewCell.h
//  lcjfarm
//
//  Created by wyy on 16/8/10.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YYDiscoverTableViewCellModel;
@interface YYDiscoverTableViewCell : UITableViewCell

@property (nonatomic, strong) YYDiscoverTableViewCellModel *model;

+ (instancetype)discoverTableViewCellWithTableView:(UITableView *)tableView;
@end
