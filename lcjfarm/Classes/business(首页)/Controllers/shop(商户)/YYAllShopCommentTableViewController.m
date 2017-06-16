//
//  YYAllShopCommentTableViewController.m
//  lcjfarm
//
//  Created by wyy on 16/9/14.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import "YYAllShopCommentTableViewController.h"
#import "YYSeeAllViewModel.h"
#import "YYShopCommentModel.h"
#import "YYShopCommentTableViewCell.h"
#import "YYFruitShopModel.h"


@interface YYAllShopCommentTableViewController ()

@property (nonatomic, strong) YYSeeAllViewModel *viewModel;

@property (nonatomic, strong) NSMutableArray <YYShopCommentModel *>* modelsArray;

@property (nonatomic, assign) BOOL loadAll;

@property (nonatomic, assign) int index;

@property (nonatomic, strong) YYFruitShopModel *model;
@end

@implementation YYAllShopCommentTableViewController
- (YYSeeAllViewModel *)viewModel{
    if (!_viewModel) {
        _viewModel = [[YYSeeAllViewModel alloc] init];
    }
    return _viewModel;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}
- (instancetype)initWithCommentsArray:(NSMutableArray <YYShopCommentModel *>*) commentsArray  andShopModel:(YYFruitShopModel *)model{
    if (self = [super initWithStyle:UITableViewStyleGrouped]) {
        
        self.model = model;
        
        self.index = 0;
        self.title = @"留言";
        self.view.backgroundColor = [UIColor whiteColor];
        
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        self.modelsArray = commentsArray;
        
        if (self.modelsArray.count < 5) {
            self.loadAll = YES;
        }
        else{
            self.loadAll = NO;
        }
        //设置上拉下拉
        [self setHeaderAndFooter];
        if (self.loadAll == NO) {
            [self.tableView beginHeaderRefresh];
        }
        else{
            [self.tableView setNoMoreData];
        }
    }
    return self;
}
/**
 *  设置上拉下拉
 */
- (void)setHeaderAndFooter{
    
    __weak __typeof(&*self)weakSelf = self;
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"shopid"] = self.model.shopid;

    
    [self.tableView addHeaderRefresh:^{
        
        weakSelf.index = 0;
        
        parameters[@"index"] = [NSString stringWithFormat:@"%d", weakSelf.index * 10];
        
        [weakSelf.viewModel getCommentsWithParameters:parameters withCallBack:^(NSMutableArray<YYShopCommentModel *> *modelsArray, NSString *errorStr) {
            
            [weakSelf.tableView endHeaderRefresh];
            
            if ([errorStr isEqualToString:@"1"]) {
                return;
            }
            [weakSelf.modelsArray removeAllObjects];
            [weakSelf.modelsArray addObjectsFromArray:modelsArray];
            if (modelsArray.count<10) {
                [weakSelf.tableView setNoMoreData];
            }
            else{
                [weakSelf.tableView resetFooter];
            }
            
            weakSelf.modelsArray = weakSelf.modelsArray;
            [weakSelf.tableView reloadData];
            
        }];

    }];
    
    [self.tableView addFooterRefresh:^{
        weakSelf.index++;
        
        parameters[@"index"] = [NSString stringWithFormat:@"%d", weakSelf.index * 10];
        
        [weakSelf.viewModel getCommentsWithParameters:parameters withCallBack:^(NSMutableArray<YYShopCommentModel *> *modelsArray, NSString *errorStr) {
            
            [weakSelf.tableView endFooterRefresh];
            
            if ([errorStr isEqualToString:@"1"]) {
                return;
            }
            if (modelsArray.count < 10) {
                [weakSelf.tableView setNoMoreData];
            }
          
            [weakSelf.modelsArray addObjectsFromArray:modelsArray];
            
            weakSelf.modelsArray = weakSelf.modelsArray;
            [weakSelf.tableView reloadData];
        }];
        
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.modelsArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YYShopCommentTableViewCell *cell = [YYShopCommentTableViewCell shopCommentTableViewCellWithtableView:tableView];
    YYShopCommentModel *model = self.modelsArray[indexPath.row];
    cell.model = model;
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    YYShopCommentModel *model = self.modelsArray[indexPath.row];
    //计算评论的高度
    return [self calculateSection2WithCommentModel:model];;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.00001;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.00001;
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
