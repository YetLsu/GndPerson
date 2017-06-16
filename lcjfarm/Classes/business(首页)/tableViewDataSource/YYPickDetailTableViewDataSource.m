//
//  YYPickDetailTableViewDataSource.m
//  lcjfarm
//
//  Created by wyy on 16/7/5.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import "YYPickDetailTableViewDataSource.h"
#import "YYPickTableViewModel.h"
#import "YYPickIntroTableViewCell.h"

#import "YYPickIntroThreeCell.h"
#import "YYPickIntroModel.h"

#import "YYLikeShopTableViewCell.h"

#import "YYPickEightTableViewCell.h"

#import "YYPickEightCollectionViewCell.h"

#import "YYPickContentTableViewCell.h"

@interface YYPickDetailTableViewDataSource (){
    YYPickTableViewModel *_model;
    
    NSArray *_pickIntroArray;
}

@end

@implementation YYPickDetailTableViewDataSource
- (instancetype)initWithPickShopModel:(YYPickTableViewModel *)model andPickIntroModels:(NSArray<YYPickIntroModel *> *)pickIntroModels{
    if (self = [super init]) {
        _model = model;
        _pickIntroArray = pickIntroModels;
        
    }
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }
    else if (section == 1){
        return 1;
    }
    else if (section == 2){
        return 4;
    }
//    else if (section == 3){//果园简介
//        return 1;
//    }
    return self.modelsArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        YYPickIntroTableViewCell *cell = [YYPickIntroTableViewCell pickIntroTableViewCellWithTableView:tableView];
        
        cell.model = _model;
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return cell;
    }
    else if (indexPath.section == 1){
        YYPickEightTableViewCell *cell = [YYPickEightTableViewCell pickEightTableViewCellWithPickModel:_model];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        return cell;
    }
    else if (indexPath.section == 2){
        YYPickContentTableViewCell *cell = [YYPickContentTableViewCell pickContentTableViewCellWithTableView:tableView];
        if (indexPath.row == 0) {
            cell.content = [NSString stringWithFormat:@"性质：%@", _model.property];
        }
        else if (indexPath.row == 1){
            cell.content = [NSString stringWithFormat:@"娱乐设施：%@", _model.entertainment];
        }
        else if (indexPath.row == 2){
            cell.content = [NSString stringWithFormat:@"周边景点：%@", _model.surrounding];
        }
        else if (indexPath.row == 3){
            cell.content = [NSString stringWithFormat:@"采摘项目：%@", _model.projects];
        }
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return cell;
    }
//    else if (indexPath.section == 3){
//        YYPickIntroThreeCell *cell = [YYPickIntroThreeCell pickIntroThreeCellWithTableView:tableView];
//        YYPickIntroModel *model = _pickIntroArray[indexPath.row];
//        cell.model = model;
//        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
//        return cell;
//    }
    YYLikeShopTableViewCell *cell = [YYLikeShopTableViewCell likeShopTableViewCellWithTableView:tableView];
    
    YYFruitShopModel *model = self.modelsArray[indexPath.row];
    
    cell.shopModel = model;
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    return cell;
    
}
#pragma mark collectionView 
- (instancetype)initWithPickFarmWithPickModel:(YYPickTableViewModel *)model{
    if (self = [super init]) {
        _model = model;
    }
    return self;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 8;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellID = @"cellID";
    YYPickEightCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    NSString *imageName = nil;
    switch (indexPath.row) {
        case 0://停车场
            if ([_model.is_parking isEqualToString:@"1"]) {
                imageName = @"farm_icon_0_have";
            }
            else{
                imageName = @"farm_icon_0_no";
            }
            break;
        case 1://wifi
            if ([_model.is_wifi isEqualToString:@"1"]) {
                imageName = @"farm_icon_1_have";
            }
            else{
                imageName = @"farm_icon_1_no";
            }
            break;
        case 2://可采摘暂无
            if ([@"2" isEqualToString:@"1"]) {
                imageName = @"farm_icon_2_have";
            }
            else{
                imageName = @"farm_icon_2_no";
            }
            break;
        case 3://可应急医疗
            if ([_model.is_medical isEqualToString:@"1"]) {
                imageName = @"farm_icon_3_have";
            }
            else{
                imageName = @"farm_icon_3_no";
            }
            break;
        case 4://可团购
            if ([_model.is_groupon isEqualToString:@"1"]) {
                imageName = @"farm_icon_4_have";
            }
            else{
                imageName = @"farm_icon_4_no";
            }
            break;
        case 5://可钓鱼
            if ([_model.is_fishpond isEqualToString:@"1"]) {
                imageName = @"farm_icon_5_have";
            }
            else{
                imageName = @"farm_icon_5_no";
            }
            break;
        case 6://可住宿
            if ([_model.is_sleeping isEqualToString:@"1"]) {
                imageName = @"farm_icon_6_have";
            }
            else{
                imageName = @"farm_icon_6_no";
            }
            break;
        case 7://可野营暂无
            if ([@"2" isEqualToString:@"1"]) {
                imageName = @"farm_icon_7_have";
            }
            else{
                imageName = @"farm_icon_7_no";
            }
            break;
            
            
        default:
            break;
    }
    cell.iconImage = [UIImage imageNamed:imageName];
    return cell;
}

@end
