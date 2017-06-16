
//
//  YYFruitNewsTableViewController.m
//  lcjfarm
//
//  Created by wyy on 16/7/13.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import "YYFruitNewsTableViewController.h"
#import "YYFruitNewsTableViewViewModel.h"
#import "YYFruitNewsTableViewDataSource.h"
#import "YYFruitNewsTableViewDelegate.h"

#import "YYFruitNewsModel.h"
#import "YYFruitNewsWebViewController.h"



@interface YYFruitNewsTableViewController ()
@property (nonatomic, strong) YYFruitNewsTableViewDataSource *tableViewDataSource;

@property (nonatomic, strong) YYFruitNewsTableViewDelegate *tableViewDelegate;

@property (nonatomic, strong) YYFruitNewsTableViewViewModel *viewModel;

@property (nonatomic, assign) int index;

@property (nonatomic, strong) NSMutableArray *modelsArray;
@end

@implementation YYFruitNewsTableViewController
- (NSMutableArray *)modelsArray{
    if (!_modelsArray) {
        _modelsArray = [NSMutableArray array];
    }
    return _modelsArray;
}
- (YYFruitNewsTableViewViewModel *)viewModel{
    if (!_viewModel) {
        _viewModel = [[YYFruitNewsTableViewViewModel alloc] init];
    }
    return _viewModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.index = 0;
    //设置tableView的数据源方法和代理方法
    [self setTableViewDataSourceAndDelegate];
    
    //设置上拉下拉刷新
    [self setHeaderAndFooterRefresh];
    
    //添加通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fruitNewsDidSlectWithNoti:) name:kNotificationFruitNewCellClick object:self.tableViewDelegate];
    
}
#pragma mark 设置tableView的数据源方法和代理方法
//设置tableView的数据源方法和代理方法
- (void)setTableViewDataSourceAndDelegate{
    self.tableViewDataSource = [[YYFruitNewsTableViewDataSource alloc] init];
    self.tableView.dataSource = self.tableViewDataSource;
    self.tableViewDelegate = [[YYFruitNewsTableViewDelegate alloc] init];
    self.tableView.delegate = self.tableViewDelegate;
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;

}
#pragma mark 设置上拉下拉刷新
/**
 *  设置上拉下拉刷新
 */
- (void)setHeaderAndFooterRefresh{
    __weak __typeof(&*self)weakSelf = self;
    [self.tableView addHeaderRefresh:^{
        YYLog(@"刷新");
        NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
        weakSelf.index = 0;
        parameters[@"index"] = [NSString stringWithFormat:@"%d", weakSelf.index * 10];
        [weakSelf.viewModel headerRefreshRequestWithParameters:parameters Callback:^(NSMutableArray *modelsArray) {
            [weakSelf.modelsArray removeAllObjects];
            [weakSelf.modelsArray addObjectsFromArray:modelsArray];
            [weakSelf.tableView resetFooter];

            weakSelf.tableViewDataSource.modelsArray = modelsArray;
            weakSelf.tableViewDelegate.modelsArray = modelsArray;
            [weakSelf.tableView reloadData];
            [weakSelf.tableView endHeaderRefresh];
        }];
    }];
    [self.tableView beginHeaderRefresh];
    
    //设置上拉
    [self.tableView addFooterRefresh:^{
        
        NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
        weakSelf.index++;
        parameters[@"index"] = [NSString stringWithFormat:@"%d", weakSelf.index * 10];
        
        [weakSelf.viewModel footerRefreshRequestWithParameters:parameters Callback:^(NSMutableArray *modelsArray) {
            if (modelsArray.count < 10) {
                [weakSelf.tableView setNoMoreData];
            }
            else{
                [weakSelf.modelsArray addObjectsFromArray:modelsArray];
                
                weakSelf.tableViewDataSource.modelsArray = weakSelf.modelsArray;
                weakSelf.tableViewDelegate.modelsArray = weakSelf.modelsArray;
                [weakSelf.tableView reloadData];
                [weakSelf.tableView endFooterRefresh];
            }
            
        }];
    }];
}
#pragma mark 单元格被点击
/**
 *  单元格被点击
 */
- (void)fruitNewsDidSlectWithNoti:(NSNotification *)noti{
    NSDictionary *userInfo = noti.userInfo;
    YYFruitNewsModel *model = userInfo[kFruitNewsCellModel];
    YYFruitNewsWebViewController *webController = [[YYFruitNewsWebViewController alloc] initWithModel:model];
    [self.navigationController pushViewController:webController animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
