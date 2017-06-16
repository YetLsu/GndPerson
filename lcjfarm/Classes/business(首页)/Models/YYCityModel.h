//
//  YYCityModel.h
//  lcjfarm
//
//  Created by wyy on 16/7/15.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YYCityModel : NSObject
/**
 *  城市名称
 */
@property (nonatomic, copy) NSString *name;
/**
 *  城市Code
 */
@property (nonatomic, copy) NSString *code;
/**
 *  citycode
 */
@property (nonatomic,copy) NSString *citycode;
/**
 *  城市拼音
 */
@property (nonatomic, copy) NSString *py_name;
/**
 *  热门城市
 */
@property (nonatomic, copy) NSString *hot_city;
/**
 *  城市中心lon
 */
@property (nonatomic, copy) NSString *center_lon;
/**
 *  城市中心lat
 */
@property (nonatomic,copy)NSString *center_lat;
@end
