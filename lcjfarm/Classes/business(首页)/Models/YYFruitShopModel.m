//
//  YYFruitModel.m
//  lcjfarm
//
//  Created by wyy on 16/6/27.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import "YYFruitShopModel.h"

@implementation YYFruitShopModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"address"]){
        NSRange range1 = [value rangeOfString:@"绍兴市"];
        NSRange range2 = [value rangeOfString:@"绍兴县"];
        NSString *str;
        if (range1.length != 0) {
            str = [value substringFromIndex:range1.location + 3];
        }
        else if (range2.length != 0){
            str = [value substringFromIndex:range2.location + 3];
        }
        else{
            str = value;
        }
        self.shopAddress = str;
    }
}


@end
