//
//  YYHomeSearchViewController.m
//  pugongying
//
//  Created by wyy on 16/4/21.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import "YYHomeSearchViewController.h"
#import "WYYSearchBar.h"

#import "YYSearchWordModel.h"
#import "YYSearchHotTableViewCell.h"

#import "YYSearchSeasonFruitTableViewCell.h"
#import "YYSeasonFruitModel.h"
#import "YYSeasonFruitDeatilViewController.h"

#import "YYFruitNewsModel.h"

#import "YYTitleHeaderView.h"

#import "YYSearchFruitNewsTableViewCell.h"
#import "YYFruitNewsModel.h"
#import "YYFruitNewsWebViewController.h"


@interface YYHomeSearchViewController ()<UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate>{
    CGFloat _yMargin;
    
    NSMutableArray *_itemsArray;
    NSString *_ID;
    NSString *_question;
}
@property (nonatomic, weak) UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableArray <YYSearchWordModel *>*modelsArray;

/**
 *  tableView
 */
@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray <YYSeasonFruitModel *> *data1Array;
@property (nonatomic, strong) NSMutableArray <YYFruitNewsModel *> *data2Array;
/**
 *  tag值用来标记显示热度搜索(0)
 *                 搜索到的列表(1)
 */
@property (nonatomic, assign) NSInteger tag;

@end



@implementation YYHomeSearchViewController
#pragma mark 获取搜索热度的词
/**
 *  获取搜索热度的词
 */
- (void)getSearchTerms{
    [NSObject GET:@"http://app.guonongda.com:8080/sf/hot.do" parameters:nil progress:^(NSProgress *downloadProgress) {
        
    } completionHandler:^(NSDictionary *responseObject, NSError *error) {
        
        NSArray *searchArray = responseObject[@"data"];
        for (NSDictionary *dic in searchArray) {
            YYSearchWordModel *model = [[YYSearchWordModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [self.modelsArray addObject:model];
        }
        [self.tableView reloadData];
    }];
}

- (instancetype)initWithSearchQuestion:(NSString *)question{
    if (self = [super init]) {
        
        self.view.backgroundColor = [UIColor whiteColor];
        _question = question;
        self.tag = 0;
        self.data1Array = [NSMutableArray array];
        self.data2Array = [NSMutableArray array];
        
        //增加tableView
        [self addTableView];
        self.modelsArray = [NSMutableArray array];
        [self getSearchTerms];
        
    }
    return self;
}
/**
 *  增加tableView
 */
- (void)addTableView{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    [self.view addSubview:tableView];
    self.tableView = tableView;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view.mas_top).mas_offset(44);
    }];
    tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    //增加顶部的导航栏
    [self addNavBarWithHeight:64];
    
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}
/**
 *  增加顶部的导航栏
 */
- (void)addNavBarWithHeight:(CGFloat)height{
    UIView *navBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidthScreen, height)];
    [self.view addSubview:navBar];
    navBar.backgroundColor = kNavColor;
    
    //添加右边的取消按钮
    CGFloat cancelW = 40;
    CGFloat cancelX = kWidthScreen - cancelW - 10;
    CGFloat cancelY = 20;
    CGFloat cancelH = height - 20;
    UIButton *cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(cancelX, cancelY, cancelW, cancelH)];
    [navBar addSubview:cancelBtn];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(cancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    //增加搜索框
    CGFloat searchBarX = 12;
    CGFloat searchBarW = kWidthScreen - searchBarX - cancelW - 10 - 10;
    CGFloat searchBarH = 27.5;
    CGFloat searchBarY = (height - 20 - searchBarH)/2.0 + 20;
    WYYSearchBar *searchBar = [WYYSearchBar searchBarWithPlaceholderText:_question];
    searchBar.frame = CGRectMake(searchBarX, searchBarY, searchBarW, searchBarH);
    [navBar addSubview:searchBar];
    self.searchBar = searchBar;
    searchBar.returnKeyType = UIReturnKeySearch;
    searchBar.delegate = self;

}
- (void)cancelBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    YYLog(@"开始搜索");
    NSString *searchKeyWord = self.searchBar.text;
    if (searchKeyWord.length == 0) {
        [MBProgressHUD showError:@"请输入搜索关键字"];
    }
    [self searchWithKeyWord:searchKeyWord];
    
    return YES;
}
#pragma mark 根据名称搜索相应的应季水果和文章
/**
 * 根据名称搜索相应的应季水果和文章
 */
