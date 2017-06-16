//
//  YYShopTableViewModel.m
//  lcjfarm
//
//  Created by wyy on 16/6/29.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import "YYShopTableViewViewModel.h"
#import "YYFruitShopModel.h"

#import "YYSeasonFruitModel.h"

@implementation YYShopTableViewViewModel
/**
 *  tableView头部刷新的网络请求
 */
- (void)headerRefreshRequestWithParameters:(NSMutableDictionary *)parameters Callback:(callback)callback{
    
    [NSObject GET:@"http://app.guonongda.com:8080/shop/showlist1.do" parameters:parameters progress:^(NSProgress *downloadProgress) {
        
    } completionHandler:^(id responseObject, NSError *error) {
        NSArray *dataArray = responseObject[@"data"];
    
        NSMutableArray *modelsArray = [NSMutableArray array];
        for (NSDictionary *dic in dataArray) {
//            YYLog(@"%@", dic);
            YYFruitShopModel *model = [[YYFruitShopModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            
            [modelsArray addObject:model];
            
        }
        callback(modelsArray);
    }];
}
/**
 *  tableView底部刷新的网络请求
 */
- (void)footerRefreshRequestWithParameters:(NSMutableDictionary *)parameters Callback:(callback)callback{
    [NSObject GET:@"http://app.guonongda.com:8080/shop/showlist1.do" parameters:parameters progress:^(NSProgress *downloadProgress) {
        
    } completionHandler:^(id responseObject, NSError *error) {
        NSArray *dataArray = responseObject[@"data"];
        NSMutableArray *modelsArray = [NSMutableArray array];
        for (NSDictionary *dic in dataArray) {
            YYFruitShopModel *model = [[YYFruitShopModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            
            [modelsArray addObject:model];
            
        }
        callback(modelsArray);
    }];
}
/**
 *  获取首页的8个图标
 */
- (void)getHomeEightFruitRequestWithParameters:(NSMutableDictionary *)parameters callback:(callback)callback{
    [NSObject GET:@"http://app.guonongda.com:8080/sf/getIcon.do" parameters:parameters progress:^(NSProgress *downloadProgress) {
        
    } completionHandler:^(NSDictionary *responseObject, NSError *error) {
        NSMutableArray *modelsArray = [NSMutableArray array];
        NSArray *fruitsArray = responseObject[@"data"];
        for (NSDictionary *dic in fruitsArray) {
            YYSeasonFruitModel *model = [[YYSeasonFruitModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [modelsArray addObject:model];
        }
        callback(modelsArray);
        
    }];
}

@end
