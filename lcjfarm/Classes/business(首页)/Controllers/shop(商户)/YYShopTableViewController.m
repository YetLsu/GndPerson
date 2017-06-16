//
//  YYShopTableViewController.m
//  lcjfarm
//
//  Created by wyy on 16/6/28.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import "YYShopTableViewController.h"
#import "YYShopTableViewDataSource.h"
#import "YYShopTableViewDelegate.h"
#import "YYShopTableViewViewModel.h"

#import "YYFruitShopModel.h"

#import "YYShopDetailViewController.h"

#import "YYUserTool.h"

@interface YYShopTableViewController ()<YYShopTableViewDelegateDelegate>
@property (nonatomic, strong) YYShopTableViewViewModel *viewModel;
@property (nonatomic, strong) YYShopTableViewDelegate *tableViewDelegate;
@property (nonatomic, strong) YYShopTableViewDataSource *tableViewDatasource;

/**
 *  商店模型数组
 */
@property (nonatomic, strong) NSMutableArray *modelsArray;

@property (nonatomic, assign) int index;
@end

@implementation YYShopTableViewController
- (NSMutableArray *)modelsArray{
    if (!_modelsArray) {
        _modelsArray = [NSMutableArray array];
    }
    return _modelsArray;
}
- (YYShopTableViewViewModel *)viewModel{
    if (!_viewModel) {
        _viewModel = [[YYShopTableViewViewModel alloc] init];
    }
    return _viewModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = kViewBgGrayColor;
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    
    self.index = 0;
    //设置tableView的代理和数据源类
    [self setTableViewDataSourceAndProtocol];
    //设置导航栏的内容
    [self setNavView];
    
    //设置上拉下拉刷新
    [self setHeaderAndFooterRefresh];
}
#pragma mark 设置tableView的代理和数据源类
/**
 *  设置tableView的代理和数据源类
 */
- (void)setTableViewDataSourceAndProtocol{
    self.tableViewDelegate = [[YYShopTableViewDelegate alloc] init];
    self.tableView.delegate = _tableViewDelegate;
    self.tableViewDelegate.delegate = self;
    
    self.tableViewDatasource = [[YYShopTableViewDataSource alloc] init];
    self.tableView.dataSource = _tableViewDatasource;
}
#pragma mark 设置导航栏的内容
/**
 *  设置导航栏的内容
 */
- (void)setNavView{
    
    /**
     *  增加老陈家农场的图片
     */
    UIImageView *titleImageView = [[UIImageView alloc] init];
    titleImageView.image = [UIImage imageNamed:@"home_shop_title"];
    [titleImageView sizeToFit];
    self.navigationItem.titleView = titleImageView;
    
}
#pragma mark 设置上拉下拉刷新
/**
 *  设置上拉下拉刷新
 */
- (void)setHeaderAndFooterRefresh{
    __weak __typeof(&*self)weakSelf = self;
    //设置下拉
    [self.tableView addHeaderRefresh:^{
        
        YYUserModel *userModel = [YYUserTool userModel];
        
        weakSelf.index = 0;
        
        NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
        parameters[@"name"] = userModel.userCity;
        parameters[@"lon"] = userModel.lon;
        parameters[@"lat"] = userModel.lat;
        parameters[@"index"] = [NSString stringWithFormat:@"%d", weakSelf.index * 10];

       [weakSelf.viewModel headerRefreshRequestWithParameters:parameters Callback:^(NSMutableArray *modelsArray) {
          
           [weakSelf.modelsArray removeAllObjects];
           [weakSelf.modelsArray addObjectsFromArray:modelsArray];
           [weakSelf.tableView resetFooter];
           
           weakSelf.tableViewDatasource.modelsArray = weakSelf.modelsArray;
           weakSelf.tableViewDelegate.modelsArray = weakSelf.modelsArray;
           [weakSelf.tableView reloadData];
           [weakSelf.tableView endHeaderRefresh];

       }];
    }];
    [self.tableView beginHeaderRefresh];
    //设置上拉
    [self.tableView addFooterRefresh:^{
        YYUserModel *userModel = [YYUserTool userModel];
        
        NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
        parameters[@"name"] = userModel.userCity;
        parameters[@"lon"] = userModel.lon;
        parameters[@"lat"] = userModel.lat;
        weakSelf.index++;
        parameters[@"index"] = [NSString stringWithFormat:@"%d", weakSelf.index * 10];

        [weakSelf.viewModel footerRefreshRequestWithParameters:parameters Callback:^(NSMutableArray *modelsArray) {
            if (modelsArray.count < 10) {
                [weakSelf.tableView setNoMoreData];
            }
            else{
                [weakSelf.modelsArray addObjectsFromArray:modelsArray];

                weakSelf.tableViewDatasource.modelsArray = weakSelf.modelsArray;
                weakSelf.tableViewDelegate.modelsArray = weakSelf.modelsArray;
                [weakSelf.tableView reloadData];
                [weakSelf.tableView endFooterRefresh];
            }
            
        }];
    }];   
}
/**
 *  tableView的代理方法的代理
 */
- (void)tableViewDidSelectCellWithModel:(YYFruitShopModel *)model{
    YYShopDetailViewController *shopDetail = [[YYShopDetailViewController alloc] initWithModel:model];
    [self.navigationController pushViewController:shopDetail animated:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
