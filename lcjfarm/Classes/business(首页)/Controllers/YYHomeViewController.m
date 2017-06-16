//
//  YYHomeViewController.m
//  lcjfarm
//
//  Created by wyy on 16/6/20.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import "YYHomeViewController.h"
#import <QuartzCore/QuartzCore.h>
#import <MapKit/MapKit.h>
#import "YYMapHomeViewModel.h"
#import "YYUserTool.h"
#import <SDCycleScrollView.h>

#import "YYHomeBtnModel.h"

#import "YYHomeImageBtnModel.h"

#import "YYFruitShopModel.h"

#import "YYShopTableViewController.h"
#import "YYPickTableViewController.h"
#import "YYShopDetailViewController.h"

#import "YYHomeTableViewDelegate.h"
//#import "YYHomeTableViewViewModel.h"
#import "YYShopTableViewViewModel.h"
#import "YYHomeTableViewDataSource.h"

#import "YYSeasonFruitViewController.h"
#import "YYCitysViewController.h"

#import "YYFruitStudyViewController.h"

#import "YYHomeTopCollectionViewCell.h"
#import "YYSeasonFruitModel.h"

#import "YYSeasonFruitDeatilViewController.h"
#import "WYYSearchBar.h"
#import "YYHomeSearchViewController.h"
#import "YYNavigationController.h"

@interface YYHomeViewController ()<SDCycleScrollViewDelegate,  UICollectionViewDelegate, UITextFieldDelegate>{
    CGFloat _topScrollViewH;
    CGFloat _topCollectionViewH;
    CGFloat _topItemH;
    CGFloat _topItemW;
    
    NSIndexPath *_lastIndexPath;
    
    
}
//@property (nonatomic, strong) YYHomeTableViewViewModel *viewModel;
@property (nonatomic, strong) YYShopTableViewViewModel *viewModel;
@property (nonatomic, strong) YYHomeTableViewDelegate *tableViewDelegate;
@property (nonatomic, strong) YYHomeTableViewDataSource *tableViewDatasource;
/**
 *  导航栏View
 */
@property (nonatomic, weak) UIView *navView;
/**
 *  首页的TableView
 */
@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, strong) YYMapHomeViewModel *mapViewModel;
/**
 *  地址的label
 */
@property (nonatomic, weak) UILabel *addressCityLabel;
/**
 *  tableView的headerView
 */
@property (nonatomic, weak) UIView *headerView;
/**
 *  没有签到的View
 */
@property (nonatomic, strong) UIView *noSignView;
/**
 *  顶部的collection View
 */
@property (nonatomic, weak) UICollectionView *fruitCollectionView;
/**
 *  modelsArray
 */
@property (nonatomic, strong) NSMutableArray *fruitArray;

/**
 *  第一个单元格变换时的参数
 */
@property (nonatomic, assign) CATransform3D firstInitialTransformation;

@property (nonatomic, assign) int index;
/**
 *  商店模型数组
 */
@property (nonatomic, strong) NSMutableArray *modelsArray;

@end

