//
//  YYLcjFarmTool.m
//  lcjfarm
//
//  Created by wyy on 16/6/27.
//  Copyright © 2016年 WYY. All rights reserved.
//

#define starW 13.5
#define starMargin 5
#import "YYLcjFarmTool.h"


@implementation YYLcjFarmTool
/**
 *  在某个View上增加一条线
 */
#pragma mark 添加线条
+ (void)addLineViewWithFrame:(CGRect)frame andView:(UIView *)superView{
    UIView *view = [[UIView alloc] init];
    [superView addSubview:view];
    view.frame = frame;
    view.backgroundColor = kGrayLineColor;
}
#pragma mark 根据分数计算星级宽度
/**
 *  根据分数计算星级宽度
 */
+ (CGFloat)calculateWidthWithScore:(NSString *)score{
    CGFloat starNumber = score.floatValue;
    
    NSInteger marginNumber = (NSInteger)starNumber;
    CGFloat starHaveW = starW * starNumber + starMargin * marginNumber;
    
    return starHaveW;
}
@end
