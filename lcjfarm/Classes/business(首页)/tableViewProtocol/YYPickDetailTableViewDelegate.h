//
//  YYPickDetailTableViewDelegate.h
//  lcjfarm
//
//  Created by wyy on 16/7/5.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol YYPickDetailTableViewDelegateDelegate <NSObject>

- (void)tableViewScrollWithContentY:(CGFloat)contentY;

@end

@class YYPickTableViewModel, YYPickIntroModel, YYFruitShopModel;
@interface YYPickDetailTableViewDelegate : NSObject<UITableViewDelegate, UICollectionViewDelegate>

@property (nonatomic, strong) NSMutableArray<YYFruitShopModel *> *modelsArray;

@property (nonatomic, weak)id<YYPickDetailTableViewDelegateDelegate> delegate;

- (instancetype)initWithPickModel:(YYPickTableViewModel *)model;

@end