@implementation YYHomeViewController
- (NSMutableArray *)modelsArray{
    if (!_modelsArray) {
        _modelsArray = [NSMutableArray array];
    }
    return _modelsArray;
}
- (UIView *)noSignView{
    if (!_noSignView) {
        _noSignView = [[UIView alloc] init];
        
        CGFloat height = (kWidthScreen - 65)/310.0 * 291;
        CGFloat width = kWidthScreen - 32.5 * 2;
        CGFloat noSignViewY = (kHeightScreen - height)/2.0;
        _noSignView.frame = CGRectMake(32.5, noSignViewY, width, height);
        
        //添加背景图片
        UIImageView *bgImageView = [[UIImageView alloc] init];
        bgImageView.image = [UIImage imageNamed:@"home_noSignBgImgae"];
        [_noSignView addSubview:bgImageView];
        bgImageView.frame = _noSignView.bounds;
        
        //添加知道了按钮
        UIButton *knowBtn = [[UIButton alloc] init];
        [knowBtn setBackgroundImage:[UIImage imageNamed:@"home_noSignBtn_bg"] forState:UIControlStateNormal];
        [knowBtn setTitle:@"知道啦～" forState:UIControlStateNormal];
        [knowBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_noSignView addSubview:knowBtn];
        knowBtn.titleLabel.font = [UIFont systemFontOfSize:19.0];
        
        CGFloat noSignBtnX = (width - 150)/2.0;
        [knowBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(_noSignView.mas_bottom).mas_offset(-20);
            make.size.mas_equalTo(CGSizeMake(150, 40));
            make.left.mas_equalTo(noSignBtnX);
        }];

        [knowBtn bk_addEventHandler:^(id sender) {
            YYLog(@"知道了按钮被点击");
            [UIView animateWithDuration:0.5 animations:^{
                _noSignView.alpha = 0;
            }];
        } forControlEvents:UIControlEventTouchUpInside];
        
        //增加绿色Label
        UILabel *greenLabel = [[UILabel alloc] init];
        [_noSignView addSubview:greenLabel];
        greenLabel.text = @"敬请期待";
        greenLabel.textAlignment = NSTextAlignmentCenter;
        greenLabel.textColor = kNavColor;
        [greenLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(_noSignView);
            make.bottom.mas_equalTo(knowBtn.mas_top).mas_offset(-20);
            make.height.mas_equalTo(18);
        }];
        
        //增加灰色Label
        UILabel *grayLabel = [[UILabel alloc] init];
        [_noSignView addSubview:grayLabel];
        grayLabel.text = @"签到功能暂时没有开放～";
        grayLabel.textAlignment = NSTextAlignmentCenter;
        grayLabel.textColor = kGrayTextColor;
        [grayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(_noSignView);
            make.bottom.mas_equalTo(greenLabel.mas_top).mas_equalTo(-10);
            make.height.mas_equalTo(18);
        }];
    }
    
    return _noSignView;
}

- (YYMapHomeViewModel *)mapViewModel{
    if (!_mapViewModel) {
        _mapViewModel = [[YYMapHomeViewModel alloc] init];
    }
    return _mapViewModel;
}
- (YYShopTableViewViewModel *)viewModel{
    if (!_viewModel) {
        _viewModel = [[YYShopTableViewViewModel alloc] init];
    }
    return _viewModel;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //开启ios右滑返回
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    }
    //初始化数据
    [self installDatas];
    //添加导航栏View和下面的TableView
    [self addNavViewAndTableView];
    //设置tableView的代理和数据源类
    [self setTableViewDataSourceAndProtocol];
    //获取首页八个图标
    [self.viewModel getHomeEightFruitRequestWithParameters:nil callback:^(NSMutableArray *modelsArray) {
        self.tableViewDatasource.fruitModelsArray = modelsArray;
        self.fruitArray = modelsArray;
        [self.fruitCollectionView reloadData];
    }];
    
    //增加通知
    [self addNotifications];
    //设置导航栏的内容
    [self setNavView];
    //获取当前城市
    [self.mapViewModel getNowLocation];
    //设置tableView的headerView
    [self setTableViewContent];
    
    //设置上拉下拉刷新
    [self setHeaderAndFooterRefresh];
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
#pragma mark 设置tableView的代理和数据源类
/**
 *  设置tableView的代理和数据源类
 */
- (void)setTableViewDataSourceAndProtocol{
    self.tableView.delegate = self.tableViewDelegate;

    self.tableView.dataSource = self.tableViewDatasource;
}
/**
 *  初始化数据
 */
- (void)installDatas{
    
    self.index = 0;
    
    self.tableViewDelegate = [[YYHomeTableViewDelegate alloc] init];
    self.tableViewDatasource = [[YYHomeTableViewDataSource alloc] init];
    _topScrollViewH = 155.0/(667 - 64)*kNoNavHeight;
    
    _topItemH = 42.5 + 16 + 10;
    _topItemW = 42.5;
    _topCollectionViewH = k12HeightMargin * 4 + _topItemH * 2;
    
    CATransform3D transform = CATransform3DIdentity;
    transform = CATransform3DMakeScale(1.5, 1.5, 1);
    self.firstInitialTransformation = transform;
}
#pragma mark 增加通知
/**
 *  增加通知
 */
