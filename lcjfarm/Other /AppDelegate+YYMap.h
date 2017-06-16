//
//  AppDelegate+YYMap.h
//  lcjfarm
//
//  Created by wyy on 16/6/23.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import "AppDelegate.h"
#import <CoreLocation/CoreLocation.h>


@interface AppDelegate (YYMap)<CLLocationManagerDelegate>
- (void)mapApplication:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions;
@end
