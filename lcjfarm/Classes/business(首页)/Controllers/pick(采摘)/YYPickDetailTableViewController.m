//
//  YYPickDetailTableViewController.m
//  lcjfarm
//
//  Created by wyy on 16/7/5.
//  Copyright © 2016年 WYY. All rights reserved.
//
#define kHeaderImageViewH (235/603.0*kNoNavHeight)
/**
 *  从userInfo中取出单元格的模型
 */
#define kShopCellModel @"kShopCellModel"


#import "YYPickDetailTableViewController.h"
#import "YYPickTableViewModel.h"

#import "YYPickDetailTableViewViewModel.h"
#import "YYPickDetailTableViewDataSource.h"
#import "YYPickDetailTableViewDelegate.h"

#import "YYMapViewController.h"

#import "YYUserTool.h"

#import "YYFruitShopModel.h"
#import "YYShopDetailViewController.h"

#import <SDCycleScrollView.h>

@interface YYPickDetailTableViewController ()<YYPickDetailTableViewDelegateDelegate>
/**
 *  店铺信息
 */
@property (nonatomic, strong) YYPickTableViewModel *model;
/**
 * 导航栏的View
 */
@property (nonatomic, weak) UIView *navView;
/**
 *  导航栏上显示颜色的View
 */
@property (nonatomic, weak) UIView *navColorView;
/**
 * 收藏按钮
 */
@property (nonatomic, weak) UIButton *collectBtn;

@property (nonatomic, strong) YYPickDetailTableViewDataSource *tableViewDataSource;

@property (nonatomic, strong) YYPickDetailTableViewDelegate *tableViewDelegate;
/**
 *  tableView
 */
@property (nonatomic, weak) UITableView *tableView;
/**
 * tableView的headerImageView
 */
@property (nonatomic, weak) UIImageView *headerImageView;

@property (nonatomic, strong) YYPickDetailTableViewViewModel *viewModel;

@property (nonatomic, assign) int index;
/**
 *  商店模型数组
 */
@property (nonatomic, strong) NSMutableArray *modelsArray;
@end

@implementation YYPickDetailTableViewController
- (YYPickDetailTableViewViewModel *)viewModel{
    if (!_viewModel) {
        _viewModel = [[YYPickDetailTableViewViewModel alloc] init];
    }
    return _viewModel;
}

#pragma mark 创建控制器
/**
 *  创建控制器
 */
- (instancetype)initWithModel:(YYPickTableViewModel *)model{
    if (self = [super init]) {
        self.model = model;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = kViewBgGrayColor;
    //获取该农场是否收藏
    [self getFarmCollect];
    
    self.index = 0;
    self.modelsArray = [NSMutableArray array];
    
    //添加导航栏View和下面的TableView
    [self addNavViewAndTableView];
    
    //第一次加载数据
    [self loadDatas];
    
    //设置导航栏
    [self setNavView];
    
    //设置headerView
    [self setTableViewHeaderView];
    
    //设置上拉下拉刷新
    [self setHeaderAndFooterRefresh];
    
    //增加下面部分的我要去这里的Button
    [self addBottomBtn];
    
}
#pragma mark 获取该农场是否收藏
/**
 *  获取该农场是否收藏
 */
- (void)getFarmCollect{
    
    NSString *userID = nil;
    YYUserModel *userModel = [YYUserTool userModel];
    if (userModel.userID) {
        userID = userModel.userID;
    }
    else{
        self.model.collection = @"0";
        return;
    }
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"name"] = userModel.userCity;
    parameters[@"farmid"] = self.model.farmID;
    parameters[@"userid"] = userID;
    [NSObject GET:@"http://app.guonongda.com:8080/farm/show.do" parameters:parameters progress:^(NSProgress *downloadProgress) {
        
    } completionHandler:^(NSDictionary *responseObject, NSError *error) {
        if (error) {
            return;
        }
        NSDictionary *shopDic = responseObject[@"data"];
        NSString *collect = shopDic[@"collection"];
        YYLog(@"%@", collect);
        if ([collect isEqualToString:@"0"]) {
            self.model.collection = @"0";
            [self.collectBtn setImage:[UIImage imageNamed:@"home_pick_noCollect"] forState:UIControlStateNormal];
        }
        else if ([collect isEqualToString:@"1"]){
            self.model.collection = @"1";
            [self.collectBtn setImage:[UIImage imageNamed:@"home_pick_collect"] forState:UIControlStateNormal];
        }
    }];
}
#pragma mark 添加通知
/**
 *  添加通知
 */
