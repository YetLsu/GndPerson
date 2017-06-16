//
//  YYProfileTableViewDataSource.m
//  lcjfarm
//
//  Created by wyy on 16/7/13.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import "YYProfileTableViewDataSource.h"

#import "YYCollectTableViewCell.h"
#import "YYFruitShopModel.h"
#import "YYPickTableViewModel.h"

@implementation YYProfileTableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.tag == 0) {//店铺
        return self.shopModelsArray.count;
    }
    else if (self.tag == 1){//采摘
        return self.pickModelsArray.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YYCollectTableViewCell *cell = [YYCollectTableViewCell tableViewCellWithTableView:tableView];
    if (self.tag == 0) {
        YYFruitShopModel *shopModel = self.shopModelsArray[indexPath.row];
        cell.shopModel = shopModel;
    }
    else if (self.tag == 1){
        YYPickTableViewModel *pickModel = self.pickModelsArray[indexPath.row];
        cell.pickModel = pickModel;
    }
    return cell;
}
@end
