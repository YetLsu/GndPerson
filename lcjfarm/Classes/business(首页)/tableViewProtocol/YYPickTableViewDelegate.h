//
//  YYPickTableViewDelegate.h
//  lcjfarm
//
//  Created by wyy on 16/7/5.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kPickCellModel @"kPickCellModel"

@class YYPickTableViewModel;
@interface YYPickTableViewDelegate : NSObject<UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray<YYPickTableViewModel *> *modelsArray;

@end
