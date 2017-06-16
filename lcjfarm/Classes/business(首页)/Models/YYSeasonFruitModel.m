//
//  YYSeasonFruitModel.m
//  lcjfarm
//
//  Created by wyy on 16/7/9.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import "YYSeasonFruitModel.h"

@implementation YYSeasonFruitModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        self.fruitID = value;
    }
}

@end
