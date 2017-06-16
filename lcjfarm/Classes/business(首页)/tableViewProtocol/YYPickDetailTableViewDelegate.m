//
//  YYPickDetailTableViewDelegate.m
//  lcjfarm
//
//  Created by wyy on 16/7/5.
//  Copyright © 2016年 WYY. All rights reserved.
//
/**
 *  从userInfo中取出单元格的模型
 */
#define kShopCellModel @"kShopCellModel"
#define headerHeight (k12HeightMargin * 3 + 18)
#define secondHeaderHeight (k12HeightMargin * 3 + 18 + 5)
#import "YYPickDetailTableViewDelegate.h"

#import "YYPickIntroModel.h"

#import "YYFruitShopModel.h"
#import "YYPickTableViewModel.h"

@interface YYPickDetailTableViewDelegate (){
    NSArray *_pickIntroModelsArray;
    
    YYPickTableViewModel *_model;
}

@end

@implementation YYPickDetailTableViewDelegate
- (instancetype)initWithPickModel:(YYPickTableViewModel *)model{
    if (self = [super init]) {
        _model = model;
    }
    return self;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0.00001;
    }
    else if (section == 1){
        return k12HeightMargin;
    }
    else if (section == 2){
        return secondHeaderHeight;
    }
    return headerHeight;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.00001;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if ([self.delegate respondsToSelector:@selector(tableViewScrollWithContentY:)]) {
        CGFloat contentY = scrollView.contentOffset.y;
        [self.delegate tableViewScrollWithContentY:contentY];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        CGFloat height = 7 * k12HeightMargin + (7.5 + 18 + 23)/603.0 *kNoNavHeight + 18 + 13 + 15 + 10 + 13 + 13;
        return height;
    }
    else if (indexPath.section == 1){
        return 118;
    }
    else if (indexPath.section == 2){
        
        NSMutableDictionary *attr = [NSMutableDictionary dictionary];
        attr[NSFontAttributeName] = [UIFont systemFontOfSize:15.0];
        CGFloat contentLabelW = kWidthScreen - 10 - 18;
        NSString *content = nil;
        if (indexPath.row == 0) {
            content = [NSString stringWithFormat:@"性质：%@", _model.property];
        }
        else if (indexPath.row == 1){
            content = [NSString stringWithFormat:@"娱乐设施：%@", _model.entertainment];
        }
        else if (indexPath.row == 2){
            content = [NSString stringWithFormat:@"周边景点：%@", _model.surrounding];
        }
        else if (indexPath.row == 3){
            content = [NSString stringWithFormat:@"采摘项目：%@", _model.projects];
        }
        return [content boundingRectWithSize:CGSizeMake(contentLabelW, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:attr context:nil].size.height + 10;
    }
    return 104;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 2){
        return [self secondHeaderView];
    }
    else if (section == 3) {
        UIView *headerView = [self createHeaderView];
        
        return headerView;
    }
    return nil;
}
- (UIView *)createHeaderView{
    UIView *view = [[UIView alloc] init];
    view.height = headerHeight;
    view.backgroundColor = kViewBgGrayColor;
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, k12HeightMargin, kWidthScreen, headerHeight - k12HeightMargin)];
    [view addSubview:titleView];
    titleView.backgroundColor = [UIColor whiteColor];
    //增加中间的View
    CGFloat titleW = 75;
    CGFloat iconW = 20;
    CGFloat centerViewW = titleW + k12WidthMargin + iconW;
    CGFloat centerViewX = (kWidthScreen - centerViewW)/2.0;
    UIView *centerView = [[UIView alloc] initWithFrame:CGRectMake(centerViewX, k12HeightMargin, centerViewW, 18)];
    [titleView addSubview:centerView];
    
    //在中间的View上增加图片
    UIImageView *likeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0.5, iconW, 17.5)];
    likeImageView.image = [UIImage imageNamed:@"home_shop_detail_like"];
    [centerView addSubview:likeImageView];
    //在中间的View上增加title
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(iconW + k12WidthMargin, 0, titleW, 18)];
    [centerView addSubview:label];
    label.text = @"猜你喜欢";
    label.textColor = kBlackTextColor;
    label.font = [UIFont systemFontOfSize:18.0];
    return view;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 3) {
        YYFruitShopModel *model = self.modelsArray[indexPath.row];
        NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
        userInfo[kShopCellModel] = model;
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationShopCellClick object:self userInfo:userInfo];
    }
}
//温馨提示的headerView
- (UIView *)secondHeaderView{
    UIView *headerView = [[UIView alloc] init];
    headerView.height = secondHeaderHeight;
    
    headerView.backgroundColor = [UIColor whiteColor];
    //增加灰色的View
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidthScreen, k12HeightMargin)];
    [headerView addSubview:topView];
    topView.backgroundColor = kViewBgGrayColor;
    
    //增加温馨提示的Label
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, k12HeightMargin * 2, kWidthScreen, 18)];
    [headerView addSubview:label];
    label.text = @"温馨提示";
    label.textColor = kBlackTextColor;
    label.font = [UIFont systemFontOfSize:18.0];
    
    //增加分割线
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(10, k12HeightMargin * 3 + 18, kWidthScreen - 10 * 2, 0.5)];
    lineView.backgroundColor = kGrayLineColor;
    [headerView addSubview:lineView];
    
    return headerView;
    
}
@end
