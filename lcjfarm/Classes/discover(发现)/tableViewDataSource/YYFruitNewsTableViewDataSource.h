//
//  YYFruitNewsTableViewDataSource.h
//  lcjfarm
//
//  Created by wyy on 16/7/13.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import <Foundation/Foundation.h>


@class YYFruitNewsModel;
@interface YYFruitNewsTableViewDataSource : NSObject<UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray<YYFruitNewsModel *> *modelsArray;



@end
