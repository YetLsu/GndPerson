//
//  YYPickDetailTableViewViewModel.h
//  lcjfarm
//
//  Created by wyy on 16/7/5.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YYPickTableViewModel;

typedef void(^callback)(NSMutableArray *modelsArray);
@interface YYPickDetailTableViewViewModel : NSObject
/**
 *  加载数据不通过下拉刷新
 */
- (void)loadDataWithParameters:(NSMutableDictionary *)parameters callBack:(callback)callback;
/**
 *  tableView头部刷新的网络请求
 */
- (void)headerRefreshRequestWithParameters:(NSMutableDictionary *)parameters Callback:(callback)callback;
/**
 *  tableView底部刷新的网络请求
 */
- (void)footerRefreshRequestWithParameters:(NSMutableDictionary *)parameters Callback:(callback)callback;
/**
 *  创建采摘农场介绍的数组
 */
//- (NSArray *)createModelsArrayWithPickModel:(YYPickTableViewModel *)model;
@end
