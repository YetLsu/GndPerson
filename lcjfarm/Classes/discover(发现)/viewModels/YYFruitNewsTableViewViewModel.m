//
//  YYFruitNewsTableViewViewModel.m
//  lcjfarm
//
//  Created by wyy on 16/7/13.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import "YYFruitNewsTableViewViewModel.h"
#import "YYFruitNewsModel.h"

@implementation YYFruitNewsTableViewViewModel
/**
 *  tableView头部刷新的网络请求
 */
- (void)headerRefreshRequestWithParameters:(NSMutableDictionary *)parameters Callback:(callback)callback{
   
    
    [NSObject GET:@"http://app.guonongda.com:8080/news/showlist.do" parameters:parameters progress:^(NSProgress *downloadProgress) {
        
    } completionHandler:^(NSDictionary *responseObject, NSError *error) {
        NSArray *dataArray = responseObject[@"data"];
        NSMutableArray *modelsArray = [NSMutableArray array];
        
        for (NSDictionary *dic in dataArray) {
            YYFruitNewsModel *model = [[YYFruitNewsModel alloc] init];
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
    [NSObject GET:@"http://app.guonongda.com:8080/news/showlist.do" parameters:parameters progress:^(NSProgress *downloadProgress) {
        
    } completionHandler:^(NSDictionary *responseObject, NSError *error) {
        NSArray *dataArray = responseObject[@"data"];
        NSMutableArray *modelsArray = [NSMutableArray array];
        
        for (NSDictionary *dic in dataArray) {
            YYFruitNewsModel *model = [[YYFruitNewsModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            
            [modelsArray addObject:model];
            
        }
        
        callback(modelsArray);
    }];

}

@end
