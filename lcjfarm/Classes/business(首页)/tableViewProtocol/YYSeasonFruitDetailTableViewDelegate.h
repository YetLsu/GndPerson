//
//  YYSeasonFruitDetailTableViewDelegate.h
//  lcjfarm
//
//  Created by wyy on 16/7/12.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol YYSeasonFruitDetailTableViewDelegateDelegate <NSObject>

- (void)tableViewScrollWithContentY:(CGFloat)contentY;

@end

@class YYFruitShopModel, YYSeasonFruitModel, YYPickIntroModel;
@interface YYSeasonFruitDetailTableViewDelegate : NSObject<UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray<YYFruitShopModel *> *modelsArray;

@property (nonatomic, weak)id<YYSeasonFruitDetailTableViewDelegateDelegate> delegate;

- (instancetype)initWithModel:(YYSeasonFruitModel *)model andSeasonFruitintroModelsArray:(NSArray <YYPickIntroModel *>*) modelsArray;

@end
