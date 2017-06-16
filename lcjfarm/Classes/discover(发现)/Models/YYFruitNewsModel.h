//
//  YYFruitNewsModel.h
//  lcjfarm
//
//  Created by wyy on 16/7/13.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YYFruitNewsModel : NSObject
/**
 *  咨询ID
 */
@property (nonatomic, copy) NSString *fruitNewsID;
/**
 *  标题
 */
@property (nonatomic, copy) NSString *title;
/**
 *  简介
 */
@property (nonatomic, copy) NSString *introduction;
/**
 *  展示图地址
 */
@property (nonatomic, copy) NSString *showimgurl;
/**
 *  网页链接
 */
@property (nonatomic, copy) NSString *weburl;
/**
 *  时间
 */
@property (nonatomic, copy) NSString *create_d;
@end
