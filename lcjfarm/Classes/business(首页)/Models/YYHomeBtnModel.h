//
//  YYHomeBtnModel.h
//  lcjfarm
//
//  Created by wyy on 16/6/27.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YYHomeBtnModel : NSObject

@property (nonatomic, copy) NSString *iconUrlStr;

@property (nonatomic, copy) NSString *btnTitle;

@property (nonatomic, copy) NSString *btnDetailText;

- (instancetype)initWithIconUrlStr:(NSString *)iconUrlStr btnTitle:(NSString *)btnTitle btnDetailText:(NSString *)btnDetailText;
@end