- (void)addNotifications{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(farmPhoneClick) name:kNotificationPhoneFarmBtnClick object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(farmNavigationClick) name:kNotificationNavigationFarmBtnClick object:nil];
    
    //单元格点击事件
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(farmCellClick:) name:kNotificationShopCellClick object:self.tableViewDelegate];
}
#pragma mark 收到通知后调用的方法
/**
 *  收到通知后调用的方法
 */
- (void)farmPhoneClick{
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",self.model.phone];
    UIWebView * callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [self.view addSubview:callWebview];
}
- (void)farmNavigationClick{
    YYMapViewController *map = [[YYMapViewController alloc] initWithPickModel:self.model andTag:2];
    [self.navigationController pushViewController:map animated:YES];
}
/**
 *  猜你喜欢 店铺单元格被点击
 */
- (void)farmCellClick:(NSNotification *)noti{
    YYFruitShopModel *model = noti.userInfo[kShopCellModel];
    
    YYShopDetailViewController *shopDetail = [[YYShopDetailViewController alloc] initWithModel:model];
    [self.navigationController pushViewController:shopDetail animated:YES];
}

#pragma mark 第一次加载数据
/**
 *  第一次加载数据
 */
- (void)loadDatas{
    YYUserModel *userModel = [YYUserTool userModel];
    
    self.index = 0;
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"name"] = userModel.userCity;
    parameters[@"lon"] = userModel.lon;
    parameters[@"lat"] = userModel.lat;
    parameters[@"index"] = [NSString stringWithFormat:@"%d", self.index * 10];
    [self.viewModel loadDataWithParameters:parameters callBack:^(NSMutableArray *modelsArray) {
        [self.modelsArray removeAllObjects];
        [self.modelsArray addObjectsFromArray:modelsArray];
        [self.tableView resetFooter];
        
        self.tableViewDataSource.modelsArray = self.modelsArray;
        self.tableViewDelegate.modelsArray = self.modelsArray;
        [self.tableView reloadData];
    }];
}

#pragma mark 增加下面部分的我要去这里的Button
/**
 *  增加下面部分的我要去这里的Button
 */
- (void)addBottomBtn{
    UIButton *bottomBtn = [[UIButton alloc] init];
    [self.view addSubview:bottomBtn];
    [bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.view);
        make.height.mas_equalTo(44);
    }];
    bottomBtn.backgroundColor = kNavColor;
    bottomBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [bottomBtn setTitle:@"我要去这里" forState:UIControlStateNormal];
    [bottomBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [bottomBtn bk_addEventHandler:^(id sender) {
        YYMapViewController *map = [[YYMapViewController alloc] initWithPickModel:self.model andTag:2];
        [self.navigationController pushViewController:map animated:YES];
    } forControlEvents:UIControlEventTouchUpInside];
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
            
            weakSelf.tableViewDataSource.modelsArray = weakSelf.modelsArray;
            weakSelf.tableViewDelegate.modelsArray = weakSelf.modelsArray;
            [weakSelf.tableView reloadData];
            [weakSelf.tableView endHeaderRefresh];
            
        }];
    }];
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
                
                weakSelf.tableViewDataSource.modelsArray = weakSelf.modelsArray;
                weakSelf.tableViewDelegate.modelsArray = weakSelf.modelsArray;
                [weakSelf.tableView reloadData];
                [weakSelf.tableView endFooterRefresh];
            }
            
        }];
    }];
}

#pragma mark 添加导航栏View和下面的TableView
/**
 *  添加导航栏View和下面的TableView
 */
