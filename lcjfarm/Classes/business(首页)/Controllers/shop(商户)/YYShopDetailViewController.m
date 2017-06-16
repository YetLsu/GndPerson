//
//  YYShopDetailTableViewController.m
//  lcjfarm
//
//  Created by wyy on 16/6/30.
//  Copyright © 2016年 WYY. All rights reserved.
//
#define kHeaderImageViewH (235/603.0*kNoNavHeight)

#import "YYShopDetailViewController.h"
#import "YYFruitShopModel.h"

#import "YYShopDetailTableViewDataSource.h"
#import "YYDetailTableViewDelegate.h"
#import "YYShopDetailTableViewViewModel.h"
#import "YYMapViewController.h"

#import "YYUserTool.h"

#import <SDCycleScrollView.h>

#import "YYMarkModel.h"
#import "YYShopCommentModel.h"
#import "YYAllShopCommentTableViewController.h"
#import "YYWriteCommentViewController.h"
#import "YYSeeAllMarksTableViewController.h"


@interface YYShopDetailViewController ()<YYDetailTableViewDelegateDelegate>
/**
 *  店铺信息
 */
@property (nonatomic, strong) YYFruitShopModel *model;
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

@property (nonatomic, strong) YYShopDetailTableViewDataSource *tableViewDatasource;

@property (nonatomic, strong) YYDetailTableViewDelegate *tableViewDelegate;
/**
 *  tableView
 */
@property (nonatomic, weak) UITableView *tableView;
/**
 * tableView的headerImageView
 */
@property (nonatomic, weak) UIImageView *headerImageView;

@property (nonatomic, strong) YYShopDetailTableViewViewModel *viewModel;

@property (nonatomic, assign) int index;
/**
 *  商店模型数组
 */
@property (nonatomic, strong) NSMutableArray *modelsArray;

@property (nonatomic, strong) NSArray<YYMarkModel *> *marksArray;

@property (nonatomic, strong) NSMutableArray <YYShopCommentModel *> *commentsArray;


@end

@implementation YYShopDetailViewController
- (NSMutableArray *)modelsArray{
    if (!_modelsArray) {
        _modelsArray = [NSMutableArray array];
    }
    return _modelsArray;
}

- (YYShopDetailTableViewViewModel *)viewModel{
    if (!_viewModel) {
        _viewModel = [[YYShopDetailTableViewViewModel alloc] init];
    }
    return _viewModel;
}
#pragma mark 创建控制器
/**
 *  创建控制器
 */
- (instancetype)initWithModel:(YYFruitShopModel *)model{
    if (self = [super init]) {
        self.model = model;
        self.index = 0;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kViewBgGrayColor;
    
    self.marksArray = [NSArray array];
    
    
    YYShopCommentModel *commentModel = [[YYShopCommentModel alloc] init];
    commentModel.username = @"果农达";
    commentModel.metime = @"2018-8-8";
    commentModel.medetails = @"这家店很不多";
    commentModel.codetails = @"家店很不多";
    
    YYShopCommentModel *commentModel1 = [[YYShopCommentModel alloc] init];
    commentModel1.username = @"果农达commentModel1";
    commentModel1.metime = @"2018-8-8";
    commentModel1.medetails = @"这家店很不多commentModel1";
    commentModel1.codetails = @"家店很不多commentModel1";
    self.commentsArray = [NSMutableArray array];
    [self.commentsArray addObject:commentModel];
    
    [self.commentsArray addObject:commentModel1];
//    [self.commentsArray addObject:commentModel];
    
    //获取该店铺是否收藏
    [self getShopCollect];
    
    //添加导航栏View和下面的TableView
    [self addNavViewAndTableView];
    
    //加载这家店铺的信息
    [self getThisShopMessage];
    //第一次加载附近商铺的数据
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
/**
 *  加载这家店铺的信息
 */
- (void)getThisShopMessage{
    NSString *userID = nil;
    YYUserModel *userModel = [YYUserTool userModel];
    if (userModel.userID) {
        userID = userModel.userID;
    }
    else{
        userID = @"-1";
    }
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"name"] = userModel.userCity;
    parameters[@"shopid"] = self.model.shopid;
    parameters[@"userid"] = userID;
    
    [self.viewModel getShopMessageWithParameters:parameters callback:^(YYFruitShopModel *shopModel, NSMutableArray<YYMarkModel *> *marksArray, NSMutableArray<YYShopCommentModel *> *commentsArray, NSString *number,NSError *error) {
        if (error) {
            return;
        }
        else{
            self.marksArray = marksArray;
            self.tableViewDatasource.marksArray = self.marksArray;
            self.tableViewDelegate.marksArray = self.marksArray;
            
            self.commentsArray = commentsArray;
            self.tableViewDatasource.commentsArray = self.commentsArray;
            self.tableViewDelegate.commentArray = self.commentsArray;
     
            NSString *commentContent = nil;
            if ([number isEqualToString:@"0"]) {
                commentContent = nil;
            }
            else{
                commentContent = [NSString stringWithFormat:@"(%@条留言)", number];
            }
            self.tableViewDelegate.commentConent = commentContent;
            [self.tableView reloadData];

        }
    }];
    
}
#pragma mark 获取该店铺是否收藏
/**
 *  获取该店铺是否收藏
 */
- (void)getShopCollect{
    
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
    parameters[@"shopid"] = self.model.shopid;
    parameters[@"userid"] = userID;
    [NSObject GET:@"http://app.guonongda.com:8080/shop/show.do" parameters:parameters progress:^(NSProgress *downloadProgress) {
        
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
- (void)shopPhoneClick{
        NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",self.model.phone];
        UIWebView * callWebview = [[UIWebView alloc] init];
        [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
        [self.view addSubview:callWebview];
}
- (void)shopNavigationClick{
    YYMapViewController *map = [[YYMapViewController alloc] initWithFruitShopModel:self.model andTag:1];
    [self.navigationController pushViewController:map animated:YES];
}
#pragma mark 添加通知
/**
 *  添加通知
 */
- (void)addNotifications{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shopPhoneClick) name:kNotificationPhoneShopBtnClick object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shopNavigationClick) name:kNotificationNavigationShopBtnClick object:nil];
    //单元格点击事件
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shopCellClick:) name:kNotificationShopCellClick object:self.tableViewDelegate];
}
#pragma mark 猜你喜欢 店铺单元格被点击
/**
 *  猜你喜欢 店铺单元格被点击
 */
