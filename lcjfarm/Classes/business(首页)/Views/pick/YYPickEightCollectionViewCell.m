//
//  YYPickEightCollectionViewCell.m
//  lcjfarm
//
//  Created by wyy on 16/8/9.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import "YYPickEightCollectionViewCell.h"

@interface YYPickEightCollectionViewCell ()

@property (nonatomic, weak) UIImageView *iconImageView;
@end

@implementation YYPickEightCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        UIImageView *imageView = [[UIImageView alloc] init];
        [self.contentView addSubview:imageView];
        self.iconImageView = imageView;
        imageView.frame = self.contentView.bounds;
    }
    return self;
}

- (void)setIconImage:(UIImage *)iconImage{
    _iconImage = iconImage;
    
    self.iconImageView.image = iconImage;
}
@end
