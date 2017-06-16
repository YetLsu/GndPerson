//
//  YYShopDetailMarkTableViewCell.h
//  lcjfarm
//
//  Created by wyy on 16/9/13.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YYShopDetailMarkTableViewCell : UITableViewCell
/**
 *  水果mark的模型数组
 */
@property (nonatomic, strong) NSArray *marksArray;

@property (nonatomic, copy) void (^YYSeeAllMarkBlock) ();


+ (instancetype)shopDetailMarkTableViewCellWithTableView:(UITableView *)tableView;
@end
