//
//  YYPickTableViewDataSource.m
//  lcjfarm
//
//  Created by wyy on 16/6/29.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import "YYPickTableViewDataSource.h"
#import "YYPickTableViewCell.h"
#import "YYPickTableViewModel.h"

@implementation YYPickTableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.modelsArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YYPickTableViewCell *cell = [YYPickTableViewCell pickTableViewCellWithTableView:tableView];
    YYPickTableViewModel *model = self.modelsArray[indexPath.row];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    cell.model = model;
    return cell;
}
@end
