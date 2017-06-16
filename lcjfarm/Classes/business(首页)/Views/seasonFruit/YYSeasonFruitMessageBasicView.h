//
//  YYSeasonFruitMessageBasicView.h
//  lcjfarm
//
//  Created by wyy on 16/8/11.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YYSeasonFruitMessageBasicView : UIView
- (instancetype)initWithFrame:(CGRect)frame topTitle:(NSString *)topTitle centerTitle:(NSString *)centerTitle bottomTitle:(NSString *)bottomTitle;

@property (nonatomic, copy) NSString *centerTitle;
@end
