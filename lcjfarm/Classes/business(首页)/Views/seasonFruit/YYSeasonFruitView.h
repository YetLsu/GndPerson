//
//  YYSeasonFruitView.h
//  lcjfarm
//
//  Created by wyy on 16/7/11.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import <UIKit/UIKit.h>


@class YYSeasonFruitModel;
@interface YYSeasonFruitView : UIView


@property (nonatomic, strong) YYSeasonFruitModel *model;
/**
 *  创建应季水果的View
 */
+ (instancetype)seasonFruitView;
@end
