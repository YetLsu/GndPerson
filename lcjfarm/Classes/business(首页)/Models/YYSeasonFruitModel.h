//
//  YYSeasonFruitModel.h
//  lcjfarm
//
//  Created by wyy on 16/7/9.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YYSeasonFruitModel : NSObject
/**
*  水果id
*/
@property (nonatomic, copy) NSString *fruitID;
/**
 *  上市时间
 */
@property (nonatomic, copy) NSString *time;
/**
 *  图标地址（首页图标）
 */
@property (nonatomic, copy) NSString *iconimgurl;
/**
 *  图片列表地址（内图多张图）
 */
@property (nonatomic, copy) NSString *imglisturl;
/**
 *  展示图地址(应季水果第一个页面的Image)
 */
@property (nonatomic, copy) NSString *imgurl;
/**
 *  应季指数
 */
@property (nonatomic, copy) NSString *exponent;
/**
 *  热门搜索
 */
@property (nonatomic, copy) NSString *hot_search;
/**
 *  属性
 */
@property (nonatomic, copy) NSString *attribute;
/**
 *  水果名称
 */
@property (nonatomic, copy) NSString *name;
/**
 *  存放方式
 */
@property (nonatomic, copy) NSString *storagemode;
/**
 *  存放时间
 */
@property (nonatomic, copy) NSString *storagetime;
/**
 *  访问数
 */
@property (nonatomic,  copy) NSString *visitingnum;
/**
 *  产品数量
 */
@property (nonatomic,  copy) NSString *productnum;
/**
 *  酸碱性
 */
@property (nonatomic, copy) NSString *acid_alk;
/**
 *  具体成分
 */
@property (nonatomic, copy) NSString *specific;
/**
 *  热量
 */
@property (nonatomic, copy) NSString *calorie;
/**
 *  功效
 */
@property (nonatomic, copy) NSString *function;
/**
 *  适合人群
 */
@property (nonatomic, copy) NSString *crowd;
/**
 *  如何挑选1
 */
@property (nonatomic, copy) NSString *picking1;
/**
 *  水果吃法图片
 */
@property (nonatomic, copy) NSString *picurl;
/**
 *  水果相克
 */
@property (nonatomic, copy) NSString *inter_restriction;
/**
 *  水果简介
 */
@property (nonatomic, copy) NSString *introduction;
/**
 *  营养成分
 */
@property (nonatomic, copy) NSString *nutrition;
/**
 *  如何挑选2
 */
@property (nonatomic, copy) NSString *picking2;
/**
 *  如何清洗
 */
@property (nonatomic, copy) NSString *washing;
/**
 *  吃法
 */
@property (nonatomic, copy) NSString *eatting;
/**
 *  新建时间datetime
 */
@property (nonatomic, copy) NSString *create_dt;
/**
 *  修改时间
 */
@property (nonatomic, copy) NSString *update_dt;
/**
 *  删除/禁用时间
 */
@property (nonatomic, copy) NSString *deleted_dt;

@end
