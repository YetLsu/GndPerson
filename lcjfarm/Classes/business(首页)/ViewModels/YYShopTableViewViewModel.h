//
//  YYShopTableViewModel.h
//  lcjfarm
//
//  Created by wyy on 16/6/29.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^callback)(NSMutableArray *modelsArray);
@interface YYShopTableViewViewModel : NSObject
/**
 *  tableView头部刷新的网络请求
 */
- (void)headerRefreshRequestWithParameters:(NSMutableDictionary *)parameters Callback:(callback)callback;
/**
 *  tableView底部刷新的网络请求
 */
- (void)footerRefreshRequestWithParameters:(NSMutableDictionary *)parameters Callback:(callback)callback;
/**
 *  获取首页的8个图标
 */
- (void)getHomeEightFruitRequestWithParameters:(NSMutableDictionary *)parameters callback:(callback)callback;
@end
