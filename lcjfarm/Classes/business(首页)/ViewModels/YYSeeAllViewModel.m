//
//  YYSeeAlViewModel.m
//  lcjfarm
//
//  Created by wyy on 16/9/14.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import "YYSeeAllViewModel.h"

#import "YYShopCommentModel.h"


@implementation YYSeeAllViewModel
/**
 *  获取平路数据
 *  NSString *errorStr  0:正确，－1没更多数据， 1错误
 */
- (void)getCommentsWithParameters:(NSMutableDictionary *)parameters withCallBack:(callback)callback{
    [NSObject GET:@"http://app.guonongda.com:8080/me/query.do" parameters:parameters progress:^(NSProgress *downloadProgress) {
        
    } completionHandler:^(id responseObject, NSError *error) {
        NSString *errorStr = nil;
        if (error) {
            errorStr = @"1";
            callback(nil, errorStr);
        }
        else{
            NSDictionary *data = responseObject[@"data"];
            if ([data isEqual:[NSNull null]]) {
                errorStr = @"1";
                callback(nil, errorStr);
            }
            else{
                NSMutableArray *commentArray = [NSMutableArray array];
                for (NSDictionary *dic in data) {
                    YYShopCommentModel *model = [[YYShopCommentModel alloc] init];
                    [model setValuesForKeysWithDictionary:dic];
                    
                    NSString *metime = dic[@"metime"];
                    model.metime = [metime substringToIndex:10];
                    
                    NSDictionary *commentDic = dic[@"comment"];
                    
                    model.codetails = commentDic[@"codetails"];
                    
                    [commentArray addObject:model];
                }
                errorStr = @"0";
                callback(commentArray, errorStr);
            }
        }
    }];

}


@end
