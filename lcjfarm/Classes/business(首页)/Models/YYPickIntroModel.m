//
//  YYPickIntroModel.m
//  lcjfarm
//
//  Created by wyy on 16/7/6.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import "YYPickIntroModel.h"

@implementation YYPickIntroModel
- (instancetype)initWithIcon:(UIImage *)icon andContent:(NSMutableAttributedString *)content andTitle:(NSString *)title{
    if (self = [super init]) {
        self.title = title;
        self.icon = icon;
        self.content = content;
    }
    return self;
}
@end
