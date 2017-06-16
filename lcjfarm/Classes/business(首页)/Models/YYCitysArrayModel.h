//
//  YYCitysArrayModel.h
//  lcjfarm
//
//  Created by wyy on 16/7/15.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import <Foundation/Foundation.h>


@class YYCityModel;
@interface YYCitysArrayModel : NSObject

@property (nonatomic, strong) NSMutableArray<YYCityModel *> *citysArray;

@property (nonatomic, copy) NSString *title;
/**
 *  显示的title,ABCD......
 */
@property (nonatomic, copy) NSString *showTitle;
@end
