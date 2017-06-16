//
//  YYHomeTableViewViewModel.m
//  lcjfarm
//
//  Created by wyy on 16/7/4.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import "YYHomeTableViewViewModel.h"
#import "YYFruitShopModel.h"

#import "YYSeasonFruitModel.h"

@implementation YYHomeTableViewViewModel
/**
 *  tableView头部刷新的网络请求
 */
- (void)headerRefreshRequestWithParamaters:(NSMutableDictionary *)parameters Callback:(callback)callback{
    
   
    [NSObject GET:@"http://app.guonongda.com:8080/shop/showlist1.do" parameters:parameters progress:^(NSProgress *downloadProgress) {
        
    } completionHandler:^(NSDictionary *responseObject, NSError *error) {
//        YYLog(@"%@",responseObject);
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
 *  tableView底部刷新的网络请求
 */
- (void)footerRefreshRequestWithCallback:(callback)callback{
    
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
