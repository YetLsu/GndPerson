//
//  YYDiscoverTableViewCellModel.h
//  lcjfarm
//
//  Created by wyy on 16/8/10.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YYDiscoverTableViewCellModel : NSObject
/**
 *  左侧图标
 */
@property (nonatomic, strong) UIImage *iconImage;
/**
 *  标题
 */
@property (nonatomic, copy) NSString *title;
/**
 *  小标题
 */
@property (nonatomic, copy) NSString *detailTitle;

- (instancetype)initWithIconImage:(UIImage *)iconImage title:(NSString *)title detailTitle:(NSString *)detailTitle;
@end
