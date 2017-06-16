//
//  YYShopDetailTableViewDataSource.h
//  lcjfarm
//
//  Created by wyy on 16/7/1.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YYFruitShopModel, YYShopCommentModel;
@interface YYShopDetailTableViewDataSource : NSObject<UITableViewDataSource>

@property (nonatomic, copy) void (^YYSeeAllMarkBlock) ();

@property (nonatomic, strong) NSArray *marksArray;

@property (nonatomic, strong) NSMutableArray<YYFruitShopModel *> *modelsArray;

@property (nonatomic, strong) NSMutableArray <YYShopCommentModel *> *commentsArray;

- (instancetype)initWithFruitShopModel:(YYFruitShopModel *)model;
@end
