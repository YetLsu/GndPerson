//
//  YYSeasonFruitDetailTableViewDelegate.m
//  lcjfarm
//
//  Created by wyy on 16/7/12.
//  Copyright © 2016年 WYY. All rights reserved.
//
#define headerHeight (k12HeightMargin * 2 + 18)
/**
 *  从userInfo中取出单元格的模型
 */
#define kShopCellModel @"kShopCellModel"

#import "YYSeasonFruitDetailTableViewDelegate.h"
#import "YYFruitShopModel.h"
#import "YYSeasonFruitModel.h"

#import "YYPickIntroModel.h"

@interface YYSeasonFruitDetailTableViewDelegate (){
    NSIndexPath *_lastIndexPath;
    /**
     *  单元格上拉变换时的参数
     */
    CATransform3D _upInitialtransformation;
    /**
     *  单元格下拉变换时的参数
     */
    CATransform3D _downInitialtransformation;
    
    CGFloat _nearShopHeaderViewH;
    
    
    YYSeasonFruitModel *_model;
    /**
     *  水果介绍的高度
     */
    CGFloat _fruitIntroCellH;
}
@property (nonatomic, strong) NSArray <YYPickIntroModel *>*seasonFruitIntroModelsArray;
@end


@implementation YYSeasonFruitDetailTableViewDelegate
- (instancetype)initWithModel:(YYSeasonFruitModel *)model andSeasonFruitintroModelsArray:(NSArray <YYPickIntroModel *>*) modelsArray{
    if (self = [super init]) {
        _model = model;
        self.seasonFruitIntroModelsArray = modelsArray;
        
        //计算行高
        CGFloat maxW = kWidthScreen - 12 * 2;
        NSMutableDictionary *attr = [NSMutableDictionary dictionary];
        attr[NSFontAttributeName] = [UIFont systemFontOfSize:13];
        NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
        paragraph.lineSpacing = 5;
        attr[NSParagraphStyleAttributeName] = paragraph;
        
        CGFloat labelH = [model.introduction boundingRectWithSize:CGSizeMake(maxW, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:attr context:nil].size.height;
        _fruitIntroCellH = labelH + 12 + 12;
        
        //tableView动画
        CATransform3D otherTransform = CATransform3DIdentity;
        otherTransform = CATransform3DTranslate(otherTransform, 0, 30, 0);
        _upInitialtransformation = otherTransform;
        
        CATransform3D downTransForm = CATransform3DIdentity;
        downTransForm = CATransform3DTranslate(otherTransform, 0, -50, 0);
        _downInitialtransformation = downTransForm;
        
        _nearShopHeaderViewH = k12HeightMargin * 2 + 15 + k12HeightMargin;
    }
    return self;
}
/**
 *  tableView的单元格即将显示的方法
 */
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
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
        view.layer.transform = _upInitialtransformation;
        
        [UIView animateWithDuration:0.2 animations:^{
            view.layer.transform = CATransform3DIdentity;
            view.layer.opacity = 1;
        }];
    }
    else{
        view.layer.transform = _downInitialtransformation;
        [UIView animateWithDuration:0.2 animations:^{
            view.layer.transform = CATransform3DIdentity;
            view.layer.opacity = 1;
        }];
    }
    _lastIndexPath = indexPath;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.00001;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        return k12HeightMargin;
    }
    else if (section == 3){
        return _nearShopHeaderViewH;
    }
    return 0.00001;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 72;
    }
    else if (indexPath.section ==1){
        return 12 + 18 + 12 + 70 + 24 + 18 + 12 + 175 + 24 + 18 + 12 + 13 + 12 + 13 + 12;
    }
    else if (indexPath.section == 2){
        YYPickIntroModel *model = self.seasonFruitIntroModelsArray[indexPath.row];
        return k12HeightMargin + 18 + 8 + model.contentH + 2 + k12HeightMargin;
    }
    return 104;
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 3) {
        UIView *headerView = [[UIView alloc] init];
        headerView.backgroundColor = [UIColor clearColor];
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
        
        return headerView;
    }
//    if (section == 1) {
//        UIView *headerView = [self createHeaderView];
//        
//        return headerView;
//    }
//    if (section == 2) {
//
//    }
    return nil;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if ([self.delegate respondsToSelector:@selector(tableViewScrollWithContentY:)]) {
        CGFloat contentY = scrollView.contentOffset.y;
        [self.delegate tableViewScrollWithContentY:contentY];
    }
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
    likeImageView.image = [UIImage imageNamed:@"home_seasonFruit_fruitIntro"];
    [centerView addSubview:likeImageView];
    //在中间的View上增加title
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(iconW + k12WidthMargin, 0, titleW, 18)];
    [centerView addSubview:label];
    label.text = @"水果简介";
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
@end
