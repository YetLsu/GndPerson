//
//  YYSeasonFruitDetailDataSource.h
//  lcjfarm
//
//  Created by wyy on 16/7/12.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YYFruitShopModel, YYSeasonFruitModel, YYPickIntroModel;
@interface YYSeasonFruitTableViewDetailDataSource : NSObject<UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray<YYFruitShopModel *> *modelsArray;

- (instancetype)initWithSeasonFruitModel:(YYSeasonFruitModel *)model andSeasonFruitintroModelsArray:(NSArray <YYPickIntroModel *>*) modelsArray;
@end
