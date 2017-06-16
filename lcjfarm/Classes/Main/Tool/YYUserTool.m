//
//  YYUserTool.m
//  lcjfarm
//
//  Created by wyy on 16/6/23.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import "YYUserTool.h"
#import "YYUserModel.h"
#define kUserSavePath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"userMessage.plist"]

@implementation YYUserTool

/**
 *  获取用户模型
 */
+ (YYUserModel *)userModel{
//    YYLog(@"%@",kUserSavePath);
    return [NSKeyedUnarchiver unarchiveObjectWithFile:kUserSavePath];
    
}
/**
 *  保存用户模型
 */
+ (void)saveUserModel:(YYUserModel *)userModel{
    [NSKeyedArchiver archiveRootObject:userModel toFile:kUserSavePath];
}
/**
 *  删除用户模型
 */
+ (void)removeuserModel{
    YYUserModel *model = [[YYUserModel alloc] init];
    [NSKeyedArchiver archiveRootObject:model toFile:kUserSavePath];
}

@end
