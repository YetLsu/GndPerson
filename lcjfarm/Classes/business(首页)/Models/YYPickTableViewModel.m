//
//  YYPickTableViewModel.m
//  lcjfarm
//
//  Created by wyy on 16/6/29.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import "YYPickTableViewModel.h"

@implementation YYPickTableViewModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"farmid"]) {
        self.farmID = value;
    }
}
@end
