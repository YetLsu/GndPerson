//
//  YYProFileHeaderView.h
//  lcjfarm
//
//  Created by wyy on 16/7/13.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YYProfileHeaderView : UIView
/**
 *  用户名称Label
 */
@property (nonatomic, weak) UILabel *nameLabel;
/**
 *  注册登陆按钮
 */
@property (nonatomic, weak) UIButton *loginBtn;
/**
 *  右侧的退出按钮
 */
@property (nonatomic, weak) UIButton *logoutBtn;
+ (instancetype)profileHeaderView;
@end
