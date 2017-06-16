//
//  YYPickIntroThreeCell.h
//  lcjfarm
//
//  Created by wyy on 16/7/6.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YYPickIntroModel;
@interface YYPickIntroThreeCell : UITableViewCell

@property (nonatomic, strong) YYPickIntroModel *model;

+ (instancetype)pickIntroThreeCellWithTableView:(UITableView *)tableView;
@end
