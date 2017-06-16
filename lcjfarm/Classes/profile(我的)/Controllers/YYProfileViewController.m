//
//  YYProfileTableViewController.m
//  lcjfarm
//
//  Created by wyy on 16/6/20.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import "YYProfileViewController.h"

#import "YYLoginViewController.h"

#import "YYProfileTableViewDataSource.h"

#import "YYProfileViewModel.h"

#import "YYProfileHeaderView.h"

#import "YYUserTool.h"

#import "YYFruitShopModel.h"
#import "YYShopDetailViewController.h"
#import "YYPickTableViewModel.h"
#import "YYPickDetailTableViewController.h"

@interface YYProfileViewController ()<UITableViewDelegate>
/**
 *  tableView
 */
@property (nonatomic, weak) UITableView *tableView;
/**
 *  暂无收藏的View
 */
@property (nonatomic, weak) UIImageView *noCollectView;
/**
 *  底部的View
 */
@property (nonatomic, weak) UIView *bottomView;
@property (nonatomic, strong) YYProfileTableViewDataSource *tableViewDataSource;

@property (nonatomic, strong) YYProfileViewModel *viewModel;

/**
 *  tag值为0表示商店的单元格
 *  tag值为1表示农庄的单元格
 */
@property (nonatomic, assign) NSInteger tag;
/**
 *  头部的View
 */
@property (nonatomic, weak) YYProfileHeaderView *headerView;

@property (nonatomic, strong) NSMutableArray *shopModelsArray;

@property (nonatomic, strong) NSMutableArray *pickModelsArray;
@end

@implementation YYProfileViewController
- (YYProfileViewModel *)viewModel{
    if (!_viewModel) {
        _viewModel = [[YYProfileViewModel alloc] init];
    }
    return _viewModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //开启ios右滑返回
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    }
    
    self.shopModelsArray = [NSMutableArray array];
    self.pickModelsArray = [NSMutableArray array];
    
    self.tag = 0;
    //添加顶部的View和下面的TableView和底部的View
    [self addTableView];
    
    [self setHeaderAndFooterRefresh];
    
    //增加通知的监听
    [self addNotifications];
    
    //根据用户是否登录显示tableView或者未登录的View
    [self basedUserSetView];
    
}
#pragma mark 添加顶部的View和下面的TableView和底部的View
/**
 *  添加顶部的View和下面的TableView和底部的View
 */
- (void)addTableView{
    //添加顶部的View
    YYProfileHeaderView *headerView =[YYProfileHeaderView profileHeaderView];
    [self.view addSubview:headerView];
    self.headerView = headerView;
    CGFloat headerViewH = 210/667.0 * kHeightScreen + 40 + 12 + 24 + 12;
    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(self.view);
        make.height.mas_equalTo(headerViewH);
    }];
    //增加tableView
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStyleGrouped];
    [self.view addSubview:tableView];
    self.tableView = tableView;
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(headerView.mas_bottom);
    }];
    self.tableViewDataSource = [[YYProfileTableViewDataSource alloc] init];
    tableView.dataSource = self.tableViewDataSource;
    self.tableViewDataSource.tag = 0;
    
    tableView.delegate = self;
    tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    
    //暂无收藏的View
    UIImageView *noCollectionImageView = [[UIImageView alloc] init];
    [self.view addSubview:noCollectionImageView];
    self.noCollectView = noCollectionImageView;
    [self.noCollectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(headerView.mas_bottom);
    }];
    self.noCollectView.backgroundColor = [UIColor whiteColor];
    self.noCollectView.image = [UIImage imageNamed:@"profile_noCollection"];
    self.noCollectView.contentMode = UIViewContentModeCenter;
    //在暂无收藏的View上增加image View

    //底部的View
    UIView *bottomView = [[UIView alloc] init];
    [self.view addSubview:bottomView];
    self.bottomView = bottomView;
    self.bottomView.backgroundColor = [UIColor whiteColor];
    
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.view);
        make.top.mas_equalTo(headerView.mas_bottom);
    }];
    //在底部的View增加未登录label
    UILabel *noLoginLabel = [[UILabel alloc] init];
    [self.bottomView addSubview:noLoginLabel];
    noLoginLabel.text = @"您还没有登录";
    noLoginLabel.textColor = kGrayTextColor;
    noLoginLabel.textAlignment = NSTextAlignmentCenter;
    noLoginLabel.font = [UIFont systemFontOfSize:15.0];
    CGFloat noLoginLabelTop = (kHeightScreen - headerViewH - 49.0)/2.0;
    [noLoginLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(noLoginLabelTop);
        make.height.mas_equalTo(15.0);
    }];

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
        
        NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
        parameters[@"userid"] = userModel.userID;
        parameters[@"lon"] = userModel.lon;
        parameters[@"lat"] = userModel.lat;
        parameters[@"name"] = userModel.userCity;
        
        if (self.tag == 0) {
            
            [weakSelf.viewModel headerRefreshRequestShopWithParameters:parameters callback:^(NSMutableArray *modelsArray) {
                
                [self.shopModelsArray removeAllObjects];
                self.shopModelsArray = modelsArray;
                weakSelf.tableViewDataSource.tag = 0;
                weakSelf.tableViewDataSource.shopModelsArray = modelsArray;
                
                [weakSelf.tableView reloadData];
                [weakSelf.tableView endHeaderRefresh];
            }];
        }
        else if (self.tag == 1){
            
            [weakSelf.viewModel headerRefreshRequestFarmWithParameters:parameters callback:^(NSMutableArray *modelsArray) {
                
                [self.pickModelsArray removeAllObjects];
                self.pickModelsArray = modelsArray;
                weakSelf.tableViewDataSource.tag = 1;
                weakSelf.tableViewDataSource.pickModelsArray = modelsArray;

                [weakSelf.tableView reloadData];
                [weakSelf.tableView endHeaderRefresh];
            }];
        }
    }];
    [self.tableView beginHeaderRefresh];
}
#pragma mark 增加通知的监听
/**
 *   增加通知的监听
 */
