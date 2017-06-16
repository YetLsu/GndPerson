//
//  YYHomeTableViewDelegate.m
//  lcjfarm
//
//  Created by wyy on 16/7/4.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import "YYHomeTableViewDelegate.h"

#import "YYHomeViewBtn.h"

#import "YYFruitShopModel.h"

@interface YYHomeTableViewDelegate (){
    NSIndexPath *_lastIndexPath;
    CGFloat _btnsViewH;
    CGFloat _imageBtnH;
    CGFloat _nearShopHeaderViewH;
}
/**
 *  第一个单元格变换时的参数
 */
@property (nonatomic, assign) CATransform3D firstInitialTransformation;
/**
 *  后面的单元格上拉变换时的参数
 */
@property (nonatomic, assign) CATransform3D otherUpInitialtransformation;
/**
 *  后面的单元格下拉变换时的参数
 */
@property (nonatomic, assign) CATransform3D otherDownInitialtransformation;

@end

@implementation YYHomeTableViewDelegate
- (instancetype)init{
    if (self = [super init]) {
        
        //初始化数据
        [self installDatas];
    }
    return self;
}
/**
 *  初始化数据
 */
- (void)installDatas{
    CGFloat ontBtnH = 70/603.0*kNoNavHeight;
    _btnsViewH = ontBtnH;
    _imageBtnH = 200/603.0 * kNoNavHeight;
    
    _nearShopHeaderViewH = k12HeightMargin * 2 + 15 + k12HeightMargin;
    
    CATransform3D transform = CATransform3DIdentity;
    //    transform = CATransform3DTranslate(transform, offsetPositioning.x, offsetPositioning.y, 0.0);
    transform = CATransform3DMakeScale(1.1, 1.1, 1);
    self.firstInitialTransformation = transform;
    
    CATransform3D otherTransform = CATransform3DIdentity;
    otherTransform = CATransform3DTranslate(otherTransform, 0, 70, 0);
    self.otherUpInitialtransformation = otherTransform;
    
    CATransform3D downTransForm = CATransform3DIdentity;
    downTransForm = CATransform3DTranslate(otherTransform, 0, -100, 0);
    self.otherDownInitialtransformation = downTransForm;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 2) {
        return _nearShopHeaderViewH;
    }
    return k12HeightMargin;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
 
    return 0.00001;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return _btnsViewH;
    }
    else if (indexPath.section == 1){
        return _imageBtnH;
    }
    return 114;
}
/**
 *  tableView的header和footer的View
 */
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = [UIColor clearColor];
    
    if (section == 2) {
        headerView.height = _nearShopHeaderViewH;
        CGFloat titleLabelW = kWidthScreen - k12WidthMargin * 2;
        CGFloat titleViewH = _nearShopHeaderViewH - k12HeightMargin;
        UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, k12HeightMargin, kWidthScreen, titleViewH)];
        [headerView addSubview:titleView];
        titleView.backgroundColor = [UIColor whiteColor];
        //增加线
        [YYLcjFarmTool addLineViewWithFrame:CGRectMake(0, titleViewH - 0.5, kWidthScreen, 0.5) andView:titleView];
        //增加Label
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(k12WidthMargin, 0, titleLabelW, titleViewH)];
        [titleView addSubview:titleLabel];
        titleLabel.text = @"附近的水果店";
        titleLabel.textColor = kBlackTextColor;
        titleLabel.font = [UIFont systemFontOfSize:15.0];
    }
    else{
        headerView.height = k12HeightMargin;
    }
    
    return headerView;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == 0) {
        UIView *footView = [[UIView alloc] init];
        footView.height = 49;
        footView.backgroundColor = [UIColor clearColor];
        return footView;
    }
    return nil;
}
/**
 *  tableView的单元格即将显示的方法
 */
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        NSArray *homeBtnsArray = cell.contentView.subviews;
        for (UIView *subView in homeBtnsArray) {
            if ([subView isKindOfClass:[YYHomeViewBtn class]]) {
                YYHomeViewBtn *btn = (YYHomeViewBtn *)subView;
                btn.layer.transform = self.firstInitialTransformation;
                btn.layer.opacity = 0.5;
    
                [UIView animateWithDuration:0.2 animations:^{
                    btn.layer.transform = CATransform3DIdentity;
                    btn.layer.opacity = 1;
                }];

            }
        }
    }
    else{
        BOOL scrollerUp = YES;
        if (_lastIndexPath) {
            if (_lastIndexPath.section != indexPath.section) {
                if (_lastIndexPath.section > indexPath.section) scrollerUp = NO;
            }
            else{
                if (_lastIndexPath.row > indexPath.row) scrollerUp = NO;
            }
        }
        
        UIView *view = cell.contentView;
        view.layer.opacity = 0.5;
        if (scrollerUp) {
            view.layer.transform = self.otherUpInitialtransformation;
            
            [UIView animateWithDuration:0.2 animations:^{
                view.layer.transform = CATransform3DIdentity;
                view.layer.opacity = 1;
            }];
        }
        else{
            view.layer.transform = self.otherDownInitialtransformation;
            [UIView animateWithDuration:0.2 animations:^{
                view.layer.transform = CATransform3DIdentity;
                view.layer.opacity = 1;
            }];
        }
        _lastIndexPath = indexPath;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 2) {
        YYFruitShopModel *model = self.modelsArray[indexPath.row];
        NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
        userInfo[kShopCellModel] = model;
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationShopCellClick object:self userInfo:userInfo];
    }
    else if (indexPath.section == 1){
         NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
        userInfo[kImageCellIndexPath] = indexPath;
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationImageCellClick object:self userInfo:userInfo];
        
    }
}


@end
