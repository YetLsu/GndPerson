//
//  YYUserModel1.m
//  lcjfarm
//
//  Created by wyy on 16/6/24.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import "YYUserModel.h"

@implementation YYUserModel

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        self.userCity = [aDecoder decodeObjectForKey:kUserCity];
        self.userID = [aDecoder decodeObjectForKey:kUserID];
        self.userid = [aDecoder decodeObjectForKey:kUserid];
        self.name = [aDecoder decodeObjectForKey:kUserName];
        self.headimgurl = [aDecoder decodeObjectForKey:kUserHeadImgUrl];
        self.phone = [aDecoder decodeObjectForKey:kUserPhone];
        self.email = [aDecoder decodeObjectForKey:kUserEmail];
        self.lon = [aDecoder decodeObjectForKey:kUserLon];
        self.lat = [aDecoder decodeObjectForKey:kUserLat];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.userCity forKey:kUserCity];
    [aCoder encodeObject:self.userID forKey:kUserID];
    [aCoder encodeObject:self.userid forKey:kUserid];
    [aCoder encodeObject:self.name forKey:kUserName];
    [aCoder encodeObject:self.headimgurl forKey:kUserHeadImgUrl];
    [aCoder encodeObject:self.phone forKey:kUserPhone];
    [aCoder encodeObject:self.email forKey:kUserEmail];
    [aCoder encodeObject:self.lon forKey:kUserLon];
    [aCoder encodeObject:self.lat forKey:kUserLat];
}
@end
