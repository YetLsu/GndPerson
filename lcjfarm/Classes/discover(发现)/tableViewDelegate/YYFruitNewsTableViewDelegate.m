//
//  YYFruitNewsTableViewDelegate.m
//  lcjfarm
//
//  Created by wyy on 16/7/13.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import "YYFruitNewsTableViewDelegate.h"

@implementation YYFruitNewsTableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 265;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.00001;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.00001;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    dictionary[kFruitNewsCellModel] = self.modelsArray[indexPath.section];
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationFruitNewCellClick object:self userInfo:dictionary];
}
@end
