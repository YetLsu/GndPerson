//
//  YYHomeBtnModel.m
//  lcjfarm
//
//  Created by wyy on 16/6/27.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import "YYHomeBtnModel.h"

@implementation YYHomeBtnModel
- (instancetype)initWithIconUrlStr:(NSString *)iconUrlStr btnTitle:(NSString *)btnTitle btnDetailText:(NSString *)btnDetailText{
    if (self = [super init]) {
        self.iconUrlStr = iconUrlStr;
        self.btnTitle = btnTitle;
        self.btnDetailText = btnDetailText;
    }
    return self;
}
@end
