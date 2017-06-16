//
//  YYWriteCommentViewController.h
//  pugongying
//
//  Created by wyy on 16/3/14.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import <UIKit/UIKit.h>


@class YYFruitShopModel;
@interface YYWriteCommentViewController : UIViewController

@property (nonatomic, copy) void (^YYPostCommentSuccessBlock) ();
- (instancetype)initWithShopModel:(YYFruitShopModel *)model;

@end
