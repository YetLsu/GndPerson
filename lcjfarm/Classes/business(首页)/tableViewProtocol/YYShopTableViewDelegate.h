//
//  YYShopTableViewDelegate.h
//  lcjfarm
//
//  Created by wyy on 16/6/29.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import <Foundation/Foundation.h>


@class YYFruitShopModel;

@protocol YYShopTableViewDelegateDelegate <NSObject>
/**
 *  单元格被点击
 */
- (void)tableViewDidSelectCellWithModel:(YYFruitShopModel *)model;

@end

@interface YYShopTableViewDelegate : NSObject<UITableViewDelegate>

@property (nonatomic, weak) id<YYShopTableViewDelegateDelegate> delegate;

@property (nonatomic, strong) NSMutableArray<YYFruitShopModel *> *modelsArray;

@end