- (void)addNotifications{
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(loginBtnClick) name:kNotificationLoginBtnClick object:self.headerView];
    
    [center addObserver:self selector:@selector(collectShopClick) name:kNotificationFruitCollectBtnClick object:self.headerView];
    
    [center addObserver:self selector:@selector(collectPickClick) name:kNotificationPickCollectBtnClick object:self.headerView];
    
    [center addObserver:self selector:@selector(logoutBtnClick) name:kNotificationLogoutBtnClick object:self.headerView];
}
/**
 *  登录按钮被点击
 */
- (void)loginBtnClick{
    YYLoginViewController *login = [[YYLoginViewController alloc] init];
    [self.navigationController pushViewController:login animated:YES];
    
}
/**
 *  商店收藏按钮被点击
 */
- (void)collectShopClick{
    YYLog(@"商店收藏按钮被点击");
    self.tag = 0;
    [self.tableView beginHeaderRefresh];
    
}
/**
 *  采摘收藏按钮被点击
 */
- (void)collectPickClick{
    YYLog(@"采摘收藏按钮被点击");
    self.tag = 1;
    [self.tableView beginHeaderRefresh];
}
/**
 *  退出按钮被点击
 */
- (void)logoutBtnClick{
    self.headerView.logoutBtn.hidden = YES;
    self.bottomView.hidden = NO;
    self.tableView.hidden = YES;
    self.headerView.loginBtn.hidden = NO;
    self.headerView.nameLabel.hidden = YES;
    
    YYUserModel *userModel = [YYUserTool userModel];
    userModel.name = nil;
    userModel.userID = nil;
    [YYUserTool saveUserModel:userModel];
    
}
#pragma mark 根据用户是否登录显示tableView或者未登录的View
/**
 *  根据用户是否登录显示tableView或者未登录的View
 */
- (void)basedUserSetView{
    YYUserModel *userModel = [YYUserTool userModel];
    //用户已经登录
    if (userModel.userID) {
        self.bottomView.hidden = YES;
        self.tableView.hidden = NO;
        [self.tableView beginHeaderRefresh];
        self.headerView.loginBtn.hidden = YES;
        self.headerView.nameLabel.hidden = NO;
        self.headerView.logoutBtn.hidden = NO;
        YYUserModel *userModel = [YYUserTool userModel];
        self.headerView.nameLabel.text = userModel.name;
        
        self.noCollectView.hidden = YES;
    }
    else{
        self.bottomView.hidden = NO;
        self.tableView.hidden = YES;
        self.headerView.loginBtn.hidden = NO;
        self.headerView.nameLabel.hidden = YES;
        self.headerView.logoutBtn.hidden = YES;
        
        self.noCollectView.hidden = YES;
    }
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    [self basedUserSetView];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
    
}
#pragma mark tableView的代理方法
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.00001;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.00001;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 104;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.tag == 0) {
        YYFruitShopModel *model = self.shopModelsArray[indexPath.row];
        YYShopDetailViewController *shopController = [[YYShopDetailViewController alloc] initWithModel:model];
        [self.navigationController pushViewController:shopController animated:YES];
    }
    else if (self.tag == 1){
        YYPickTableViewModel *model = self.pickModelsArray[indexPath.row];
        YYPickDetailTableViewController *pickController = [[YYPickDetailTableViewController alloc] initWithModel:model];
        [self.navigationController pushViewController:pickController animated:YES];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}
@end
