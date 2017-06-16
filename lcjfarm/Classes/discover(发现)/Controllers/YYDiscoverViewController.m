//
//  YYDiscoverViewController.m
//  lcjfarm
//
//  Created by wyy on 16/8/5.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import "YYDiscoverViewController.h"

#import "YYDiscoverDataSource.h"

#import <SDCycleScrollView.h>

#import "YYSeasonFruitViewController.h"
#import "YYFruitNewsTableViewController.h"

#import "YYDiscoverSurveyViewController.h"

@interface YYDiscoverViewController ()<SDCycleScrollViewDelegate, UITableViewDelegate>{
    YYDiscoverDataSource *_tableViewDataSource;
    
    CGFloat _topScrollViewH;
}

@property (nonatomic, weak) UIView *headerView;
@end

@implementation YYDiscoverViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    //开启ios右滑返回
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    }
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _topScrollViewH = 155.0/(667 - 64)*kNoNavHeight;
    //设置headerView
    [self setHeaderView];
    
    //设置数据源
    _tableViewDataSource = [[YYDiscoverDataSource alloc] init];
    self.tableView.dataSource = _tableViewDataSource;
 
    //设置代理
    self.tableView.delegate = self;
}
/**
 *  设置headerView
 */
- (void)setHeaderView{
    
    CGFloat btnH = 45;
    //创建headerView
    UIView *headerView = [[UIView alloc] init];
    headerView.height = _topScrollViewH + btnH;
    self.tableView.tableHeaderView = headerView;
    self.headerView = headerView;
    
    //增加图片轮播器
    [self addScrollerView];
    
    //增加下面两个按钮的View
    [self addTwoBtnView];
    
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
#pragma mark 图片轮播器的代理方法
/**
 *  图片轮播器的代理方法
 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    YYLog(@"%ld页被点击", (long)index);
}
#pragma mark 增加下面两个按钮的View
/**
 *  增加下面两个按钮的View
 */
- (void)addTwoBtnView{
    UIView *btnsView = [[UIView alloc] init];
    btnsView.backgroundColor = [UIColor whiteColor];
    btnsView.frame = CGRectMake(0, _topScrollViewH, kWidthScreen, 45);
    [self.headerView addSubview:btnsView];
    
    //增加三条线
    [YYLcjFarmTool addLineViewWithFrame:CGRectMake(0, 0, kWidthScreen, 0.5) andView:btnsView];
    
    [YYLcjFarmTool addLineViewWithFrame:CGRectMake(0, 44.5, kWidthScreen, 0.5) andView:btnsView];
    CGFloat lineX = kWidthScreen / 2.0;
    CGFloat lineH = 45 - 10;
    CGFloat lineY = 10/2.0;
    [YYLcjFarmTool addLineViewWithFrame:CGRectMake(lineX, lineY, 0.5, lineH) andView:btnsView];
    //增加两个按钮
    [self addTwoBtnWithSuperView:btnsView];
   
    
}
/**
 *  增加两个按钮
 */
- (void)addTwoBtnWithSuperView:(UIView *)btnsView{
    //增加问卷调查按钮
    CGFloat btnW = (kWidthScreen - 0.5)/2.0;
    CGFloat btnH = 45 - 1;
    UIButton *surveyBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0.5, btnW, btnH)];
    [btnsView addSubview:surveyBtn];
    [surveyBtn setTitle:@"问卷调查" forState:UIControlStateNormal];
    [surveyBtn setImage:[UIImage imageNamed:@"discover_survey"] forState:UIControlStateNormal];
    [surveyBtn setTitleColor:kBlackTextColor forState:UIControlStateNormal];
    surveyBtn.titleLabel.font = [UIFont systemFontOfSize:18.0];
    surveyBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    [surveyBtn setImage:[UIImage imageNamed:@"discover_survey"] forState:UIControlStateHighlighted];
    [surveyBtn bk_addEventHandler:^(id sender) {
        YYDiscoverSurveyViewController *survey = [[YYDiscoverSurveyViewController alloc] initWithUrlStr:@"https://sojump.com/jq/9281103.aspx"];
        [self.navigationController pushViewController:survey animated:YES];
    } forControlEvents:UIControlEventTouchUpInside];
    
    //增加水果游戏按钮
    UIButton *gameBtn = [[UIButton alloc] initWithFrame:CGRectMake(btnW + 0.5, 0.5, btnW, btnH)];
    [btnsView addSubview:gameBtn];
    [gameBtn setTitle:@"水果游戏" forState:UIControlStateNormal];
    [gameBtn setImage:[UIImage imageNamed:@"discover_game"] forState:UIControlStateNormal];
    [gameBtn setTitleColor:kBlackTextColor forState:UIControlStateNormal];
    gameBtn.titleLabel.font = [UIFont systemFontOfSize:18.0];
    gameBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    [gameBtn setImage:[UIImage imageNamed:@"discover_game"] forState:UIControlStateHighlighted];
    
    [gameBtn bk_addEventHandler:^(id sender) {
        YYLog(@"水果游戏被点击");
    } forControlEvents:UIControlEventTouchUpInside];
}
#pragma mark tableView的代理方法
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 12;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 67;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        YYSeasonFruitViewController *seasonFruit = [[YYSeasonFruitViewController alloc] init];
        [self.navigationController pushViewController:seasonFruit animated:YES];
    }
    else if (indexPath.row == 1){
        YYFruitNewsTableViewController *newsController = [[YYFruitNewsTableViewController alloc] init];
        [self.navigationController pushViewController:newsController animated:YES];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
