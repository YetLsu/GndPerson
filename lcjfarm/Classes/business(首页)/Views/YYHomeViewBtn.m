//
//  YYHomeBtnView.m
//  lcjfarm
//
//  Created by wyy on 16/6/27.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import "YYHomeViewBtn.h"
#import "YYHomeBtnModel.h"

@interface YYHomeViewBtn ()
/**
 *  左边的图标
 */
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;


@property (weak, nonatomic) IBOutlet UILabel *btnTitleLabel;

@property (weak, nonatomic) IBOutlet UILabel *detailLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *iconXMarginConstraint;
/**
 *  头像的高度的约束
 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *iconHeightConstraint;
@end

@implementation YYHomeViewBtn


- (void)awakeFromNib{
    [super awakeFromNib];
    
    self.iconXMarginConstraint.constant = k12WidthMargin * 2;
    self.btnTitleLabel.textColor = kBlackTextColor;
    self.detailLabel.textColor = kGrayTextColor;
    self.iconImageView.layer.cornerRadius = self.iconHeightConstraint.constant/2.0;
    self.iconImageView.layer.masksToBounds = YES;
}

- (void)setModel:(YYHomeBtnModel *)model{
    _model = model;
    self.iconImageView.image = [UIImage imageNamed:model.iconUrlStr];
    self.btnTitleLabel.text = model.btnTitle;
    self.detailLabel.text = model.btnDetailText;
    
}
@end
