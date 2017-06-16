//
//  YYPickDetailTableViewDataSource.h
//  lcjfarm
//
//  Created by wyy on 16/7/5.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import <Foundation/Foundation.h>


@class YYPickTableViewModel, YYPickIntroModel, YYFruitShopModel;
@interface YYPickDetailTableViewDataSource : NSObject<UITableViewDataSource, UICollectionViewDataSource>

@property (nonatomic, strong) NSMutableArray<YYFruitShopModel *> *modelsArray;

- (instancetype)initWithPickShopModel:(YYPickTableViewModel *)model andPickIntroModels:(NSArray<YYPickIntroModel *> *)pickIntroModels;
/**
 *  collectionView创建数据源方法
 */
- (instancetype)initWithPickFarmWithPickModel:(YYPickTableViewModel *)model;

@end
