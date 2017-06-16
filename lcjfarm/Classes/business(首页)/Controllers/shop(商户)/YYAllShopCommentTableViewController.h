//
//  YYAllShopCommentTableViewController.h
//  lcjfarm
//
//  Created by wyy on 16/9/14.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YYShopCommentModel, YYFruitShopModel;
@interface YYAllShopCommentTableViewController : UITableViewController

- (instancetype)initWithCommentsArray:(NSMutableArray <YYShopCommentModel *>*) commentsArray andShopModel:(YYFruitShopModel *)model;
@end
