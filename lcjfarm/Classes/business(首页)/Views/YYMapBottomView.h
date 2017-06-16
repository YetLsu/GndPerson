//
//  YYMapBottomView.h
//  lcjfarm
//
//  Created by wyy on 16/7/8.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YYFruitShopModel, YYPickTableViewModel;
@interface YYMapBottomView : UIView

@property (nonatomic, strong) YYFruitShopModel *shopModel;

@property (nonatomic, strong) YYPickTableViewModel *pickModel;
@end
