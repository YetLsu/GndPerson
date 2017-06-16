//
//  YYTabBarController.m
//  lcjfarm
//
//  Created by wyy on 16/6/20.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import "YYTabBarController.h"
#import "YYHomeViewController.h"
#import "YYDiscoverViewController.h"
#import "YYProfileViewController.h"
#import "YYNavigationController.h"

@interface YYTabBarController ()

@end

@implementation YYTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    YYHomeViewController *home = [[YYHomeViewController alloc] init];
    [UIImage imageNamed:@"tabbar_home_nor"];
    [self addChildControllerWithChildController:home image:[UIImage imageNamed:@"tabbar_home_nor"] selectImage:[UIImage imageNamed:@"tabbar_home_sel"] title:@"首页"];
   
    YYDiscoverViewController *discover = [[YYDiscoverViewController alloc] initWithStyle:UITableViewStyleGrouped];
    [self addChildControllerWithChildController:discover image:[UIImage imageNamed:@"tabbar_friend_nor"] selectImage:[UIImage imageNamed:@"tabbar_friend_sel"] title:@"发现"];
    
    YYProfileViewController *profile = [[YYProfileViewController alloc] init];
    [self addChildControllerWithChildController:profile image:[UIImage imageNamed:@"tabbar_profile_nor"] selectImage:[UIImage imageNamed:@"tabbar_profile_sel"] title:@"我的"];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addChildControllerWithChildController:(UIViewController *)vc image:(UIImage *)image selectImage:(UIImage *)selImage title:(NSString *)title{
    YYLog(@"%@",title);
    vc.tabBarItem.image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc.tabBarItem.selectedImage = [selImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    vc.title = title;
    
    NSMutableDictionary *attrHigh = [NSMutableDictionary dictionary];
    attrHigh[NSForegroundColorAttributeName] = kNavColor;
    [vc.tabBarItem setTitleTextAttributes:attrHigh forState:UIControlStateSelected];
    
    NSMutableDictionary *attrNor = [NSMutableDictionary dictionary];
    attrNor[NSForegroundColorAttributeName] = kRGBAColor(170, 170, 170, 1);
    
    [vc.tabBarItem setTitleTextAttributes:attrNor forState:UIControlStateNormal];
    
    
    
    YYNavigationController *nav = [[YYNavigationController alloc] initWithRootViewController:vc];
    
    
    [self addChildViewController:nav];
    
}


@end
