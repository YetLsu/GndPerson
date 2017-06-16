//
//  YYFruitNewsTableViewDelegate.h
//  lcjfarm
//
//  Created by wyy on 16/7/13.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  从userInfo中取出单元格的模型
 */
#define kFruitNewsCellModel @"kFruitNewsCellModel"

@class YYFruitNewsModel;
@interface YYFruitNewsTableViewDelegate : NSObject<UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray<YYFruitNewsModel *> *modelsArray;

@end