- (void)addNotifications{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getAddress:) name:kNotificationGetAddress object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(homeBtnsClickWithNoti:) name:kNotificationHomeBtnsClick object:self
     .tableViewDatasource];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tableViewShopCellClickWithNoti:) name:kNotificationShopCellClick object:self.tableViewDelegate];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tableViewImageCellClickWithNoti:) name:kNotificationImageCellClick object:self.tableViewDelegate];
}
#pragma mark 获取到地址之后调用的方法
- (void)getAddress:(NSNotification *)noti{
    NSDictionary *dic = noti.userInfo;
    NSString *address = dic[kAddressKey];
    YYLog(@"获取到地址之后%@", address);
    
    self.addressCityLabel.text = address;
    
    YYUserModel *userModel = [YYUserTool userModel];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"name"] = address;
    parameters[@"lon"] = userModel.lon;
    parameters[@"lat"] = userModel.lat;
    parameters[@"index"] = [NSString stringWithFormat:@"%d", self.index];
    
    [self getDatasFromInterWithParameters:parameters];
}
#pragma mark 获取数据
/**
 *  获取数据
 */
- (void)getDatasFromInterWithParameters:(NSMutableDictionary *)parameters{
    //获取附近商店
    [NSObject GET:@"http://app.guonongda.com:8080/shop/showlist1.do" parameters:parameters progress:^(NSProgress *downloadProgress) {
        
    } completionHandler:^(NSDictionary *responseObject, NSError *error) {
        NSArray *dataArray = responseObject[@"data"];
 
        NSMutableArray *modelsArray = [NSMutableArray array];
        for (NSDictionary *dic in dataArray) {
            YYFruitShopModel *model = [[YYFruitShopModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            
            [modelsArray addObject:model];
            
            self.tableViewDatasource.modelsArray = modelsArray;
            self.tableViewDelegate.modelsArray = modelsArray;
            [self.tableView reloadData];
        }
    }];

}
#pragma mark 添加导航栏View和下面的TableView
/**
 *  添加导航栏View和下面的TableView
 */
- (void)addNavViewAndTableView{
    //增加导航栏
    UIView *navBar = [[UIView alloc] init];
    [self.view addSubview:navBar];
   
    self.navView = navBar;
    [self.navView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(self.view);
        make.height.mas_equalTo(64);
    }];
    navBar.backgroundColor = kNavColor;
    
    
    //增加tableView
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStyleGrouped];
    [self.view addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.view);
        make.top.mas_equalTo(navBar.mas_bottom);
    }];
    tableView.backgroundColor = kViewBgGrayColor;
    self.tableView = tableView;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}
#pragma mark 设置导航栏的内容
/**
 *  设置导航栏的内容
 */
- (void)setNavView{
    WYYSearchBar *searchBar = [WYYSearchBar searchBarWithPlaceholderText:@"搜你喜欢的水果"];
    searchBar.delegate = self;
    [self.navView addSubview:searchBar];
    
    CGFloat searchBarWidth = 208 /375.0 * kWidthScreen;
    CGFloat searchBarTop = (64 - 27.5 - 20)/2.0 + 20;
    CGFloat searchBarLeft = (kWidthScreen - searchBarWidth)/2.0;
    [searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(searchBarWidth);
        make.height.mas_equalTo(27.5);
        make.left.mas_equalTo(searchBarLeft);
        make.top.mas_equalTo(searchBarTop);
        
    }];

    searchBar.height = 27.5;
    searchBar.width = 208 /375.0 * kWidthScreen;
    /**
     *  增加老陈家农场的图片
     */
