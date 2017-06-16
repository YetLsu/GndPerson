//
//  YYSeeAllMarksTableViewController.h
//  lcjfarm
//
//  Created by wyy on 16/9/14.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YYMarkModel;
@interface YYSeeAllMarksTableViewController : UITableViewController

- (instancetype)initWithMarksArray:(NSArray <YYMarkModel *>*)modelsArray;

@end
