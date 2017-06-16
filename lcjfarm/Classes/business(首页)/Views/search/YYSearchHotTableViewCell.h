//
//  YYSearchHotTableViewCell.h
//  lcjfarm
//
//  Created by wyy on 16/8/16.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import <UIKit/UIKit.h>


@class YYSearchWordModel;
@interface YYSearchHotTableViewCell : UITableViewCell
@property (nonatomic, strong)YYSearchWordModel *model;

+ (instancetype)searchHotTableViewCellWithTableView:(UITableView *)tableView;

@end
