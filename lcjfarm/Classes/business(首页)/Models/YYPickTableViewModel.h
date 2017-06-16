//
//  YYPickTableViewModel.h
//  lcjfarm
//
//  Created by wyy on 16/6/29.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YYPickTableViewModel : NSObject
/**
 *  农场ID
 */
@property (nonatomic, copy) NSString *farmID;
/**
*  农庄名称
*/
@property (nonatomic, copy) NSString *name;
/**
 *  收藏
 */
@property (nonatomic, copy) NSString *collection;
/**
 *  收藏数
 */
@property (nonatomic, copy) NSString *collectionnum;
/**
 *  展示图地址(外图)
 */
@property (nonatomic, copy) NSString *imgurl;
/**
 *  图片列表地址 (内图1,内图2..)
 */
@property (nonatomic, copy) NSString *imglisturl;
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
@property (nonatomic, copy) NSString *address;
/**
 *  城市code
 */
@property (nonatomic, copy) NSString *citycode;
/**
 *  联系方式
 */
@property (nonatomic, copy) NSString *phone;
/**
 *  开放时间
 */
@property (nonatomic, copy) NSString *time;
/**
 *  访问数
 */
@property (nonatomic, copy) NSString *visitingnum;
/**
 *  性质
 */
@property (nonatomic, copy) NSString *property;
/**
 *  采摘项目
 */
@property (nonatomic, copy) NSString *projects;
/**
 *  娱乐设施
 */
@property (nonatomic, copy) NSString *entertainment;
/**
 *  周围景点
 */
@property (nonatomic, copy) NSString *surrounding;
/**
 *  联系人
 */
@property (nonatomic, copy) NSString *person;
/**
 *  距离
 */
@property (nonatomic, copy) NSString *juli;
/**
 *  鱼塘(是否)
 */
@property (nonatomic, copy) NSString *is_fishpond;
/**
 *  停车场(是否)
 */
@property (nonatomic, copy) NSString *is_parking;
/**
 *  住宿(是否)
 */
@property (nonatomic, copy) NSString *is_sleeping;
/**
 *  wifi(是否)
 */
@property (nonatomic, copy) NSString *is_wifi;
/**
 *  应急医疗(是否)
 */
@property (nonatomic, copy) NSString *is_medical;
/**
 *  团购(是否)
 */
@property (nonatomic, copy) NSString *is_groupon;

@end
