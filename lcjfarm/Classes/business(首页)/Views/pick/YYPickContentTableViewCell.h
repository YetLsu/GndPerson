//
//  YYPickContentTableViewCell.h
//  lcjfarm
//
//  Created by wyy on 16/8/9.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YYPickContentTableViewCell : UITableViewCell

@property (nonatomic, copy) NSString *content;

+ (instancetype)pickContentTableViewCellWithTableView:(UITableView *)tableView;
@end
