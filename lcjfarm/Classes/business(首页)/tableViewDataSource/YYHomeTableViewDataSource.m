//
//  YYHomeTableViewDataSource.m
//  lcjfarm
//
//  Created by wyy on 16/7/4.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import "YYHomeTableViewDataSource.h"
#import "YYFruitShopTableViewCell.h"
#import "YYFruitShopModel.h"

#import "YYHomeViewBtn.h"
#import "YYHomeBtnModel.h"

#import "YYHomeImageBtnTableViewCell.h"
#import "YYHomeImageBtnModel.h"

#import "YYHomeTopCollectionViewCell.h"
#import "YYSeasonFruitModel.h"

@interface YYHomeTableViewDataSource ()
/**
 *  四个按钮的模型数组
 */
@property (nonatomic, strong) NSArray<YYHomeBtnModel *> *btnsModelArray;
/**
 * 两个图片按钮的模型数组
 */
@property (nonatomic, strong) NSArray<YYHomeImageBtnModel *> *imagesBtnModelArray;
@end
@implementation YYHomeTableViewDataSource
/**
 *  四个按钮的模型数组的懒加载
 */
- (NSArray<YYHomeBtnModel *> *)btnsModelArray{
    if (!_btnsModelArray) {
        
        YYHomeBtnModel *model1 = [[YYHomeBtnModel alloc] initWithIconUrlStr:@"home_shop_1" btnTitle:@"商户" btnDetailText:@"附近的水果店"];
        YYHomeBtnModel *model2 = [[YYHomeBtnModel alloc] initWithIconUrlStr:@"home_farm_2" btnTitle:@"农场" btnDetailText:@"附近的农场"];
//        YYHomeBtnModel *model3 = [[YYHomeBtnModel alloc] initWithIconUrlStr:@"home_fruit_3" btnTitle:@"应季水果" btnDetailText:@"看看当下吃什么"];
//        YYHomeBtnModel *model4 = [[YYHomeBtnModel alloc] initWithIconUrlStr:@"home_sign_4" btnTitle:@"签到" btnDetailText:@"每日签到有礼"];
        _btnsModelArray = @[model1, model2];
    }
    return _btnsModelArray;
    
}
/**
 * 两个图片按钮的模型数组
 */
- (NSArray<YYHomeImageBtnModel *> *)imagesBtnModelArray{
    if (!_imagesBtnModelArray) {
        YYHomeImageBtnModel *model1 = [[YYHomeImageBtnModel alloc] initWithImageUrl:@"home_imageBtn_1"];
//        YYHomeImageBtnModel *model2 = [[YYHomeImageBtnModel alloc] initWithImageUrl:@"home_imageBtn_2"];
        _imagesBtnModelArray = @[model1];
    }
    return _imagesBtnModelArray;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 2) {
        return self.modelsArray.count;
    }
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        UITableViewCell * cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        [self setFistTableViewCell:cell];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return cell;
    }
    else if (indexPath.section == 1){
        YYHomeImageBtnTableViewCell *cell = [YYHomeImageBtnTableViewCell homeImageBtnTableViewCellWithTableView:tableView];
        YYHomeImageBtnModel *model = [self.imagesBtnModelArray firstObject];
        cell.model = model;
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return cell;
    }
    YYFruitShopTableViewCell *cell = [YYFruitShopTableViewCell fruitShopTableViewCellWithTableView:tableView];
    YYFruitShopModel *model = self.modelsArray[indexPath.row];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    cell.model = model;
    return cell;
    
    //    return cell;
    
}
#pragma mark 设置第一个单元格
- (void)setFistTableViewCell:(UITableViewCell *)cell{
    cell.contentView.backgroundColor = kViewBgGrayColor;
    CGFloat yMargin = 5;
    CGFloat xMargin = 5;
    CGFloat btnW = (kWidthScreen - k12WidthMargin * 2 - yMargin)/2.0;
    CGFloat btnH = 70 /603.0 * kNoNavHeight;
    for (int i =0; i < 2; i++) {
        CGFloat btnX = (i%2)*(btnW + yMargin) + k12WidthMargin;
        CGFloat btnY = (i/2)*(btnH +xMargin);
        
        YYHomeViewBtn *btn = [[[NSBundle mainBundle] loadNibNamed:@"YYHomeViewBtn" owner:nil options:nil]lastObject];
        [cell.contentView addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(btnX);
            make.top.mas_equalTo(btnY);
            make.width.mas_equalTo(btnW);
            make.height.mas_equalTo(btnH);
        }];
        YYHomeBtnModel *model = self.btnsModelArray[i];
        btn.model = model;
//        [_btnsArray addObject:btn];
        btn.tag = i;
        
        [btn bk_addEventHandler:^(UIButton *sender) {
            NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
            userInfo[kHomeBtn] = sender;
            [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationHomeBtnsClick object:self userInfo:userInfo];
        } forControlEvents:UIControlEventTouchUpInside];
    }
}

#pragma mark collectionView datasource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.fruitModelsArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    YYHomeTopCollectionViewCell *cell = [YYHomeTopCollectionViewCell homeTopCollectionViewCellWithCollectionView:collectionView andIndexPath:indexPath];
    YYSeasonFruitModel *model = self.fruitModelsArray[indexPath.item];
    
    cell.model = model;
    return cell;
}


@end
