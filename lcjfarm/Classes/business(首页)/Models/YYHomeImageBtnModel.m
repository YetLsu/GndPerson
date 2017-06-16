//
//  YYHomeImageBtnModel.m
//  lcjfarm
//
//  Created by wyy on 16/6/27.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import "YYHomeImageBtnModel.h"

@implementation YYHomeImageBtnModel
- (instancetype) initWithImageUrl:(NSString *)imageUrl{
    if (self = [super init]) {
        self.imageUrlStr = imageUrl;
    }
    return self;
}
@end
