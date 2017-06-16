//
//  YYUserTool.h
//  lcjfarm
//
//  Created by wyy on 16/6/23.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YYUserModel.h"

@interface YYUserTool : NSObject
/**
 *  获取用户模型
 */
+ (YYUserModel *)userModel;
/**
 *  保存用户模型
 */
+ (void)saveUserModel:(YYUserModel *)userModel;
/**
 *  删除用户模型
 */
+ (void)removeuserModel;

@end
