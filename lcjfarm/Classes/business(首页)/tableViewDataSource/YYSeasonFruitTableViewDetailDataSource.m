//
//  YYSeasonFruitDetailDataSource.m
//  lcjfarm
//
//  Created by wyy on 16/7/12.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import "YYSeasonFruitTableViewDetailDataSource.h"
#import "YYSeasonFruitModel.h"

#import "YYSeasonFruitNameTableViewCell.h"
#import "YYSeasonFruitMessageTableViewCell.h"

#import "YYPickIntroThreeCell.h"
#import "YYPickIntroModel.h"
//附近水果店的单元格
#import "YYLikeShopTableViewCell.h"
#import "YYFruitShopModel.h"

@interface YYSeasonFruitTableViewDetailDataSource (){
    YYSeasonFruitModel *_model;
}

@property (nonatomic, strong) NSArray <YYPickIntroModel *>*seasonFruitIntroModelsArray;
@end

@implementation YYSeasonFruitTableViewDetailDataSource

- (instancetype)initWithSeasonFruitModel:(YYSeasonFruitModel *)model andSeasonFruitintroModelsArray:(NSArray <YYPickIntroModel *>*) modelsArray{
    if (self = [super init]) {
        _model = model;
        self.seasonFruitIntroModelsArray = modelsArray;
    }
    return self;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 2) {
        return 3;
    }
    else if (section == 3){
        return self.modelsArray.count;
    }
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        YYSeasonFruitNameTableViewCell *cell = [YYSeasonFruitNameTableViewCell seasonFruitNameTableViewCellWithTableView:tableView];
        cell.model = _model;
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return cell;
    }
    if (indexPath.section == 1) {
    YYSeasonFruitMessageTableViewCell *cell = [YYSeasonFruitMessageTableViewCell seasonFruitMessageTableViewCellWithTableView:tableView];
    cell.model = _model;
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return cell;
    }
    if (indexPath.section == 2) {
        YYPickIntroThreeCell *cell = [YYPickIntroThreeCell pickIntroThreeCellWithTableView:tableView];
        cell.model = self.seasonFruitIntroModelsArray[indexPath.row];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return cell;
    }
    YYLikeShopTableViewCell *cell = [YYLikeShopTableViewCell likeShopTableViewCellWithTableView:tableView];
    YYFruitShopModel *model = self.modelsArray[indexPath.row];
    cell.shopModel = model;
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}


@end
