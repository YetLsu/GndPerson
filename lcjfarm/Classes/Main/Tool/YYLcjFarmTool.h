//
//  YYLcjFarmTool.h
//  lcjfarm
//
//  Created by wyy on 16/6/27.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YYLcjFarmTool : NSObject

/**
 *  在某个View上增加一条线
 */
+ (void)addLineViewWithFrame:(CGRect)frame andView:(UIView *)superView;
/**
 *  根据分数计算星级宽度
 */
+ (CGFloat)calculateWidthWithScore:(NSString *)score;
@end
