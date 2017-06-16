//
//  YYShopDetailTableViewDataSource.m
//  lcjfarm
//
//  Created by wyy on 16/7/1.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import "YYShopDetailTableViewDataSource.h"
#import "YYShopIntroTableViewCell.h"
#import "YYFruitShopModel.h"
#import "YYLikeShopTableViewCell.h"

#import "YYShopDetailMarkTableViewCell.h"

#import "YYMarkModel.h"
#import "YYShopCommentModel.h"
#import "YYShopCommentTableViewCell.h"

@interface YYShopDetailTableViewDataSource (){
    YYFruitShopModel *_model;
    
}

@end

@implementation YYShopDetailTableViewDataSource
- (instancetype)initWithFruitShopModel:(YYFruitShopModel *)model{
    if (self = [super init]) {
        _model = model;
    }
    return self;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 2) {
        return self.commentsArray.count < 2 ? self.commentsArray.count : 2;
    }
    else if (section == 3) {
        return self.modelsArray.count;
    }
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        YYShopIntroTableViewCell *cell = [YYShopIntroTableViewCell shopIntroTableViewCellWithTableView:tableView];
        
        cell.model = _model;
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return cell;
    }
    else if (indexPath.section == 1){
        YYShopDetailMarkTableViewCell *cell = [YYShopDetailMarkTableViewCell shopDetailMarkTableViewCellWithTableView:tableView];
   
        [cell setYYSeeAllMarkBlock:^{
            if (self.YYSeeAllMarkBlock) {
                self.YYSeeAllMarkBlock();
            }
        }];
        
     
        cell.marksArray = self.marksArray;
        
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
         
        return cell;
    }
    else if (indexPath.section == 2){
        YYShopCommentTableViewCell *cell = [YYShopCommentTableViewCell shopCommentTableViewCellWithtableView:tableView];
        YYShopCommentModel *model = self.commentsArray[indexPath.row];
        cell.model = model;
        
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        return cell;
    }
    YYLikeShopTableViewCell *cell = [YYLikeShopTableViewCell likeShopTableViewCellWithTableView:tableView];
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    YYFruitShopModel *model = self.modelsArray[indexPath.row];
    
    cell.shopModel = model;
    return cell;
    
}
@end
