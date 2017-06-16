//
//  YYMarkTableViewCell.h
//  q
//
//  Created by wyy on 16/9/8.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import <UIKit/UIKit.h>


@class YYMarkModel;
@interface YYMarkTableViewCell : UITableViewCell

@property (nonatomic, strong) YYMarkModel *model;

+ (instancetype)markTableViewCellWithTableView:(UITableView *)tableView;

@end
