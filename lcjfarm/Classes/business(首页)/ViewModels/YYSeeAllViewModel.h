//
//  YYSeeAlViewModel.h
//  lcjfarm
//
//  Created by wyy on 16/9/14.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YYShopCommentModel;
typedef void(^callback)(NSMutableArray <YYShopCommentModel *>*modelsArray, NSString *errorStr);

@interface YYSeeAllViewModel : NSObject

- (void)getCommentsWithParameters:(NSMutableDictionary *)parameters withCallBack:(callback)callback;

@end