- (void)addNavViewAndTableView{
    
    //增加tableView
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStyleGrouped];
    [self.view addSubview:tableView];
    self.tableView = tableView;
    self.tableView.bounces = YES;
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view).mas_offset(-44);
    }];
    tableView.backgroundColor = kViewBgGrayColor;
//    NSArray *array = [self.viewModel createModelsArrayWithPickModel:self.model];
    self.tableViewDataSource = [[YYPickDetailTableViewDataSource alloc] initWithPickShopModel:self.model andPickIntroModels:nil];
    
    tableView.dataSource = self.tableViewDataSource;
    self.tableViewDelegate = [[YYPickDetailTableViewDelegate alloc] initWithPickModel:self.model];
    tableView.delegate = self.tableViewDelegate;
    self.tableViewDelegate.delegate = self;
    tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    //增加导航栏
    UIView *navBar = [[UIView alloc] init];
    [self.view addSubview:navBar];
    
    self.navView = navBar;
    [self.navView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(self.view);
        make.height.mas_equalTo(64);
    }];
    self.navView.backgroundColor = [UIColor clearColor];
    self.navView.alpha = 1;
    
}
#pragma mark 设置导航栏
/**
 *  设置导航栏
 */
- (void)setNavView{
    //在导航栏上增加显示颜色的View
    UIView *navColorView = [[UIView alloc] init];
    [self.navView addSubview:navColorView];
    
    self.navColorView = navColorView;
    [self.navColorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(self.navView);
    }];
    navColorView.backgroundColor = kNavColor;
    self.navColorView.alpha = 1;
    //在导航栏上增加返回按钮  和收藏按钮
    CGFloat backBtnW = 12 + k12WidthMargin * 2;
    CGFloat backBtnH = 44;
    UIButton *backBtn = [[UIButton alloc] init];
    [self.navView addSubview:backBtn];
    backBtn.imageView.image = [UIImage imageNamed:@"home_fruit_3"];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(backBtnW, backBtnH));
        make.left.mas_equalTo(self.navView);
        make.top.mas_equalTo(self.navView).mas_offset(20);
    }];
    [backBtn setImage:[UIImage imageNamed:@"previousBtn"] forState:UIControlStateNormal];
    [backBtn bk_addEventHandler:^(id sender) {
        [self.navigationController popViewControllerAnimated:YES];
    } forControlEvents:UIControlEventTouchUpInside];
    //在导航栏上增加收藏按钮
    UIButton *collectBtn = [[UIButton alloc] init];
    CGFloat collectBtnW = 25 + k12WidthMargin * 2;
    CGFloat collectBtnH = 44;
    [self.navView addSubview:collectBtn];
    self.collectBtn = collectBtn;
    [collectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.mas_equalTo(self.navView);
        make.size.mas_equalTo(CGSizeMake(collectBtnW, collectBtnH));
    }];
    
    [self.collectBtn setImage:[UIImage imageNamed:@"home_pick_noCollect"] forState:UIControlStateNormal];
    [self.collectBtn bk_addEventHandler:^(id sender) {
        YYUserModel *userModel = [YYUserTool userModel];
        
        if (!userModel.userID) {
            [MBProgressHUD showError:@"请先登录"];
            return;
        }
        NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
        parameters[@"userid"] = userModel.userID;
        parameters[@"farmid"] = self.model.farmID;
        parameters[@"name"] = userModel.userCity;
        
        if ([self.model.collection isEqualToString:@"1"]) {//取消收藏
            YYLog(@"取消收藏按钮被点击");
            [NSObject POST:@"http://app.guonongda.com:8080/coll/delfcoll.do" parameters:parameters progress:^(NSProgress *downloadProgress) {
                
            } completionHandler:^(id responseObject, NSError *error) {
                YYLog(@"responseObj:%@\n error:%@", responseObject, error);
                if (error) {
                    [MBProgressHUD showError:@"取消收藏农庄失败"];
                    return;
                }
                NSString *collect = responseObject[@"collection"];
                if ([collect isEqualToString:@"-2"]) {
                    [MBProgressHUD showError:@"还未收藏过该农庄"];
                    return;
                }
                else if ([collect isEqualToString:@"0"]){
                    [MBProgressHUD showSuccess:@"成功取消收藏该农庄"];
                    [self.collectBtn setImage:[UIImage imageNamed:@"home_pick_noCollect"] forState:UIControlStateNormal];
                    self.model.collection = @"0";
                }
            }];
            
        }
        else{//收藏
            YYLog(@"收藏按钮被点击");
            [NSObject POST:@"http://app.guonongda.com:8080/coll/addfcoll.do" parameters:parameters progress:^(NSProgress *downloadProgress) {
                
            } completionHandler:^(NSDictionary *responseObject, NSError *error) {
                if (error) {
                    [MBProgressHUD showError:@"收藏农庄失败"];
                    return;
                }
                NSString *collect = responseObject[@"collection"];
                if ([collect isEqualToString:@"-1"]) {
                    [MBProgressHUD showError:@"已收藏该农庄"];
                    return;
                }
                else if ([collect isEqualToString:@"1"]){
                    [MBProgressHUD showSuccess:@"成功收藏该农庄"];
                    [self.collectBtn setImage:[UIImage imageNamed:@"home_pick_collect"] forState:UIControlStateNormal];
                    self.model.collection = @"1";
                }
                YYLog(@"responseObj:%@\n error:%@", responseObject, error);
            }];
        }

    } forControlEvents:UIControlEventTouchUpInside];
    //增加标题
    UILabel *titleLabel = [[UILabel alloc] init];
    [self.navView addSubview:titleLabel];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor whiteColor];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(backBtn.mas_right);
        make.right.mas_equalTo(self.collectBtn.mas_left);
        make.bottom.mas_equalTo(self.navView.mas_bottom);
        make.height.mas_equalTo(collectBtnH);
    }];
    titleLabel.text = @"农庄详情";
    titleLabel.font = [UIFont systemFontOfSize:20];
    
}

