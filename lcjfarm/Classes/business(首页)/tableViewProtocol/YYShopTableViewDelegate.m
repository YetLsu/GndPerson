//
//  YYShopTableViewDelegate.m
//  lcjfarm
//
//  Created by wyy on 16/6/29.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import "YYShopTableViewDelegate.h"

@interface YYShopTableViewDelegate (){
    NSIndexPath *_lastIndexPath;
    /**
     *  单元格上拉变换时的参数
     */
    CATransform3D _upInitialtransformation;
    /**
     *  单元格下拉变换时的参数
     */
    CATransform3D _downInitialtransformation;
}

@end

@implementation YYShopTableViewDelegate
- (instancetype)init{
    if (self = [super init]) {
        CATransform3D otherTransform = CATransform3DIdentity;
        otherTransform = CATransform3DTranslate(otherTransform, 0, 30, 0);
        _upInitialtransformation = otherTransform;
        
        CATransform3D downTransForm = CATransform3DIdentity;
        downTransForm = CATransform3DTranslate(otherTransform, 0, -50, 0);
        _downInitialtransformation = downTransForm;
    }
    return self;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.00001;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.00001;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 114;
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
/**
 *  单元格被点击
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.delegate respondsToSelector:@selector(tableViewDidSelectCellWithModel:)]) {
        YYFruitShopModel *model = self.modelsArray[indexPath.row];
        [self.delegate tableViewDidSelectCellWithModel:model];
    }
}

@end
