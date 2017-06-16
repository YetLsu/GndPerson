//
//  YYShopDetailCommentTitleView.h
//  lcjfarm
//
//  Created by wyy on 16/9/13.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YYShopDetailCommentTitleView : UIView

@property (nonatomic, copy) void (^YYCommentWriteBlock)();

@property (nonatomic, weak) UILabel *commentNumberLabel;

- (instancetype)initWithTitleH:(CGFloat)titleH andMargin:(CGFloat)margin;

@end
