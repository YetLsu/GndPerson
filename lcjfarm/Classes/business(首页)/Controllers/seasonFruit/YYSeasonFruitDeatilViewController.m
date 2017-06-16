//
//  YYSeasonFruitDeatilTableViewController.m
//  lcjfarm
//
//  Created by wyy on 16/7/12.
//  Copyright © 2016年 WYY. All rights reserved.
//
#define kHeaderImageViewH (235/603.0*kNoNavHeight)
/**
 *  从userInfo中取出单元格的模型
 */
#define kShopCellModel @"kShopCellModel"

#import "YYSeasonFruitDeatilViewController.h"
#import "YYSeasonFruitModel.h"

#import "YYSeasonFruitDetailTableViewViewModel.h"
#import "YYSeasonFruitTableViewDetailDataSource.h"
#import "YYSeasonFruitDetailTableViewDelegate.h"

#import "YYUserTool.h"
#import "YYShopDetailViewController.h"

#import <SDCycleScrollView.h>

@interface YYSeasonFruitDeatilViewController ()<YYSeasonFruitDetailTableViewDelegateDelegate, SDCycleScrollViewDelegate>{
    YYSeasonFruitModel *_model;
}
/**
 * 导航栏的View
 */
@property (nonatomic, weak) UIView *navView;
/**
 *  导航栏上显示颜色的View
 */
@property (nonatomic, weak) UIView *navColorView;
/**
 *  tableView
 */
@property (nonatomic, weak) UITableView *tableView;
/**
 * tableView的headerImageView
 */
//@property (nonatomic, weak) UIImageView *headerImageView;

@property (nonatomic, strong) YYSeasonFruitTableViewDetailDataSource *tableViewDataSource;

@property (nonatomic, strong) YYSeasonFruitDetailTableViewDelegate *tableViewDelegate;

@property (nonatomic, strong) YYSeasonFruitDetailTableViewViewModel *viewModel;
@property (nonatomic, assign) int index;
/**
 *  商店模型数组
 */
@property (nonatomic, strong) NSMutableArray *modelsArray;
@end

@implementation YYSeasonFruitDeatilViewController
- (YYSeasonFruitDetailTableViewViewModel *)viewModel{
    if (!_viewModel) {
        _viewModel = [[YYSeasonFruitDetailTableViewViewModel alloc] init];
    }
    return _viewModel;
}
- (instancetype)initWithSeasonFruitModel:(YYSeasonFruitModel *)model{
    if (self = [super init]) {
        _model = model;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.index = 0;
    self.modelsArray = [NSMutableArray array];
    
    self.view.backgroundColor = [UIColor whiteColor];
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
    parameters[@"lon"] = [NSString stringWithFormat:@"%@",userModel.lon];
    parameters[@"lat"] = [NSString stringWithFormat:@"%@",userModel.lat];
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
        make.top.left.right.bottom.mas_equalTo(self.view);
    }];
    tableView.backgroundColor = kViewBgGrayColor;
    
    NSArray *seasonModelsArray = [self.viewModel createModelsArrayWithSeasonFruitModel:_model];
    
    self.tableViewDataSource = [[YYSeasonFruitTableViewDetailDataSource alloc] initWithSeasonFruitModel:_model andSeasonFruitintroModelsArray:seasonModelsArray];
    tableView.dataSource = self.tableViewDataSource;
    self.tableViewDelegate = [[YYSeasonFruitDetailTableViewDelegate alloc] initWithModel:_model andSeasonFruitintroModelsArray:seasonModelsArray];
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
    //增加标题
    CGFloat titleLabelH = 44;
    UILabel *titleLabel = [[UILabel alloc] init];
    [self.navView addSubview:titleLabel];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor whiteColor];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.navView.mas_left);
        make.right.mas_equalTo(self.navView.mas_right);
        make.bottom.mas_equalTo(self.navView.mas_bottom);
        make.height.mas_equalTo(titleLabelH);
    }];
    titleLabel.text = @"水果详情";
    titleLabel.font = [UIFont systemFontOfSize:20];
    //在导航栏上增加返回按钮
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
    topScrollView.delegate = self;
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
        parameters[@"lon"] = [NSString stringWithFormat:@"%@",userModel.lon];
        parameters[@"lat"] = [NSString stringWithFormat:@"%@",userModel.lat];
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
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    //单元格点击事件
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(farmCellClick:) name:kNotificationShopCellClick object:self.tableViewDelegate];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
