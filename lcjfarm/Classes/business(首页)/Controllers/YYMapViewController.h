//
//  YYMapViewController.h
//  lcjfarm
//
//  Created by wyy on 16/7/8.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import <UIKit/UIKit.h>


@class YYFruitShopModel, YYPickTableViewModel;
@interface YYMapViewController : UIViewController
/**
 *  店铺模型创建方法,tag1
 */
- (instancetype)initWithFruitShopModel:(YYFruitShopModel *)shopModel andTag:(NSInteger)tag;
/**
 *  采摘模型创建方法,tag2
 */
- (instancetype)initWithPickModel:(YYPickTableViewModel *)pickModel andTag:(NSInteger)tag;
@end
