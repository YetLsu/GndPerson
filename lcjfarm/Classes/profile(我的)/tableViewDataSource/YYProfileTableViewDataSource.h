//
//  YYProfileTableViewDataSource.h
//  lcjfarm
//
//  Created by wyy on 16/7/13.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import <Foundation/Foundation.h>


@class YYPickTableViewModel, YYFruitShopModel;
@interface YYProfileTableViewDataSource : NSObject<UITableViewDataSource>
/**
 *  店铺模型数组
 */
@property (nonatomic, strong) NSMutableArray<YYFruitShopModel *> *shopModelsArray;
/**
 *  果园模型数组
 */
@property (nonatomic, strong) NSMutableArray<YYPickTableViewModel *> *pickModelsArray;
/**
 *  标识0：店铺
 *      1:采摘
 */
@property (nonatomic, assign) NSInteger tag;
@end
