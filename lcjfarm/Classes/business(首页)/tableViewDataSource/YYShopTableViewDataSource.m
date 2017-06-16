//
//  YYShopTableViewDataSource.m
//  lcjfarm
//
//  Created by wyy on 16/6/29.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import "YYShopTableViewDataSource.h"
#import "YYFruitShopTableViewCell.h"
#import "YYFruitShopModel.h"

@interface YYShopTableViewDataSource ()

@end

@implementation YYShopTableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.modelsArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YYFruitShopTableViewCell *cell = [YYFruitShopTableViewCell fruitShopTableViewCellWithTableView:tableView];
    YYFruitShopModel *model = self.modelsArray[indexPath.row];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    cell.model = model;
    
    return cell;
}
@end
