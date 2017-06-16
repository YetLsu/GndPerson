//
//  YYFruitNewsModel.m
//  lcjfarm
//
//  Created by wyy on 16/7/13.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import "YYFruitNewsModel.h"

@implementation YYFruitNewsModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        self.fruitNewsID = value;
    }
}
@end
