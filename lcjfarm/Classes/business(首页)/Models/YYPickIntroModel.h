//
//  YYPickIntroModel.h
//  lcjfarm
//
//  Created by wyy on 16/7/6.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YYPickIntroModel : NSObject
/**
 *  标题
 */
@property (nonatomic, copy) NSString *title;
/**
*  标题图片
*/
@property (nonatomic, strong) UIImage *icon;
/**
*  介绍内容
*/
@property (nonatomic, copy) NSMutableAttributedString *content;
/**
 *  文字的高度
 */
@property (nonatomic, assign) CGFloat contentH;

- (instancetype)initWithIcon:(UIImage *)icon andContent:(NSMutableAttributedString *)content andTitle:(NSString *)title;
@end