//    UIImageView *titleImageView = [[UIImageView alloc] init];
//    [self.navView addSubview:titleImageView];
//    titleImageView.image = [UIImage imageNamed:@"home_lcjFarm_title"];
//    [titleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.width.mas_equalTo(113.5);
//        make.height.mas_equalTo(21.5);
//        make.centerX.mas_equalTo(self.navView.centerX);
//        make.centerY.mas_equalTo(self.navView.centerY).mas_offset(10);
//    }];
 
    /**
     *  增加导航栏View中的按钮
     */
    UIButton *addressBtn = [[UIButton alloc] init];
    [self.navView addSubview:addressBtn];
    
    [addressBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.navView);
        make.top.mas_equalTo(20);
        make.height.mas_equalTo(44);
        make.width.mas_equalTo(100);
    }];
    [addressBtn bk_addEventHandler:^(id sender) {
        YYCitysViewController *citys = [[YYCitysViewController alloc] initWithStyle:UITableViewStyleGrouped];
        [self.navigationController pushViewController:citys animated:YES];
    } forControlEvents:UIControlEventTouchUpInside];
    
    //增加图片
    UIImageView *addressIconImageView = [[UIImageView alloc] init];
    addressIconImageView.image = [UIImage imageNamed:@"home_addressIcon"];
    [addressBtn addSubview:addressIconImageView];
    
    [addressIconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(k12WidthMargin);
        make.height.mas_equalTo(18);
        make.width.mas_equalTo(12);
        make.centerY.mas_equalTo(addressBtn.centerY);
    }];
    
    //增加地址文字
    UILabel *addressTitleLabel = [[UILabel alloc] init];
    [addressBtn addSubview:addressTitleLabel];
    self.addressCityLabel = addressTitleLabel;
    self.addressCityLabel.adjustsFontSizeToFitWidth = YES;
    [addressTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(addressIconImageView.mas_right).mas_offset(5);
        make.right.mas_equalTo(searchBar.mas_left);
        make.top.bottom.mas_equalTo(addressIconImageView);
    }];
    addressTitleLabel.font = [UIFont systemFontOfSize:15.0];
    addressTitleLabel.textColor = [UIColor whiteColor];
    YYUserModel *userModel = [YYUserTool userModel];
    NSString *address = userModel.userCity;
    if (!address) {
        addressTitleLabel.text = @"正在定位";
    }
    else{
        addressTitleLabel.text = address;
    }
    
    
}
#pragma mark 设置tableView的headerView
/**
 *  设置tableView的headerView
 */
- (void)setTableViewContent{
    //创建headerView
    UIView *headerView = [[UIView alloc] init];
    headerView.height = _topScrollViewH + _topCollectionViewH;
    self.tableView.tableHeaderView = headerView;
    self.headerView = headerView;
    
    //增加图片轮播器
    [self addScrollerView];
    //增加collectionView
    [self addTopCollectionView];

}
#pragma mark 增加图片轮播器
/**
 *  增加图片轮播器
 */
- (void)addScrollerView{
    NSArray *imagesArray = @[[UIImage imageNamed:@"home_scrollerView_1"], [UIImage imageNamed:@"home_scrollerView_2"], [UIImage imageNamed:@"home_scrollerView_3"]];

    // 本地加载图片的轮播器
    SDCycleScrollView *topScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, kWidthScreen, _topScrollViewH) shouldInfiniteLoop:YES imageNamesGroup:imagesArray];
    topScrollView.delegate = self;
    topScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
    [self.headerView addSubview:topScrollView];
    //轮播时间间隔，默认1.0秒，可自定义
    topScrollView.autoScrollTimeInterval = 2.0;
}
/**
 *  增加collectionView
 */
- (void)addTopCollectionView{
    
    CGFloat itemXMargin = (kWidthScreen - 4 * _topItemW)/4.0;
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(_topItemW, _topItemH);
    layout.minimumLineSpacing = k12HeightMargin * 2;
    layout.minimumInteritemSpacing = itemXMargin;
    layout.scrollDirection = NO;
    layout.sectionInset = UIEdgeInsetsMake(k12HeightMargin, itemXMargin/2.0, k12HeightMargin, itemXMargin/2.0);
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, _topScrollViewH, kWidthScreen, _topCollectionViewH) collectionViewLayout:layout];
   
