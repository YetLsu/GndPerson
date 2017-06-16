//
//  YYHomeTableViewDataSource.h
//  lcjfarm
//
//  Created by wyy on 16/7/4.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kHomeBtn @"kHomeBtn"

@class YYFruitShopModel, YYSeasonFruitModel;
@interface YYHomeTableViewDataSource : NSObject<UITableViewDataSource, UICollectionViewDataSource>

@property (nonatomic, strong) NSMutableArray<YYSeasonFruitModel *>*fruitModelsArray;

@property (nonatomic, strong) NSMutableArray<YYFruitShopModel *> *modelsArray;

@end
