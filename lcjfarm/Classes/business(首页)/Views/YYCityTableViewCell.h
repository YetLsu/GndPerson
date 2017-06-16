//
//  YYCityTableViewCell.h
//  lcjfarm
//
//  Created by wyy on 16/7/15.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import <UIKit/UIKit.h>


@class YYCityModel;
@interface YYCityTableViewCell : UITableViewCell

@property (nonatomic, strong) YYCityModel *model;

+ (instancetype)cityTableViewCellWithTableView:(UITableView *)tableView;
@end
