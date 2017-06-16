//
//  YYDetailTableViewDelegate.m
//  lcjfarm
//
//  Created by wyy on 16/7/1.
//  Copyright © 2016年 WYY. All rights reserved.
//
#define headerHeight (k12HeightMargin * 2 + 18)//标题下面的空白在tableViewcell 中
#define headerCommentH (k12HeightMargin * 3 + 14)
#import "YYDetailTableViewDelegate.h"
#import "YYShopDetailCommentTitleView.h"
#import "YYShopCommentModel.h"


@implementation YYDetailTableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0.00001;
    }
    return headerHeight;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 2) {
        return 38;
    }
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
        NSInteger count = self.marksArray.count < 20 ? self.marksArray.count : 20;
        
        NSInteger lines = count/5;
        CGFloat line = count%5;
        if (line != 0) {
            lines += 1;
        }
        CGFloat xMargin = k12WidthMargin;
        CGFloat itemW = (kWidthScreen - xMargin * 6)/5.0;
        CGFloat itemH = itemW + 5 + 12 + 5;
        CGFloat collectionHeight = k12HeightMargin + itemH * lines;
        
        return collectionHeight + k12HeightMargin + 20 + k12HeightMargin;
//        return collectionHeight + k12HeightMargin + 20 + k12HeightMargin + 30 + k12HeightMargin;
        
    }
    else if (indexPath.section == 2){
        
        YYShopCommentModel *model = self.commentArray[indexPath.row];
        //计算评论的高度
        return [self calculateSection2WithCommentModel:model];
    }
    return 104;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        UIView *headerView = [self createHeaderViewWithImage:[UIImage imageNamed:@"home_shop_detail_mark"] andTitle:@"店主推荐"];
        return headerView;
    }
    else if (section == 2){
        UIView *headerView = [[UIView alloc] init];
        headerView.backgroundColor = kViewBgGrayColor;
        headerView.height = headerCommentH;
        
        YYShopDetailCommentTitleView *view = [[YYShopDetailCommentTitleView alloc] initWithTitleH:14 andMargin:k12HeightMargin];
        view.frame = CGRectMake(0, k12HeightMargin, kWidthScreen, headerCommentH - k12HeightMargin);
        [headerView addSubview:view];
        view.commentNumberLabel.text = self.commentConent;
        [view setYYCommentWriteBlock:^{
            if (self.YYWriteCommentBlock) {
                self.YYWriteCommentBlock();
            }
        }];
        
        return headerView;
    }
    if (section == 3) {
        UIView *headerView = [self createHeaderViewWithImage:[UIImage imageNamed:@"home_shop_detail_like"] andTitle:@"猜你喜欢"];
        return headerView;
    }
    
    return nil;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == 2) {
        UIView *footerView = [[UIView alloc] init];
        footerView.height = 38;
        footerView.backgroundColor = [UIColor whiteColor];
        if (self.commentConent) {
            UIButton *seeAllBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, kWidthScreen, 38)];
            [footerView addSubview:seeAllBtn];
            [seeAllBtn setTitle:@"查看全部留言" forState:UIControlStateNormal];
            [seeAllBtn setTitleColor:kGray99TextColor forState:UIControlStateNormal];
            seeAllBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
            
            [seeAllBtn bk_addEventHandler:^(id sender) {
                if (self.YYSeeAllCommentblock) {
                    self.YYSeeAllCommentblock();
                }
            } forControlEvents:UIControlEventTouchUpInside];
        }
        else{
            UILabel *noCommentLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kWidthScreen, 38)];
            [footerView addSubview:noCommentLabel];
            noCommentLabel.text = @"暂无留言";
            noCommentLabel.textColor = kGrayTextColor;
            noCommentLabel.font = [UIFont systemFontOfSize:15.0];
            noCommentLabel.textAlignment = NSTextAlignmentCenter;
            [footerView addSubview:noCommentLabel];
        }
        
        return footerView;
    }
    
    return nil;
}
- (UIView *)createHeaderViewWithImage:(UIImage *)titleImage andTitle:(NSString *)title{
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
    likeImageView.image = titleImage;
    [centerView addSubview:likeImageView];
    //在中间的View上增加title
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(iconW + k12WidthMargin, 0, titleW, 18)];
    [centerView addSubview:label];
    label.text = title;
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
/**
 *  计算评论的高度
 */
- (CGFloat)calculateSection2WithCommentModel:(YYShopCommentModel *)commentModel{
    
    CGFloat commentLabelW = kWidthScreen - 12 * 2;
    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
    attr[NSFontAttributeName] = [UIFont systemFontOfSize:13.0];
    
    CGFloat commentLabelH = [commentModel.medetails boundingRectWithSize:CGSizeMake(commentLabelW, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:attr context:nil].size.height;
    
    NSString *str = nil;
    if (![commentModel.codetails isEqual:[NSNull null]]) {
        str = [NSString stringWithFormat:@"卖家回复：%@", commentModel.codetails];
    }
    CGFloat replayLabelH = [str boundingRectWithSize:CGSizeMake(commentLabelW, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:attr context:nil].size.height;
    
    CGFloat iconImageViewH = 40;
    
    if (![commentModel.codetails isEqual:[NSNull null]]) {
        return 12 + iconImageViewH + 12 + commentLabelH + 12 + replayLabelH + 12;
    }
    return 12 + iconImageViewH + 12 + commentLabelH + 12;
    
}
@end
