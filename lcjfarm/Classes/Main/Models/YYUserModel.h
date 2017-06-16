//
//  YYUserModel1.h
//  lcjfarm
//
//  Created by wyy on 16/6/24.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kUserCity @"kUserCity"
#define kUserID @"userID"
#define kUserid @"userid"
#define kUserName @"userName"
#define kUserHeadImgUrl @"userHeadImgUrl"
#define kUserPhone @"userPhone"
#define kUserEmail @"userEmail"
#define kUserLon @"kUserLon"
#define kUserLat @"kUserLat"


@interface YYUserModel : NSObject<NSCoding>
/**
 *  用户所在城市
 */
@property (nonatomic, copy) NSString *userCity;
/**
 *  用户ID
 */
@property (nonatomic, copy) NSString *userID;
/**
 *  32位编码
 */
@property (nonatomic, copy) NSString *userid;
/**
 *  用户名,手机号或邮箱
 */
@property (nonatomic, copy) NSString *name;
/**
 *  密码
 */
//@property (nonatomic, copy) NSString *passwor;
/**
 *  头像地址
 */
@property (nonatomic, copy) NSString *headimgurl;
/**
 *  手机号
 */
@property (nonatomic, copy) NSString *phone;
/**
 *  邮箱
 */
@property (nonatomic, copy) NSString *email;
/**
 *  所在城市经度
 */
@property (nonatomic, copy) NSString *lon;
/**
 *  所在城市纬度
 */
@property (nonatomic, copy) NSString *lat;
@end
