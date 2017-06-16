//
//  UIScrollView+YYRefresh.m
//  lcjfarm
//
//  Created by wyy on 16/6/29.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import "UIScrollView+YYRefresh.h"

@implementation UIScrollView (YYRefresh)

/**
 *  添加header刷新
 */
- (void)addHeaderRefresh:(MJRefreshComponentRefreshingBlock) refreshBlock{
    self.header = [MJRefreshNormalHeader headerWithRefreshingBlock:refreshBlock];
        
    self.header.lastUpdatedTimeLabel.hidden = YES;
    self.header.stateLabel.hidden = YES;
    self.mj_header = self.header;
}
/**
 *  开始header刷新
 */
- (void)beginHeaderRefresh{
    [self.header beginRefreshing];
}
/**
 *  结束header刷新
 */
- (void)endHeaderRefresh{
    [self.header endRefreshing];
}
/**
 *  添加footer刷新
 */
- (void)addFooterRefresh:(MJRefreshComponentRefreshingBlock) refreshBlock{
    self.footer  = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:refreshBlock];
    
    [self.footer setTitle:@"没有更多数据" forState:MJRefreshStateNoMoreData];
    [self.footer setTitle:@"点击加载更多数据" forState:MJRefreshStateIdle];
    self.mj_footer = self.footer;
}
/**
 *  结束footer刷新
 */
- (void)endFooterRefresh{
    [self.footer endRefreshing];
}
/**
 *  设置没有更多数据
 */
- (void)setNoMoreData{
    [self.footer endRefreshingWithNoMoreData];
}
/**
 *  重置尾部刷新
 */
- (void)resetFooter{
    [self.footer resetNoMoreData];
}
@end
