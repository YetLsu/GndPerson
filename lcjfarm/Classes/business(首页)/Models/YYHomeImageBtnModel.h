//
//  YYHomeImageBtnModel.h
//  lcjfarm
//
//  Created by wyy on 16/6/27.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YYHomeImageBtnModel : NSObject

@property (nonatomic, copy) NSString *imageUrlStr;

- (instancetype) initWithImageUrl:(NSString *)imageUrl;
@end
