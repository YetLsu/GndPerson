//
//  AppDelegate+YYMap.m
//  lcjfarm
//
//  Created by wyy on 16/6/23.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import "AppDelegate+YYMap.h"


CLGeocoder *_geocoder;
CLLocationManager *_manager;
@implementation AppDelegate (YYMap)
- (void)mapApplication:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    _manager = [[CLLocationManager alloc] init];
    _geocoder = [[CLGeocoder alloc] init];
    
    if ([_manager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [_manager requestWhenInUseAuthorization];
    }
    

}


@end
