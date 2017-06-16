//
//  YYShopCommentModel.h
//  lcjfarm
//
//  Created by wyy on 16/9/13.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YYShopCommentModel : NSObject
/**
 *  客户端用户名
 */
@property (nonatomic, copy) NSString *username;
/**
 *  客户端留言
 */
@property (nonatomic, copy) NSString *medetails;
/**
 *  客户端留言时间
 */
@property (nonatomic, copy) NSString *metime;
/**
 *  商家评论
 */
@property (nonatomic, copy) NSString *codetails;

@end
