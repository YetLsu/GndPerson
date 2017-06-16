//
//  YYShopDetailTableViewViewModel.h
//  lcjfarm
//
//  Created by wyy on 16/7/5.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import <Foundation/Foundation.h>


@class YYMarkModel, YYShopCommentModel, YYFruitShopModel;

typedef void(^callback)(NSMutableArray *modelsArray);
typedef void(^YYShopMessageBlock)(YYFruitShopModel *shopModel, NSMutableArray<YYMarkModel *> *marksArray, NSMutableArray<YYShopCommentModel *> *commentsArray, NSString *number, NSError *error);
@interface YYShopDetailTableViewViewModel : NSObject
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
 *  获取某家店铺的具体信息
 */
- (void)getShopMessageWithParameters:(NSMutableDictionary *)parameters callback:(YYShopMessageBlock)callback;
@end
