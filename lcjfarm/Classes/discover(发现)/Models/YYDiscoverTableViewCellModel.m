//
//  YYDiscoverTableViewCellModel.m
//  lcjfarm
//
//  Created by wyy on 16/8/10.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import "YYDiscoverTableViewCellModel.h"

@implementation YYDiscoverTableViewCellModel
- (instancetype)initWithIconImage:(UIImage *)iconImage title:(NSString *)title detailTitle:(NSString *)detailTitle{
    if (self = [super init]) {
        self.iconImage = iconImage;
        self.title = title;
        self.detailTitle = detailTitle;
    }
    return self;
}
@end
