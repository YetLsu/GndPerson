//
//  YYProFileHeaderView.m
//  lcjfarm
//
//  Created by wyy on 16/7/13.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import "YYProfileHeaderView.h"
#import "YYUserTool.h"

@interface YYProfileHeaderView ()

/**
 *  我的背景图片ImageView
 */
@property (nonatomic, weak) UIImageView *bgImageView;
/**
 *  用户头像ImageView
 */
@property (nonatomic, weak) UIImageView *userImageView;
/**
 *  店铺收藏按钮
 */
@property (nonatomic, weak) UIButton *shopCollectBtn;
/**
 *  农庄收藏按钮
 */
@property (nonatomic, weak) UIButton *pickCollectBtn;
/**
 *  分割线的View
 */
@property (nonatomic, weak) UIView *lineView;
@end

@implementation YYProfileHeaderView
+ (instancetype)profileHeaderView{
    YYProfileHeaderView *headerView = [[YYProfileHeaderView alloc] init];
    
    return headerView;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        //添加子控件到headerView上
        [self addSubViews];
        
        //给子控件设置约束
        [self setViewsConstraint];
        
        //根据是否有用户设置数据
        [self setProfileHeaderView];
    }
    return self;
}
#pragma mark 添加子控件到headerView上
/**
 *  添加子控件到headerView上
 */
- (void)addSubViews{
    //我的背景图片ImageView
    UIImageView *bgImageView = [[UIImageView alloc] init];
    [self addSubview:bgImageView];
    self.bgImageView = bgImageView;
    self.bgImageView.image = [UIImage imageNamed:@"profile_bg"];
    
    //用户名称Label
    UILabel *nameLabel = [[UILabel alloc] init];
    [self addSubview:nameLabel];
    self.nameLabel = nameLabel;
    self.nameLabel.textColor = [UIColor whiteColor];
    self.nameLabel.font = [UIFont systemFontOfSize:20.0];
    self.nameLabel.textAlignment = NSTextAlignmentCenter;
    
    //右侧的退出按钮
    UIButton *logoutBtn = [[UIButton alloc] init];
    [self addSubview:logoutBtn];
    self.logoutBtn = logoutBtn;
    [self.logoutBtn setTitle:@"退出" forState:UIControlStateNormal];
    [self.logoutBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.logoutBtn bk_addEventHandler:^(id sender) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationLogoutBtnClick object:self userInfo:nil];
    } forControlEvents:UIControlEventTouchUpInside];
    
    //注册登陆按钮
    UIButton *loginBtn = [[UIButton alloc] init];
    [self addSubview:loginBtn];
    self.loginBtn = loginBtn;
    [self.loginBtn setBackgroundImage:[UIImage imageNamed:@"profile_loginBtn_bg"] forState:UIControlStateNormal];
    [self.loginBtn setTitle:@"登录／注册" forState:UIControlStateNormal];
    [self.loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.loginBtn bk_addEventHandler:^(id sender) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationLoginBtnClick object:self userInfo:nil];
    } forControlEvents:UIControlEventTouchUpInside];
    
    //店铺收藏按钮
    UIButton *shopCollectBtn = [[UIButton alloc] init];
    [self addSubview:shopCollectBtn];
    self.shopCollectBtn = shopCollectBtn;
    [self.shopCollectBtn setTitle:@"店铺收藏" forState:UIControlStateNormal];
    [self.shopCollectBtn setTitleColor:kBlackTextColor forState:UIControlStateNormal];
    [self.shopCollectBtn bk_addEventHandler:^(id sender) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationFruitCollectBtnClick object:self userInfo:nil];
    } forControlEvents:UIControlEventTouchUpInside];
    
    //农庄收藏按钮
    UIButton *pickCollectBtn = [[UIButton alloc] init];
    [self addSubview:pickCollectBtn];
    self.pickCollectBtn = pickCollectBtn;
    [self.pickCollectBtn setTitle:@"农庄收藏" forState:UIControlStateNormal];
    [self.pickCollectBtn setTitleColor:kBlackTextColor forState:UIControlStateNormal];
    [self.pickCollectBtn bk_addEventHandler:^(id sender) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationPickCollectBtnClick object:self userInfo:nil];
    } forControlEvents:UIControlEventTouchUpInside];
    
    //分割线的View
    UIView *lineView = [[UIView alloc] init];
    [self addSubview:lineView];
    self.lineView = lineView;
    self.lineView.backgroundColor = kBlackTextColor;
    
    /**
     *  用户头像ImageView
     */
    UIImageView *userImageView = [[UIImageView alloc] init];
    [self addSubview:userImageView];
    self.userImageView = userImageView;
    self.userImageView.layer.cornerRadius = 40;
    self.userImageView.layer.masksToBounds = YES;
    
}
#pragma mark 给子控件设置约束
/**
 *  给子控件设置约束
 */
- (void)setViewsConstraint{
    //我的背景图片ImageView
    CGFloat bgImageViewH = 210/667.0 *kHeightScreen;
    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(bgImageViewH);
        make.left.right.top.mas_equalTo(self);
    }];
    //用户名称Label
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(300, 30));
        make.centerY.mas_equalTo(self.bgImageView);
        make.centerX.mas_equalTo(self.bgImageView);
    }];
    //右侧的退出按钮
    [self.logoutBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right);
        make.top.mas_equalTo(20);
        make.size.mas_equalTo(CGSizeMake(60, 44));
    }];
    
    //注册登陆按钮
    CGFloat loginBtnW = 119;
    CGFloat loginBtnH = 39;
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(loginBtnW, loginBtnH));
        make.centerY.mas_equalTo(self.bgImageView);
        make.centerX.mas_equalTo(self.bgImageView);
    }];
    //分割线的View
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.centerX);
        make.bottom.mas_equalTo(self.mas_bottom).mas_offset(-12);
        make.height.mas_equalTo(24);
        make.width.mas_equalTo(1);
    }];
    //店铺收藏按钮
    CGFloat shopCollectBtnW = 65 + 22 * 2;
    [self.shopCollectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.top.mas_equalTo(self.lineView);
        make.right.mas_equalTo(self.lineView.mas_left);
        make.width.mas_equalTo(shopCollectBtnW);
    }];
    //农庄收藏按钮
    [self.pickCollectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.lineView.mas_right);
        make.width.mas_equalTo(shopCollectBtnW);
        make.bottom.top.mas_equalTo(self.lineView);
    }];
    
    //用户头像ImageView
    [self.userImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.centerY.mas_equalTo(self.bgImageView.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(80, 80));
    }];
}
#pragma mark 根据是否有用户设置数据
/**
 *  根据是否有用户设置数据
 */
- (void)setProfileHeaderView{
    YYUserModel *userModel = [YYUserTool userModel];
    if (userModel.userid) {
        self.userImageView.image = [UIImage imageNamed:@"profile_icon_2"];
        self.nameLabel.hidden = NO;
        self.nameLabel.text = userModel.phone;
        self.loginBtn.hidden = YES;
    }
    else{
        self.userImageView.image = [UIImage imageNamed:@"profile_icon_noligin"];
        self.nameLabel.hidden = YES;
        self.loginBtn.hidden = NO;
    }
    
}
@end
