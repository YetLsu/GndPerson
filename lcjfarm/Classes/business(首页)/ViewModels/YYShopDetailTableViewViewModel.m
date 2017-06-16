//
//  YYShopDetailTableViewViewModel.m
//  lcjfarm
//
//  Created by wyy on 16/7/5.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import "YYShopDetailTableViewViewModel.h"
#import "YYFruitShopModel.h"
#import "YYMarkModel.h"
#import "YYShopCommentModel.h"

@implementation YYShopDetailTableViewViewModel
/**
 *  加载数据不通过下拉刷新
 */
- (void)loadDataWithParameters:(NSMutableDictionary *)parameters callBack:(callback)callback{
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
- (void)headerRefreshRequestWithParameters:(NSMutableDictionary *)parameters Callback:(callback)callback{
    
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
 *  获取某家店铺的具体信息
 */
- (void)getShopMessageWithParameters:(NSMutableDictionary *)parameters callback:(YYShopMessageBlock)callback{
    [NSObject GET:@"http://app.guonongda.com:8080/shop/showByID.do" parameters:parameters progress:^(NSProgress *downloadProgress) {
        
    } completionHandler:^(id responseObject, NSError *error) {
        if (error) {
            callback(nil, nil, nil, nil,error);
        }
        else{
            if ([responseObject isEqual:[NSNull null]]) {
                NSError *error = [[NSError alloc] init];
                callback(nil, nil, nil, nil,error);
            }
            else{
                NSDictionary *data1Dic = responseObject[@"data1"];
                YYFruitShopModel *shopModel = [[YYFruitShopModel alloc] init];
                [shopModel setValuesForKeysWithDictionary:data1Dic];
                
                
                NSArray *data2MarkArray = responseObject[@"data2"];
                NSMutableArray *marksArray = [NSMutableArray array];
                for (NSDictionary *dic in data2MarkArray) {
                    YYMarkModel *markModel = [[YYMarkModel alloc] init];
                    [markModel setValuesForKeysWithDictionary:dic];
                    
                    [marksArray addObject:markModel];
                }
                
                NSArray *data3CommentArray = responseObject[@"data3"];
                NSMutableArray *commentArray = [NSMutableArray array];
                for (NSDictionary *dic in data3CommentArray) {
                    YYShopCommentModel *model = [[YYShopCommentModel alloc] init];
                    [model setValuesForKeysWithDictionary:dic];
                    
                    NSString *metime = dic[@"metime"];
                    model.metime = [metime substringToIndex:10];
                    
                    NSDictionary *commentDic = dic[@"comment"];
                    
                    model.codetails = commentDic[@"codetails"];
                    
                    [commentArray addObject:model];
                }
                
                NSDictionary *data4 = responseObject[@"data4"];
                NSNumber *number = data4[@"number"];
                NSString *numberStr = [NSString stringWithFormat:@"%@", number];
                callback(shopModel, marksArray, commentArray, numberStr, nil);
//                YYLog(@"%@",responseObject);
            }
            
            
        }
    }];
}
@end
