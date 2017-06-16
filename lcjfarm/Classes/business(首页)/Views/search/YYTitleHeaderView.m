//
//  YYTitleHeaderView.m
//  lcjfarm
//
//  Created by wyy on 16/8/17.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import "YYTitleHeaderView.h"

@interface YYTitleHeaderView ()

@end

@implementation YYTitleHeaderView
- (instancetype)init{
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
        //增加子控件
        [self addSubViews];
    }
    return self;
}
/**
 *  增加子控件
 */
- (void)addSubViews{
    //增加label
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(12, 0, kWidthScreen, 37.5)];
    label.textColor = kGrayTextColor;
    label.font = [UIFont systemFontOfSize:15.0];
    [self addSubview:label];
    self.titleLabel = label;
    
    //增加线
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 37.5, kWidthScreen, 0.5)];
    [self addSubview:lineView];
    lineView.backgroundColor = kGrayLineColor;
    self.lineView = lineView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
