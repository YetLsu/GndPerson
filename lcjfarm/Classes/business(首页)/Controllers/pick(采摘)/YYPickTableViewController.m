//
//  YYPickTableViewController.m
//  lcjfarm
//
//  Created by wyy on 16/6/29.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import "YYPickTableViewController.h"
#import <SDCycleScrollView.h>
#import "YYPickTableViewModel.h"
#import "YYPickDetailTableViewController.h"

#import "YYPickTableViewDelegate.h"
#import "YYPickTableViewDataSource.h"
#import "YYPickTableViewViewModel.h"

#import "YYUserTool.h"

@interface YYPickTableViewController ()<SDCycleScrollViewDelegate>{
    CGFloat _topScrollViewH;
}
@property (nonatomic, strong) YYPickTableViewDelegate *tableViewDelegate;
@property (nonatomic, strong) YYPickTableViewDataSource *tableViewDatasource;
@property (nonatomic, strong) YYPickTableViewViewModel *viewModel;

/**
 *  农场模型数组
 */
@property (nonatomic, strong) NSMutableArray *modelsArray;

@property (nonatomic, assign) int index;
/**
 *  tableView的headerView
 */
@property (nonatomic, weak) UIView *headerView;
@end

@implementation YYPickTableViewController
- (YYPickTableViewViewModel *)viewModel{
    if (!_viewModel) {
        _viewModel = [[YYPickTableViewViewModel alloc] init];
    }
    return _viewModel;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化数据
    [self installDatas];
    //设置headerView
    [self setTableViewHeaderView];
    
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    
    //设置导航栏的内容
    [self setNavView];
    //设置tableView的代理和数据源类
    [self setTableViewDataSourceAndProtocol];
    
    //添加通知
    [self addNotifications];
    
    //设置上拉下拉刷新
    [self setHeaderAndFooterRefresh];
    
}
/**
 *  初始化数据
 */
- (void)installDatas{
    
    self.index = 0;
    _topScrollViewH = 155.0/(667 - 64)*kNoNavHeight;
    
    self.modelsArray = [NSMutableArray array];
    
}

#pragma mark 添加通知
/**
 *  添加通知
 */
- (void)addNotifications{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pickCellClickWithNoti:) name:kNotificationPickCellClick object:self.tableViewDelegate];
}
#pragma mark cell被点击
- (void)pickCellClickWithNoti:(NSNotification *)noti{
    NSDictionary *userInfo = noti.userInfo;
    YYPickTableViewModel *model = userInfo[kPickCellModel];
    
    YYPickDetailTableViewController *pickDetail = [[YYPickDetailTableViewController alloc] initWithModel:model];
    [self.navigationController pushViewController:pickDetail animated:YES];
}
#pragma mark 设置headerView
/**
 *  设置headerView
 */
- (void)setTableViewHeaderView{
    NSArray *imagesArray = @[[UIImage imageNamed:@"home_scrollerView_1"], [UIImage imageNamed:@"home_scrollerView_2"], [UIImage imageNamed:@"home_scrollerView_3"]];
    
    // 本地加载图片的轮播器
    SDCycleScrollView *topScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, kWidthScreen, _topScrollViewH) shouldInfiniteLoop:YES imageNamesGroup:imagesArray];
    topScrollView.delegate = self;
    topScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
    [self.headerView addSubview:topScrollView];
    //轮播时间间隔，默认1.0秒，可自定义
    topScrollView.autoScrollTimeInterval = 2.0;
    self.tableView.tableHeaderView = topScrollView;
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
    titleImageView.image = [UIImage imageNamed:@"home_pick_title"];
    [titleImageView sizeToFit];
    self.navigationItem.titleView = titleImageView;
    
}
#pragma mark 设置tableView的代理和数据源类
/**
 *  设置tableView的代理和数据源类
 */
- (void)setTableViewDataSourceAndProtocol{
    self.tableViewDelegate = [[YYPickTableViewDelegate alloc] init];
    self.tableView.delegate = _tableViewDelegate;
    
    self.tableViewDatasource = [[YYPickTableViewDataSource alloc] init];
    self.tableView.dataSource = _tableViewDatasource;
}
#pragma mark 设置上拉下拉刷新
/**
 *  设置上拉下拉刷新
 */
- (void)setHeaderAndFooterRefresh{
    __weak __typeof(&*self)weakSelf = self;
    [self.tableView addHeaderRefresh:^{
        YYLog(@"刷新");
        YYUserModel *userModel = [YYUserTool userModel];
        weakSelf.index = 0;
        NSMutableDictionary *parameters = [NSMutableDictionary dictionary];

        parameters[@"name"] = userModel.userCity;        
        parameters[@"index"] = [NSString stringWithFormat:@"%d", weakSelf.index * 10];
        parameters[@"lon"] = [NSString stringWithFormat:@"%@", userModel.lon];
        parameters[@"lat"] = [NSString stringWithFormat:@"%@", userModel.lat];
//        YYLog(@"%@", parameters);
        [weakSelf.viewModel headerRefreshRequestWithParameters:parameters Callback:^(NSMutableArray *modelsArray) {
//            YYLog(@"%@", modelsArray);
            [weakSelf.modelsArray removeAllObjects];
            [weakSelf.modelsArray addObjectsFromArray:modelsArray];
            [weakSelf.tableView resetFooter];
            
            weakSelf.tableViewDatasource.modelsArray = modelsArray;
            weakSelf.tableViewDelegate.modelsArray = modelsArray;
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
#pragma mark 图片轮播器的代理方法
/**
 *  图片轮播器的代理方法
 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    YYLog(@"%ld页被点击", (long)index);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