/**
 *  设置headerView
 */
- (void)setTableViewHeaderView{
    UIView *headerView = [[UIView alloc] init];
    headerView.height = kHeaderImageViewH - 20;
    self.tableView.tableHeaderView = headerView;
    
    NSArray *imageStrsArray = [_model.imglisturl componentsSeparatedByString:@"|"];
    
    NSMutableArray *imagesUrlArray = [NSMutableArray array];
    for (NSString *str in imageStrsArray) {
        NSURL *imageUrl = [NSURL URLWithString:str];
        [imagesUrlArray addObject:imageUrl];
    }
    
    // 本地加载图片的轮播器
    SDCycleScrollView *topScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, -20, kWidthScreen, kHeaderImageViewH) imageURLStringsGroup:imagesUrlArray];
  
    topScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
    [headerView addSubview:topScrollView];
    topScrollView.autoScroll = NO;
    
    //    UIImageView *headerImageView = [[UIImageView alloc] init];
    //    [headerView addSubview:headerImageView];
    //    self.headerImageView = headerImageView;
    //    [headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.left.right.bottom.mas_equalTo(headerView);
    //        make.top.mas_equalTo(headerView).mas_offset(-20);
    //    }];
    //    [headerImageView sd_setImageWithURL:[NSURL URLWithString:_model.iconimgurl]];
    
    //    //给headerView增加按钮
    //    UIButton *headerBtn = [[UIButton alloc] init];
    //    [headerView addSubview:headerBtn];
    //    [headerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.left.right.bottom.top.mas_equalTo(headerImageView);
    //    }];
    //    //给headerView增加点击事件
    //    [headerBtn bk_addEventHandler:^(id sender) {
    //        YYLog(@"headerView被点击");
    //    } forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)tableViewScrollWithContentY:(CGFloat)contentY{
    contentY += 150;
    //    YYLog(@"%f\nheaderH:%f", contentY,kHeaderImageViewH);
    if (contentY < 0) {
        contentY = 0;
    }
    CGFloat alpha = contentY > kHeaderImageViewH ? 1 : (contentY/kHeaderImageViewH);
    //    YYLog(@"透明度：%f",alpha);
    self.navColorView.alpha = alpha;
    
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    //添加通知
    [self addNotifications];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
