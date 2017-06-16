//
//  YYDiscoverDataSource.m
//  lcjfarm
//
//  Created by wyy on 16/8/10.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import "YYDiscoverDataSource.h"
#import "YYDiscoverTableViewCellModel.h"
#import "YYDiscoverTableViewCell.h"

@interface YYDiscoverDataSource ()

@property (nonatomic, strong) NSArray *modelsArray;

@end

@implementation YYDiscoverDataSource
- (NSArray *)modelsArray{
    if (!_modelsArray) {
        YYDiscoverTableViewCellModel *model0 = [[YYDiscoverTableViewCellModel alloc] initWithIconImage:[UIImage imageNamed:@"discover_seasonFruit"] title:@"应季水果" detailTitle:@"看看当下吃什么"];
        YYDiscoverTableViewCellModel *model1 = [[YYDiscoverTableViewCellModel alloc] initWithIconImage:[UIImage imageNamed:@"discover_fruitNews"] title:@"水果知识" detailTitle:@"快来Get一些新知识吧"];
        YYDiscoverTableViewCellModel *model2 = [[YYDiscoverTableViewCellModel alloc] initWithIconImage:[UIImage imageNamed:@"discover_activity"] title:@"活动专题" detailTitle:@"看看有什么好玩的"];
        
        _modelsArray = @[model0, model1, model2];
    }
    return _modelsArray;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YYDiscoverTableViewCell *cell = [YYDiscoverTableViewCell discoverTableViewCellWithTableView:tableView];
  
    YYDiscoverTableViewCellModel *model = self.modelsArray[indexPath.row];
    
    cell.model = model;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}
@end
