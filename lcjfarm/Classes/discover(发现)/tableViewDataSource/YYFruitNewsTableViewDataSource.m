//
//  YYFruitNewsTableViewDataSource.m
//  lcjfarm
//
//  Created by wyy on 16/7/13.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import "YYFruitNewsTableViewDataSource.h"
#import "YYFruitNewsTableViewCell.h"
#import "YYFruitNewsModel.h"


@implementation YYFruitNewsTableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.modelsArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YYFruitNewsTableViewCell *cell = [YYFruitNewsTableViewCell fruitNewsTableViewCellWithTableView:tableView];
    YYFruitNewsModel *model = self.modelsArray[indexPath.section];
    
    cell.model = model;
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    return cell;
}
@end
