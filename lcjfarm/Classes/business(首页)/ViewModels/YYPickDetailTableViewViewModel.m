//
//  YYPickDetailTableViewViewModel.m
//  lcjfarm
//
//  Created by wyy on 16/7/5.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import "YYPickDetailTableViewViewModel.h"
#import "YYPickTableViewModel.h"
#import "YYFruitShopModel.h"
#import "YYPickIntroModel.h"

@implementation YYPickDetailTableViewViewModel
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
 *  创建采摘农场介绍的数组
 */
//- (NSArray *)createModelsArrayWithPickModel:(YYPickTableViewModel *)model{
//    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
//    UIFont *labelFont = [UIFont systemFontOfSize:15];
//    attr[NSFontAttributeName] = labelFont;
//
//    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
//    paragraph.lineSpacing = 5;
//    attr[NSParagraphStyleAttributeName] = paragraph;
//
//    NSMutableAttributedString *introStr = [[NSMutableAttributedString alloc] initWithString:model.intro attributes:attr];
//    YYPickIntroModel *model0 = [[YYPickIntroModel alloc] initWithIcon:[UIImage imageNamed:@"home_pick_intro1"] andContent:introStr andTitle:@"果园简介"];
//    model0.contentH = [self calculateStrHWithStr:model.intro andDictionary:attr];
//    
//
//    NSMutableAttributedString *itemStr = [[NSMutableAttributedString alloc] initWithString:model.project attributes:attr];
//    YYPickIntroModel *model1 = [[YYPickIntroModel alloc] initWithIcon:[UIImage imageNamed:@"home_pick_intro2"] andContent:itemStr andTitle:@"采摘项目"];
//    model1.contentH = [self calculateStrHWithStr:model.project andDictionary:attr];
//
//    
//    NSMutableAttributedString *noticeStr = [[NSMutableAttributedString alloc] initWithString:model.attention attributes:attr];
//    YYPickIntroModel *model2 = [[YYPickIntroModel alloc] initWithIcon:[UIImage imageNamed:@"home_pick_intro3"] andContent:noticeStr andTitle:@"注意事项"];
//    model2.contentH = [self calculateStrHWithStr:model.attention andDictionary:attr];
//    
//    return @[model0, model1, model2];
//}
/**
 *  计算文字高度
 */
- (CGFloat)calculateStrHWithStr:(NSString *)str andDictionary:(NSMutableDictionary *)attr{
   
    CGFloat width = kWidthScreen - 12 * 2;
    return [str boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:attr context:nil].size.height;
}
@end
