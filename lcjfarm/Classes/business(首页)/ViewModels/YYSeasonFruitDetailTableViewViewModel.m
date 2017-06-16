//
//  YYSeasonFruitDetailTableViewViewModel.m
//  lcjfarm
//
//  Created by wyy on 16/7/12.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import "YYSeasonFruitDetailTableViewViewModel.h"
#import "YYFruitShopModel.h"
#import "YYSeasonFruitModel.h"
#import "YYPickIntroModel.h"

@implementation YYSeasonFruitDetailTableViewViewModel
/**
 *  加载数据不通过下拉刷新
 */
- (void)loadDataWithParameters:(NSMutableDictionary *)parameters callBack:(callback)callback{
    [NSObject GET:@"http://app.guonongda.com:8080/shop/showlist1.do" parameters:parameters progress:^(NSProgress *downloadProgress) {
        
    } completionHandler:^(NSDictionary *responseObject, NSError *error) {
        NSArray *dataArray = responseObject[@"data"];
//        YYLog(@"%@",dataArray);
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
- (NSArray *)createModelsArrayWithSeasonFruitModel:(YYSeasonFruitModel *)model{
    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
    UIFont *labelFont = [UIFont systemFontOfSize:15];
    attr[NSFontAttributeName] = labelFont;
    
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.lineSpacing = 5;
    attr[NSParagraphStyleAttributeName] = paragraph;
    
    NSMutableAttributedString *introStr = [[NSMutableAttributedString alloc] initWithString:model.introduction attributes:attr];
    YYPickIntroModel *model0 = [[YYPickIntroModel alloc] initWithIcon:[UIImage imageNamed:@"seasonFruit_intro"] andContent:introStr andTitle:@"水果介绍"]; 
    model0.contentH = [self calculateStrHWithStr:model.introduction andDictionary:attr];
    
    
    NSMutableAttributedString *itemStr = [[NSMutableAttributedString alloc] initWithString:model.function attributes:attr];
    YYPickIntroModel *model1 = [[YYPickIntroModel alloc] initWithIcon:[UIImage imageNamed:@"seasonFruit_effect"] andContent:itemStr andTitle:@"水果功效"];
    model1.contentH = [self calculateStrHWithStr:model.function andDictionary:attr];
    
    
    NSMutableAttributedString *noticeStr = [[NSMutableAttributedString alloc] initWithString:model.crowd attributes:attr];
    YYPickIntroModel *model2 = [[YYPickIntroModel alloc] initWithIcon:[UIImage imageNamed:@"seasonFruit_suitPeople"] andContent:noticeStr andTitle:@"适宜人群"];
    model2.contentH = [self calculateStrHWithStr:model.crowd andDictionary:attr] ;

    return @[model0, model1, model2];
}
/**
 *  计算文字高度
 */
- (CGFloat)calculateStrHWithStr:(NSString *)str andDictionary:(NSMutableDictionary *)attr{
    
    CGFloat width = kWidthScreen - 12 * 2;
    return [str boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:attr context:nil].size.height;
}

@end
