//
//  YYProfileViewModel.h
//  lcjfarm
//
//  Created by wyy on 16/7/13.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^callback)(NSMutableArray *modelsArray);
@interface YYProfileViewModel : NSObject
/**
 *  tableView店铺收藏头部刷新的网络请求
 */
- (void)headerRefreshRequestShopWithParameters:(NSMutableDictionary *)parameters callback:(callback)callback;
/**
 *  tableView店铺收藏底部刷新的网络请求
 */
- (void)footerRefreshRequestShopWithParameters:(NSMutableDictionary *)parameters callback:(callback)callback;
/**
 *  tableView果园收藏头部刷新的网络请求
 */
- (void)headerRefreshRequestFarmWithParameters:(NSMutableDictionary *)parameters callback:(callback)callback;
/**
 *  tableView果园收藏底部刷新的网络请求
 */
- (void)footerRefreshRequestFarmWithParameters:(NSMutableDictionary *)parameters callback:(callback)callback;
@end