- (void)searchWithKeyWord:(NSString *)keyword{
    [MBProgressHUD showMessage:@"正在搜索"];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"name"] = keyword;

    [NSObject GET:@"http://app.guonongda.com:8080/sf/search.do" parameters:parameters progress:^(NSProgress *downloadProgress) {
        
    } completionHandler:^(id responseObject, NSError *error) {
         [MBProgressHUD hideHUD];
        if (error) {
            [MBProgressHUD showError:@"搜索失败"];
            return;
        }
        NSArray *data1Array = responseObject[@"data1"];
        NSArray *data2Array = responseObject[@"data2"];
//        YYLog(@"搜过结果%@", responseObject);
        if (data1Array.count == 0 && data2Array.count == 0) {
            [MBProgressHUD showError:@"搜索不到内容"];
            return;
        }
        else{
            [self.searchBar resignFirstResponder];
            self.tag = 1;
            self.tableView.backgroundColor = kViewBgGrayColor;
            
            [self.data1Array removeAllObjects];
            [self.data2Array removeAllObjects];
        
            for (NSDictionary *dic in data1Array) {
                YYSeasonFruitModel *model = [[YYSeasonFruitModel alloc] init];
                [model setValuesForKeysWithDictionary:dic];
                [self.data1Array addObject:model];
            }
            for (NSDictionary *dic in data2Array) {
                YYFruitNewsModel *model = [[YYFruitNewsModel alloc] init];
                [model setValuesForKeysWithDictionary:dic];
                [self.data2Array addObject:model];
            }
            
            [self.tableView reloadData];
            
        }
    }];
}
#pragma mark tableView的数据源方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.tag == 0) {
        return 1;
    }
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.tag == 0) {
        return self.modelsArray.count;
    }
    if (section == 0) {
        return self.data1Array.count;
    }
    return self.data2Array.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.tag == 0) {
        YYSearchHotTableViewCell *cell = [YYSearchHotTableViewCell searchHotTableViewCellWithTableView:tableView];
        YYSearchWordModel *model = self.modelsArray[indexPath.row];
        NSString *hotImageName = [NSString stringWithFormat:@"search_hot_%ld",(indexPath.row + 1)];
        model.hotImage = [UIImage imageNamed:hotImageName];
        switch (indexPath.row) {
            case 0:
                model.imageW = kWidthScreen - 375 + 210;
                break;
            case 1:
                model.imageW = kWidthScreen - 375 + 195;
                break;
            case 2:
                model.imageW = kWidthScreen - 375 + 170;
                break;
            case 3:
                model.imageW = kWidthScreen - 375 + 165;
                break;
            case 4:
                model.imageW = kWidthScreen - 375 + 140;
                break;
                
            default:
                break;
        }
        cell.model = model;
        
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        return cell;

    }
    if (indexPath.section == 0) {
        YYSearchSeasonFruitTableViewCell *cell = [YYSearchSeasonFruitTableViewCell searchSeasonFruitTableViewCellWithTableView:tableView];
        
        YYSeasonFruitModel *model = self.data1Array[indexPath.row];
        cell.model = model;
        if (indexPath.row == self.data1Array.count - 1) {
            cell.lineView.hidden = YES;
        }
        else{
            cell.lineView.hidden = NO;
        }
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return cell;
        
    }
    YYSearchFruitNewsTableViewCell *cell = [YYSearchFruitNewsTableViewCell YYSearchFruitNewsTableViewCellWithTableView:tableView];
    
    YYFruitNewsModel *model = self.data2Array[indexPath.row];
    cell.model = model;
    if (indexPath.row == self.data2Array.count - 1) {
        cell.lineView.hidden = YES;
    }
    else{
        cell.lineView.hidden = NO;
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}
#pragma mark tableView的代理方法
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (self.tag == 0) {
        return 38;
    }
    return 38 + 12;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.00001;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.tag == 0) {
        return 38;
    }
    if (indexPath.section == 0) {
        return 100;
    }
    return 114;
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (self.tag == 0) {
        YYTitleHeaderView *headerView = [[YYTitleHeaderView alloc] init];
        headerView.titleLabel.text = @"搜索热度";
        headerView.height = 38;
        return headerView;
    }
    UIView *headerView = [[UIView alloc] init];
    headerView.height = 50;
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidthScreen, 12)];
    backView.backgroundColor = kViewBgGrayColor;
    [headerView addSubview:backView];
    
    YYTitleHeaderView *titleView = [[YYTitleHeaderView alloc] init];
    titleView.frame = CGRectMake(0, 12, kWidthScreen, 38);
    titleView.lineView.frame = CGRectMake(10, 37.5, kWidthScreen - 20, 0.5);
    [headerView addSubview:titleView];
    if (section == 0) {
        titleView.titleLabel.text = @"应季水果";
    }
    else if (section == 1){
        titleView.titleLabel.text = @"相关文章";
    }
    return headerView;

    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.tag == 0) {
        YYSearchWordModel *model = self.modelsArray[indexPath.row];
        [self searchWithKeyWord:model.name];
    }
    else if (self.tag == 1){
        if (indexPath.section == 0) {
            YYSeasonFruitModel *model = self.data1Array[indexPath.row];
            
            YYSeasonFruitDeatilViewController *seasonController =[[YYSeasonFruitDeatilViewController alloc] initWithSeasonFruitModel:model];
            [self.navigationController pushViewController:seasonController animated:YES];
            
        }
        else if (self.tag == 1){
            
            YYFruitNewsModel *model = self.data2Array[indexPath.row];
            YYFruitNewsWebViewController *newsWeb = [[YYFruitNewsWebViewController alloc] initWithModel:model];
            [self.navigationController pushViewController:newsWeb animated:YES];
        }
    }
    
}
@end
