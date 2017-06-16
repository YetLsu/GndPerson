//
//  YYFruitModel.h
//  lcjfarm
//
//  Created by wyy on 16/6/27.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YYFruitShopModel : NSObject
/**
 *  自增id
 */
@property (nonatomic, copy) NSString *shopid;
/**
 *  水果店名称
 */
@property (nonatomic, copy) NSString *name;
/**
 *  展示图地址(外图)
 */
@property(nonatomic, copy) NSString *imgurl;
/**
 *  图片列表地址(内图1,内图2..)
 */
@property (nonatomic, copy) NSString *imglisturl;
/**
 *  联系方式
 */
@property (nonatomic, copy) NSString *phone;
/**
 *  经度
 */
@property (nonatomic, copy) NSString *lon;
/**
 *  纬度
 */
@property (nonatomic, copy) NSString *lat;
/**
 *  偏差矫正
 */
@property (nonatomic, copy) NSString *param;
/**
 *  详细地址
 */
@property (nonatomic, copy) NSString *shopAddress;
/**
 *  城市code
 */
@property (nonatomic, copy) NSString *citycode;
/**
 *  地区id(V1.0暂不用)
 *
 */
@property (nonatomic, copy) NSString *districtid;
/**
 *  评分
 */
@property (nonatomic, copy) NSString *grade;
/**
 *  收藏数
 */
@property (nonatomic, copy) NSString *collectionnum;
/**
 *  访问数
 */
@property (nonatomic, copy) NSString *visitingnum;
/**
 *  营业时间
 */
@property (nonatomic, copy) NSString *time;
/**
 *  商铺距离
 */
@property (nonatomic, copy) NSString *juli;
/**
 *  所在城市
 */
@property (nonatomic, copy) NSString *cityname;
/**
 *  是否收藏
 */
@property (nonatomic, copy) NSString *collection;
@end
