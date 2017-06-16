//
//  YYShopDetailCommentTitleView.m
//  lcjfarm
//
//  Created by wyy on 16/9/13.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import "YYShopDetailCommentTitleView.h"

@implementation YYShopDetailCommentTitleView

- (instancetype)initWithTitleH:(CGFloat)titleH andMargin:(CGFloat)margin{
    if (self = [super initWithFrame:CGRectZero]) {
        self.backgroundColor = [UIColor whiteColor];
        //增加店铺留言的Label
        UILabel *commentLabel = [[UILabel alloc] init];
        [self addSubview:commentLabel];
        commentLabel.text = @"店铺留言";
        commentLabel.textColor = kBlackTextColor;
        commentLabel.font = [UIFont systemFontOfSize:13.0];
        [commentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).mas_offset(12);
            make.top.mas_equalTo(self).mas_offset(margin);
            make.height.mas_equalTo(titleH);
            make.width.mas_equalTo(55);
        }];
        
        //增加留言条数Label
        UILabel *commentNumberLabel = [[UILabel alloc] init];
        [self addSubview:commentNumberLabel];
        self.commentNumberLabel = commentNumberLabel;
        self.commentNumberLabel.textColor = kGray99TextColor;
        self.commentNumberLabel.font = [UIFont systemFontOfSize:14.0];
        [self.commentNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(commentLabel.mas_right).mas_offset(8);
            make.width.mas_equalTo(100);
            make.height.mas_equalTo(titleH);
            make.top.mas_equalTo(commentLabel);
        }];
        
        //增加写留言按钮
        UIButton *btn = [[UIButton alloc] init];
        [self addSubview:btn];
        btn.titleLabel.textAlignment = NSTextAlignmentRight;
        [btn setTitle:@"写留言" forState:UIControlStateNormal];
        [btn setTitleColor:kRGBAColor(34, 194, 106, 1) forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14.0];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self).mas_offset(12);
            make.top.mas_equalTo(self);
            make.bottom.mas_equalTo(self).mas_offset(-0.5);
            make.width.mas_equalTo(100);
        }];
        [btn bk_addEventHandler:^(id sender) {
            if (self.YYCommentWriteBlock) {
                self.YYCommentWriteBlock();
            }
        } forControlEvents:UIControlEventTouchUpInside];
        
        //增加下面的线
        UIView *lineView = [[UIView alloc] init];
        lineView.backgroundColor = kGrayLineColor;
        [self addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(self);
            make.height.mas_equalTo(0.5);
        }];
    }
    return self;
}
@end
