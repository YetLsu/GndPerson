//
//  YYPickTableViewDataSource.h
//  lcjfarm
//
//  Created by wyy on 16/6/29.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YYPickTableViewModel;
@interface YYPickTableViewDataSource : NSObject<UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray<YYPickTableViewModel *> *modelsArray;

@end
