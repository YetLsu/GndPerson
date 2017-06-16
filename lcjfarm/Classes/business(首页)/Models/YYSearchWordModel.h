//
//  YYSearchWordModel.h
//  lcjfarm
//
//  Created by wyy on 16/8/16.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YYSearchWordModel : NSObject
/**
 *  关键词名称
 */
@property (nonatomic, copy) NSString *name;
/**
 *  热度
 */
@property (nonatomic, copy) NSString *hot_search;
/**
 *  图片宽度
 */
@property (nonatomic, assign) CGFloat imageW;
/**
 *  热度条图
 */
@property (nonatomic, strong) UIImage *hotImage;


@end
