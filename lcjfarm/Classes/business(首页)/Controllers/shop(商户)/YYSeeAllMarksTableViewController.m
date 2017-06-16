//
//  YYSeeAllMarksTableViewController.m
//  lcjfarm
//
//  Created by wyy on 16/9/14.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import "YYSeeAllMarksTableViewController.h"
#import "YYMarkTableViewCell.h"
#import "YYMarkModel.h"


@interface YYSeeAllMarksTableViewController ()
@property (nonatomic, strong) NSArray *marksArray;


@end

@implementation YYSeeAllMarksTableViewController
- (instancetype)initWithMarksArray:(NSArray <YYMarkModel *>*)modelsArray{
    if (self = [super initWithStyle:UITableViewStyleGrouped]) {
        self.title = @"店主推荐";
        self.marksArray = modelsArray;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - TableView数据源方法

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.marksArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YYMarkTableViewCell *cell = [YYMarkTableViewCell markTableViewCellWithTableView:tableView];
    
    YYMarkModel *model = self.marksArray[indexPath.row];
    
    cell.model = model;
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    return cell;
}

#pragma mark - TableView代理方法
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.00001;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.00001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 64;
}

@end
