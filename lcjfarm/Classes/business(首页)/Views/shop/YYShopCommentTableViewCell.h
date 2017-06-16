//
//  YYShopCommentTableViewCell.h
//  lcjfarm
//
//  Created by wyy on 16/9/13.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import <UIKit/UIKit.h>


@class YYShopCommentModel;
@interface YYShopCommentTableViewCell : UITableViewCell

@property (nonatomic, strong) YYShopCommentModel *model;

+ (instancetype)shopCommentTableViewCellWithtableView:(UITableView *)tableView;

@end