//    [collectionView registerClass:[YYHomeTopCollectionViewCell class]
//forCellWithReuseIdentifier:ID];
    
    [collectionView registerNib:[UINib nibWithNibName:@"YYHomeTopCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"YYHomeTopCollectionViewCell"];
    [self.headerView addSubview:collectionView];
    collectionView.dataSource = self.tableViewDatasource;
    collectionView.delegate = self;
    self.fruitCollectionView = collectionView;
    self.fruitCollectionView.backgroundColor = [UIColor whiteColor];

}
#pragma mark 图片轮播器的代理方法
/**
 *  图片轮播器的代理方法
 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    YYLog(@"%ld页被点击", (long)index);
}

#pragma 首页中的四个按钮被点击
/**
 *  首页中的四个按钮被点击
 */
- (void)homeBtnsClickWithNoti:(NSNotification *)noti{
    NSDictionary *userInfo = noti.userInfo;
    UIButton *btn = userInfo[kHomeBtn];
        if (btn.tag == 0) {
            YYShopTableViewController *shop = [[YYShopTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
            [self.navigationController pushViewController:shop animated:YES];
        }
        else if (btn.tag == 1){
            YYPickTableViewController *pick = [[YYPickTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
            [self.navigationController pushViewController:pick animated:YES];
        }
//        else if (btn.tag == 2){
//            YYSeasonFruitViewController *seasonFruit = [[YYSeasonFruitViewController alloc] init];
//            [self.navigationController pushViewController:seasonFruit animated:YES];
//        }
//        else if (btn.tag == 3){
//            self.noSignView.alpha = 0;
//            [self.view addSubview:self.noSignView];
//            [UIView animateWithDuration:0.5 animations:^{
//                self.noSignView.alpha = 1;
//            }];
//        }

}
#pragma mark 店铺单元格被点击
/**
 *  店铺单元格被点击
 */
- (void)tableViewShopCellClickWithNoti:(NSNotification *)noti{
    YYFruitShopModel *model = noti.userInfo[kShopCellModel];
    
    YYShopDetailViewController *shopDetail = [[YYShopDetailViewController alloc] initWithModel:model];
    [self.navigationController pushViewController:shopDetail animated:YES];
}
#pragma mark 图片单元格被点击
/**
 *  图片单元格被点击
 */
- (void)tableViewImageCellClickWithNoti:(NSNotification *)noti{
    NSIndexPath *indexPath = noti.userInfo[kImageCellIndexPath];
    if (indexPath.section == 1) {
        YYFruitStudyViewController *fruitStudy = [[YYFruitStudyViewController alloc] initWithUrlStr:@"http://mp.weixin.qq.com/mp/homepage?__biz=MzI1NzIxMDkwMw==&hid=1&sn=35f8b18435d1d4870437550deda651a9#wechat_redirect"];
        [self.navigationController pushViewController:fruitStudy animated:YES];
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
#pragma mark collectionView的代理方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    YYSeasonFruitModel *model = self.fruitArray[indexPath.item];
    
    YYSeasonFruitDeatilViewController *seasonFruit = [[YYSeasonFruitDeatilViewController alloc] initWithSeasonFruitModel:model];
    
    [self.navigationController pushViewController:seasonFruit animated:YES];
}
- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UIView *view = cell.contentView;
    view.layer.transform = self.firstInitialTransformation;
    view.layer.opacity = 0.5;
    
    [UIView animateWithDuration:0.2 animations:^{
        view.layer.transform = CATransform3DIdentity;
        view.layer.opacity = 1;
    }];

}

#pragma mark uitextField的代理方法
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    YYHomeSearchViewController *controller = [[YYHomeSearchViewController alloc] initWithSearchQuestion:@"搜你喜欢的水果"];
//    YYNavigationController *nav = [[YYNavigationController alloc] initWithRootViewController:controller];
//    [self presentViewController:nav animated:YES completion:^{
//        [controller.searchBar becomeFirstResponder];
//    }];
    [self.navigationController pushViewController:controller animated:YES];
    YYLog(@"开始输入");
    return NO;
}
@end
