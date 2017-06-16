//
//  YYHomeImageBtnTableViewCell.h
//  lcjfarm
//
//  Created by wyy on 16/6/27.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import <UIKit/UIKit.h>


@class YYHomeImageBtnModel;
@interface YYHomeImageBtnTableViewCell : UITableViewCell

@property (nonatomic, strong) YYHomeImageBtnModel *model;

+ (instancetype)homeImageBtnTableViewCellWithTableView:(UITableView *)tableView;
@end
