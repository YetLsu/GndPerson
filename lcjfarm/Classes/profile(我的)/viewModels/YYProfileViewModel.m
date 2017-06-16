//
//  YYProfileViewModel.m
//  lcjfarm
//
//  Created by wyy on 16/7/13.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import "YYProfileViewModel.h"
#import "YYPickTableViewModel.h"
#import "YYFruitShopModel.h"


@implementation YYProfileViewModel
/**
 *  tableView店铺收藏头部刷新的网络请求
 */
- (void)headerRefreshRequestShopWithParameters:(NSMutableDictionary *)parameters callback:(callback)callback{
    [NSObject GET:@"http://app.guonongda.com:8080/user/shoplist.do" parameters:parameters progress:^(NSProgress *downloadProgress) {
        
    } completionHandler:^(id responseObject, NSError *error) {
        YYLog(@"%@", responseObject);
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
 *  tableView店铺收藏底部刷新的网络请求
 */
- (void)footerRefreshRequestShopWithParameters:(NSMutableDictionary *)parameters callback:(callback)callback{
    
}
/**
 *  tableView果园收藏头部刷新的网络请求
 */
- (void)headerRefreshRequestFarmWithParameters:(NSMutableDictionary *)parameters callback:(callback)callback{
    [NSObject GET:@"http://app.guonongda.com:8080/user/farmlist.do" parameters:parameters progress:^(NSProgress *downloadProgress) {
        
    } completionHandler:^(NSDictionary *responseObject, NSError *error) {
        
        YYLog(@"%@",responseObject);
        NSArray *dataArray = responseObject[@"data"];
        NSMutableArray *shopArray=[NSMutableArray array];
        for (NSDictionary *dic in dataArray) {
            YYLog(@"%@",dic);
            YYPickTableViewModel *pickModel = [[YYPickTableViewModel alloc] init];
            [pickModel setValuesForKeysWithDictionary:dic];
            
            [shopArray addObject:pickModel];
        }
        callback(shopArray);
    }];

}
/**
 *  tableView果园收藏底部刷新的网络请求
 */
- (void)footerRefreshRequestFarmWithParameters:(NSMutableDictionary *)parameters callback:(callback)callback;
{
    
    
}
@end
