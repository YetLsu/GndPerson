//
//  YYPickTableViewViewModel.m
//  lcjfarm
//
//  Created by wyy on 16/6/29.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import "YYPickTableViewViewModel.h"
#import "YYPickTableViewModel.h"

@implementation YYPickTableViewViewModel
/**
 *  tableView头部刷新的网络请求
 */
- (void)headerRefreshRequestWithParameters:(NSMutableDictionary *)parameters Callback:(callback)callback{
   
    [NSObject GET:@"http://app.guonongda.com:8080/farm/showlist1.do" parameters:parameters progress:^(NSProgress *downloadProgress) {
        
    } completionHandler:^(NSDictionary *responseObject, NSError *error) {
        
//        YYLog(@"%@",responseObject);
        NSArray *dataArray = responseObject[@"data"];
         NSMutableArray *shopArray=[NSMutableArray array];
        for (NSDictionary *dic in dataArray) {
//            YYLog(@"%@",dic);
            YYPickTableViewModel *pickModel = [[YYPickTableViewModel alloc] init];
            [pickModel setValuesForKeysWithDictionary:dic];
            
            [shopArray addObject:pickModel];
        }
        callback(shopArray);
    }];
}

/**
 *  tableView底部刷新的网络请求
 */
- (void)footerRefreshRequestWithParameters:(NSMutableDictionary *)parameters Callback:(callback)callback{
    [NSObject GET:@"http://app.guonongda.com:8080/farm/showlist1.do" parameters:parameters progress:^(NSProgress *downloadProgress) {
        
    } completionHandler:^(NSDictionary *responseObject, NSError *error) {
        
//        YYLog(@"%@",responseObject);
        NSArray *dataArray = responseObject[@"data"];
        NSMutableArray *shopArray=[NSMutableArray array];
        for (NSDictionary *dic in dataArray) {
//            YYLog(@"%@",dic);
            YYPickTableViewModel *pickModel = [[YYPickTableViewModel alloc] init];
            [pickModel setValuesForKeysWithDictionary:dic];
            
            [shopArray addObject:pickModel];
        }
        callback(shopArray);
    }];

}
@end
