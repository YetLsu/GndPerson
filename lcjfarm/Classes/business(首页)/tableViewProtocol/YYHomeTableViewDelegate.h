//
//  YYHomeTableViewDelegate.h
//  lcjfarm
//
//  Created by wyy on 16/7/4.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  从userInfo中取出单元格的模型
 */
#define kShopCellModel @"kShopCellModel"
/**
 *  从userInfo中取出单元格的indexPath
 */
#define kImageCellIndexPath @"kImageCellIndexPath"

@class YYFruitShopModel;
@interface YYHomeTableViewDelegate : NSObject<UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray<YYFruitShopModel *> *modelsArray;

@end
