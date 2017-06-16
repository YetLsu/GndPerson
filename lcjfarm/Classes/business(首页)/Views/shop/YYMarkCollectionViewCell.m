//
//  YYMarkCollectionViewCell.m
//  lcjfarm
//
//  Created by wyy on 16/9/13.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import "YYMarkCollectionViewCell.h"

#import "YYMarkModel.h"


@interface YYMarkCollectionViewCell ()

@property (nonatomic, weak) UIImageView *markImageView;


@property (nonatomic, weak) UILabel *markNameLabel;
@end

@implementation YYMarkCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        //增加图片
        CGFloat itemW = (kWidthScreen - k12WidthMargin * 6)/5.0;
        
        UIImageView *markImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:markImageView];
        self.markImageView = markImageView;
        [self.markImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.mas_equalTo(self.contentView);
            make.height.mas_equalTo(itemW);
        }];
        self.markImageView.layer.cornerRadius = 3;
        self.markImageView.layer.masksToBounds = YES;
        
        //增加Label
        UILabel *markLabel = [[UILabel alloc] init];
        [self.contentView addSubview:markLabel];
        self.markNameLabel = markLabel;
        [self.markNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(self.contentView);
            make.top.mas_equalTo(self.markImageView.mas_bottom);
            
        }];
        self.markNameLabel.font = [UIFont systemFontOfSize:13.0];
        self.markNameLabel.textColor = kBlackTextColor;
        self.markNameLabel.textAlignment = NSTextAlignmentCenter;
        self.markNameLabel.adjustsFontSizeToFitWidth = YES;
    }
    return self;
}

- (void)setModel:(YYMarkModel *)model{
    _model = model;
    [self.markImageView sd_setImageWithURL:[NSURL URLWithString:model.imgurl]];
    
    self.markNameLabel.text = model.fruitname;
}
@end
