//
//  YYLcjFarmDefine.h
//  lcjfarm
//
//  Created by wyy on 16/6/20.
//  Copyright © 2016年 WYY. All rights reserved.
//

#ifndef YYLcjFarmDefine_h
#define YYLcjFarmDefine_h

//#define kSMSSDKAppKey @"10cc9fbeeff48"
//#define kSMSSDKAPPSecret @"4d3868d340e468d206802696dfcc525f"
#define kSMSSDKAppKey @"16e331891b553"
#define kSMSSDKAPPSecret @"78bb92cf4323039e37c02326b6aca3a3"

#define kWidthScreen [UIScreen mainScreen].bounds.size.width
#define kHeightScreen [UIScreen mainScreen].bounds.size.height
#define kNoNavHeight (kHeightScreen - 64)



#define kViewBgGrayColor [UIColor colorWithRed:245/255.0 green:244/255.0 blue:249/255.0 alpha:1.0]
/**
 *  99cd32
 */

#define kRGBAColor(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define kNavColor kRGBAColor(153, 205, 50, 1)
#define kGrayTextColor kRGBAColor(186, 186, 186, 1)
#define kGray99TextColor kRGBAColor(153, 153, 153, 1)
#define kBlackTextColor kRGBAColor(56, 56, 56, 1)
#define kGrayLineColor kRGBAColor(209, 209, 209, 1)
#define kGreen

#define k12WidthMargin 12.0/375*kWidthScreen
#define k12HeightMargin 12.0/603*kNoNavHeight


#define kNotificationGetAddress @"kNotificationGetAddress"
#define kNotificationHomeBtnsClick @"kNotificationHomeBtnsClick"
#define kNotificationShopCellClick @"kNotificationShopCellClick"
#define kNotificationImageCellClick @"kNotificationImageCellClick"
#define kNotificationPickCellClick @"kNotificationPickCellClick"
#define kNotificationFruitNewCellClick @"kNotificationFruitNewCellClick"
//登录注册按钮点击
#define kNotificationLoginBtnClick @"kNotificationLoginBtnClick"
//收藏商铺按钮被点击
#define kNotificationFruitCollectBtnClick @"kNotificationFruitCollectBtnClick"
//收藏采摘被点击
#define kNotificationPickCollectBtnClick @"kNotificationPickCollectBtnClick"
//点击商铺详情里面的按钮被点击
#define kNotificationPhoneShopBtnClick @"kNotificationPhoneShopBtnClick"
//点击商铺详情里面的导航被点击
#define kNotificationNavigationShopBtnClick @"kNotificationNavigationShopBtnClick"
//点击农场详情里面的按钮被点击
#define kNotificationPhoneFarmBtnClick @"kNotificationPhoneFarmBtnClick"
//点击农场详情里面的导航被点击
#define kNotificationNavigationFarmBtnClick @"kNotificationNavigationFarmBtnClick"
//地图里的地图导航被点击
#define kNotificationNavigationMapClick @"kNotificationNavigationMapClick"
//我的里的退出按钮被点击
#define kNotificationLogoutBtnClick @"kNotificationLogoutBtnClick"

//地址
#define kAddressKey @"kAddressKey"

#ifdef DEBUG

#define YYLog(...) NSLog(@"%s\n %@\n\n",__func__,[NSString stringWithFormat:__VA_ARGS__])
#else

#define YYLog(...)

#endif


#endif /* YYLcjFarmDefine_h */
