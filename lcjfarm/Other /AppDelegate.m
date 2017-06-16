//
//  AppDelegate.m
//  lcjfarm
//
//  Created by wyy on 16/6/20.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import "AppDelegate.h"
#import "AppDelegate+YYMap.h"

#import "YYTabBarController.h"
#import <SMS_SDK/SMSSDK.h>
#import "AFNetworking.h"

#import "UIImage+GIF.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    //向用户授权当使用该软件时使用定位
    [self mapApplication:application didFinishLaunchingWithOptions:launchOptions];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = [[YYTabBarController alloc] init];
    [self.window makeKeyAndVisible];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    //启动页停留时间
    [NSThread sleepForTimeInterval:1.0];
    //初始化应用，appKey和appSecret从后台申请得
    [SMSSDK registerApp:kSMSSDKAppKey
             withSecret:kSMSSDKAPPSecret];
   
    UIImageView *loadingImageView = [[UIImageView alloc] init];
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"welcome" ofType:@"gif"];
    NSData *gifImageData = [NSData dataWithContentsOfFile:filePath];
    
    loadingImageView.image = [UIImage sd_animatedGIFWithData:gifImageData];
    loadingImageView.frame = [UIScreen mainScreen].bounds;
    [self.window addSubview:loadingImageView];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.5 animations:^{
            loadingImageView.alpha = 0;
        } completion:^(BOOL finished) {
            [loadingImageView removeFromSuperview];
        }];
    });
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {

}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
 
}

@end
