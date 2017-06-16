//
//  YYCitysViewController.m
//  lcjfarm
//
//  Created by wyy on 16/7/15.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import "YYCitysViewController.h"
#import "YYCityModel.h"
#import "YYCitysArrayModel.h"

#import "YYCityTableViewCell.h"

#import "YYUserTool.h"

@interface YYCitysViewController ()<UITableViewDelegate>
@property (nonatomic, strong) NSMutableArray *citysArrayArray;
@end

@implementation YYCitysViewController
- (instancetype)initWithStyle:(UITableViewStyle)style{
    if (self = [super initWithStyle:style]) {
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return self;
}
- (NSMutableArray *)citysArrayArray{
    if (!_citysArrayArray) {
        _citysArrayArray = [NSMutableArray array];
    }
    return _citysArrayArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.tableView.sectionIndexColor = kNavColor;
    self.tableView.sectionIndexBackgroundColor = kViewBgGrayColor;
    //设置headerView
    [self setHeaderView];
    
    //获取城市列表
    [self getCitysList];
   
}
/**
 *  设置headerView
 */
- (void)setHeaderView{
   
}
/**
 *  获取城市列表
 */
- (void)getCitysList{
    [NSObject GET:@"http://app.guonongda.com:8080/city/showlist.do" parameters:nil progress:^(NSProgress *downloadProgress) {
        
    } completionHandler:^(NSDictionary *responseObject, NSError *error) {
        NSArray *citysArray = responseObject[@"data"];
        BOOL exist = NO;
        for (NSDictionary *dic in citysArray) {
            YYCityModel *model = [[YYCityModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            NSString *first = [model.py_name substringToIndex:1];
            //遍历数组查看是否已有该首字母
            exist = NO;
            for (YYCitysArrayModel *arrayModel in self.citysArrayArray) {
                if ([first isEqualToString:arrayModel.title]) {//若已存在则加入该数组
                    [arrayModel.citysArray addObject:model];
                    exist = YES;
                    break;
                }
            }
            //不存在该字母
            if (exist == NO) {
                YYCitysArrayModel *arrayModel = [[YYCitysArrayModel alloc] init];
                arrayModel.citysArray = [NSMutableArray array];
                [arrayModel.citysArray addObject:model];
                arrayModel.title = first;
                [self.citysArrayArray addObject:arrayModel];
                
            }
        }
        [self.tableView reloadData];
        
    }];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.citysArrayArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    YYCitysArrayModel *arrayModel = self.citysArrayArray[section];
    
    return arrayModel.citysArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YYCityTableViewCell *cell = [YYCityTableViewCell cityTableViewCellWithTableView:tableView];
    YYCitysArrayModel *arrayModel = self.citysArrayArray[indexPath.section];
    
    YYCityModel *model = arrayModel.citysArray[indexPath.row];
    cell.model = model;
    
    return cell;
}

//设置组名
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    YYCitysArrayModel *arrayModel = self.citysArrayArray[section];
    
    return arrayModel.title;
    
}
-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{

    return [self.citysArrayArray valueForKeyPath:@"title"];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.00001;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 34;
}
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    UIView *headerView = [[UIView alloc]init];
//    headerView.height = 34;
//    headerView.width = kWidthScreen;
//    headerView.backgroundColor = [UIColor whiteColor];
//    return headerView;
//}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    YYCitysArrayModel *arrayModel = self.citysArrayArray[indexPath.section];
    
    YYCityModel *model = arrayModel.citysArray[indexPath.row];

    YYUserModel *userModel = [YYUserTool userModel];

    if (![userModel.userCity isEqualToString:model.name]) {
        userModel.userCity = model.name;
 
    }
    
    [YYUserTool saveUserModel:userModel];
    
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    userInfo[kAddressKey] = model.name;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationGetAddress object:self userInfo:userInfo];
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
