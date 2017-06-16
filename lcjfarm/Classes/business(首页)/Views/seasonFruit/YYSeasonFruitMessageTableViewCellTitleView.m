//
//  YYSeasonFruitMessageTableViewCellTitleView.m
//  lcjfarm
//
//  Created by wyy on 16/8/11.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import "YYSeasonFruitMessageTableViewCellTitleView.h"

@interface YYSeasonFruitMessageTableViewCellTitleView ()
/**
 *  标题
 */
@property (nonatomic, copy) NSString *title;

@end

@implementation YYSeasonFruitMessageTableViewCellTitleView
- (instancetype)initWithTitle:(NSString *)title andFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.title = title;
        //添加子控件
        [self addsubViews];

    }
    return self;
}
#pragma 添加子控件
/**
 *  添加子控件
 */
- (void)addsubViews{
    //增加中间的Label
    UILabel *centerLabel = [[UILabel alloc] init];
    [self addSubview:centerLabel];
    CGFloat centerLabelH = 18;
    
    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
    attr[NSFontAttributeName] = [UIFont systemFontOfSize:17.0];
    
    CGFloat centerLabelW = [self.title boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, centerLabelH) options:NSStringDrawingUsesLineFragmentOrigin attributes:attr context:nil].size.width;
    
    CGFloat centerLabelX = (self.width - centerLabelW)/2.0;
    [centerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(centerLabelW, centerLabelH));
        make.left.mas_equalTo(centerLabelX);
        make.top.mas_equalTo(0);
    }];
    
    centerLabel.text = self.title;
    centerLabel.textColor = kNavColor;
    centerLabel.font = [UIFont systemFontOfSize:16.0];
    centerLabel.textAlignment = NSTextAlignmentCenter;
    
    //增加左边的线条
    UIView *leftLineView = [[UIView alloc] init];
    [self addSubview:leftLineView];
    leftLineView.backgroundColor = kNavColor;
    
    CGFloat leftLineViewY = (self.height - 0.5)/2.0;
    [leftLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(24, 0.5));
        make.right.mas_equalTo(centerLabel.mas_left).mas_offset(-12);
        make.top.mas_equalTo(leftLineViewY);
    }];
    
    //增加右边的线条
    UIView *rightLineView = [[UIView alloc] init];
    [self addSubview:rightLineView];
    rightLineView.backgroundColor = kNavColor;
    
    [rightLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(24, 0.5));
        make.left.mas_equalTo(centerLabel.mas_right).mas_offset(12);
        make.top.mas_equalTo(leftLineViewY);
    }];

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
