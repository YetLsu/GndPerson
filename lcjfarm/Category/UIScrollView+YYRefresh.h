//
//  UIScrollView+YYRefresh.h
//  lcjfarm
//
//  Created by wyy on 16/6/29.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MJRefresh.h>

@interface UIScrollView (YYRefresh)
@property (nonatomic, strong) MJRefreshNormalHeader *header;

@property (nonatomic, strong) MJRefreshAutoNormalFooter *footer;
/**
 *  添加header刷新
 */
- (void)addHeaderRefresh:(MJRefreshComponentRefreshingBlock) refreshBlock;
/**
 *  开始header刷新
 */
- (void)beginHeaderRefresh;
/**
 *  结束header刷新
 */
- (void)endHeaderRefresh;

/**
 *  添加footer刷新
 */
- (void)addFooterRefresh:(MJRefreshComponentRefreshingBlock) refreshBlock;
/**
 *  结束footer刷新
 */
- (void)endFooterRefresh;
/**
 *  设置没有更多数据
 */
- (void)setNoMoreData;
/**
 *  重置尾部刷新
 */
- (void)resetFooter;
@end