- (void)shopCellClick:(NSNotification *)noti{
    YYFruitShopModel *model = noti.userInfo[kShopCellModel];
    
    YYShopDetailViewController *shopDetail = [[YYShopDetailViewController alloc] initWithModel:model];
    [self.navigationController pushViewController:shopDetail animated:YES];
}
#pragma mark 增加下面部分的我要去这里的Button
/**
 *  增加下面部分的我要去这里的Button
 */
- (void)addBottomBtn{
    //增加导航按钮
    UIButton *navBtn = [[UIButton alloc] init];
    [self.view addSubview:navBtn];
    [navBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.mas_equalTo(self.view);
        make.right.mas_equalTo(self.view.mas_centerX);
        make.height.mas_equalTo(44);
    }];
    navBtn.backgroundColor = kNavColor;
    navBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [navBtn setTitle:@"我要去这里" forState:UIControlStateNormal];
    [navBtn setImage:[UIImage imageNamed:@"discover_fruitNews"] forState:UIControlStateNormal];
    [navBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //导航按钮被点击
    [navBtn bk_addEventHandler:^(id sender) {
        YYMapViewController *map = [[YYMapViewController alloc] initWithFruitShopModel:self.model andTag:1];
        [self.navigationController pushViewController:map animated:YES];
    } forControlEvents:UIControlEventTouchUpInside];
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
        
        self.tableViewDatasource.modelsArray = self.modelsArray;
        self.tableViewDelegate.modelsArray = self.modelsArray;

        [self.tableView reloadData];
    }];
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
    
    __weak __typeof(&*self)weakSelf = self;
    
    self.tableViewDatasource = [[YYShopDetailTableViewDataSource alloc] initWithFruitShopModel:self.model];
    tableView.dataSource = self.tableViewDatasource;
    self.tableViewDelegate = [[YYDetailTableViewDelegate alloc] init];
    tableView.delegate = self.tableViewDelegate;
    self.tableViewDelegate.delegate = self;
    
    [self.tableViewDatasource setYYSeeAllMarkBlock:^{
        YYSeeAllMarksTableViewController *seeAllMarks = [[YYSeeAllMarksTableViewController alloc] initWithMarksArray:weakSelf.marksArray];
        [weakSelf.navigationController pushViewController:seeAllMarks animated:YES];
        YYLog(@"查看全部标签被点击");
    }];
    
    [self.tableViewDelegate setYYSeeAllCommentblock:^{
        YYAllShopCommentTableViewController *commentController = [[YYAllShopCommentTableViewController alloc] initWithCommentsArray:weakSelf.commentsArray andShopModel:weakSelf.model];
        [weakSelf.navigationController pushViewController:commentController animated:YES];
    }];
    
    [self.tableViewDelegate setYYWriteCommentBlock:^{
        YYWriteCommentViewController *writeController = [[YYWriteCommentViewController alloc] initWithShopModel:weakSelf.model];
        //评论提交成功
        [writeController setYYPostCommentSuccessBlock:^{
            [weakSelf getThisShopMessage];
            
        }];
        
        [weakSelf.navigationController pushViewController:writeController animated:YES];
       
    }];
    
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

    if ([self.model.collection isEqualToString:@"1"]) {
        [self.collectBtn setImage:[UIImage imageNamed:@"home_pick_collect"] forState:UIControlStateNormal];
    }
    else{
        [self.collectBtn setImage:[UIImage imageNamed:@"home_pick_noCollect"] forState:UIControlStateNormal];
    }
    
    [self.collectBtn bk_addEventHandler:^(id sender) {
        YYUserModel *userModel = [YYUserTool userModel];
        
        if (!userModel.userID) {
            [MBProgressHUD showError:@"请先登录"];
            return;
        }
        NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
        parameters[@"userid"] = userModel.userID;
        parameters[@"shopid"] = self.model.shopid;
        parameters[@"name"] = userModel.userCity;
        
        if ([self.model.collection isEqualToString:@"1"]) {//取消收藏
            YYLog(@"取消收藏按钮被点击");
            [NSObject POST:@"http://app.guonongda.com:8080/coll/delscoll.do" parameters:parameters progress:^(NSProgress *downloadProgress) {
                
            } completionHandler:^(id responseObject, NSError *error) {
                YYLog(@"responseObj:%@\n error:%@", responseObject, error);
                if (error) {
                    [MBProgressHUD showError:@"取消收藏店铺失败"];
                    return;
                }
                 NSString *collect = responseObject[@"collection"];
                if ([collect isEqualToString:@"-2"]) {
                    [MBProgressHUD showError:@"还未收藏过该店铺"];
                    return;
                }
                else if ([collect isEqualToString:@"0"]){
                    [MBProgressHUD showSuccess:@"成功取消收藏该店铺"];
                    [self.collectBtn setImage:[UIImage imageNamed:@"home_pick_noCollect"] forState:UIControlStateNormal];
                    self.model.collection = @"0";
                }
            }];
        }
        else{//收藏
            YYLog(@"收藏按钮被点击");
            [NSObject POST:@"http://app.guonongda.com:8080/coll/addscoll.do" parameters:parameters progress:^(NSProgress *downloadProgress) {
                
            } completionHandler:^(NSDictionary *responseObject, NSError *error) {
                if (error) {
                    [MBProgressHUD showError:@"收藏店铺失败"];
                    return;
                }
                NSString *collect = responseObject[@"collection"];
                if ([collect isEqualToString:@"-1"]) {
                    [MBProgressHUD showError:@"已收藏该商店"];
                    return;
                }
                else if ([collect isEqualToString:@"1"]){
                    [MBProgressHUD showSuccess:@"成功收藏该店铺"];
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
    titleLabel.text = @"店铺详情";
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
//    YYLog(@"%@", imageStrsArray);
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
   
}
///**
// *  设置headerView
// */
//- (void)setTableViewHeaderView{
//    UIView *headerView = [[UIView alloc] init];
//    headerView.height = kHeaderImageViewH - 20;
//    self.tableView.tableHeaderView = headerView;
//    
//    UIImageView *headerImageView = [[UIImageView alloc] init];
//    [headerView addSubview:headerImageView];
//    self.headerImageView = headerImageView;
//    [headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.bottom.mas_equalTo(headerView);
//        make.top.mas_equalTo(headerView).mas_offset(-20);
//    }];
//    [headerImageView sd_setImageWithURL:[NSURL URLWithString:self.model.imglisturl]];
//    
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
//    
//}
- (void)tableViewScrollWithContentY:(CGFloat)contentY{
    contentY += 150;
//    YYLog(@"%f", contentY);
    if (contentY < 0) {
        contentY = 0;
    }
    CGFloat alpha = contentY > kHeaderImageViewH ? 1 : (contentY/kHeaderImageViewH);
//    YYLog(@"透明度：%f",alpha);
    self.navColorView.alpha = alpha;
    
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //添加通知
    [self addNotifications];
    
    self.navigationController.navigationBarHidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //移除通知
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    self.navigationController.navigationBarHidden = NO;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
