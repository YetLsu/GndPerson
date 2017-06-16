//
//  YYDetailTableViewDelegate.h
//  lcjfarm
//
//  Created by wyy on 16/7/1.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  从userInfo中取出单元格的模型
 */
#define kShopCellModel @"kShopCellModel"

@class YYShopCommentModel;

@protocol YYDetailTableViewDelegateDelegate <NSObject>

- (void)tableViewScrollWithContentY:(CGFloat)contentY;

@end

@class YYFruitShopModel;
@interface YYDetailTableViewDelegate : NSObject <UITableViewDelegate>
/**
 *  查看全部留言被点击
 */
@property (nonatomic, copy) void (^YYSeeAllCommentblock)();
/**
 *  写留言被点击
 */
@property (nonatomic, copy) void (^YYWriteCommentBlock)();

@property (nonatomic, strong) NSMutableArray<YYFruitShopModel *> *modelsArray;

@property (nonatomic, weak)id<YYDetailTableViewDelegateDelegate> delegate;

@property (nonatomic, strong) NSArray *marksArray;

@property (nonatomic, strong) NSMutableArray <YYShopCommentModel *> *commentArray;
/**
 *  留言条数
 */
@property (nonatomic, copy) NSString *commentConent;
@end
