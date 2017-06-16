//
//  YYSeasonFruitMessageBasicView.m
//  lcjfarm
//
//  Created by wyy on 16/8/11.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import "YYSeasonFruitMessageBasicView.h"


@interface YYSeasonFruitMessageBasicView ()
@property (nonatomic, copy) NSString *topTitle;

@property (nonatomic, copy) NSString *bottomTitle;


@property (nonatomic, weak)UILabel *centerLabel;

@end

@implementation YYSeasonFruitMessageBasicView
- (instancetype)initWithFrame:(CGRect)frame topTitle:(NSString *)topTitle centerTitle:(NSString *)centerTitle bottomTitle:(NSString *)bottomTitle{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = kRGBAColor(177, 217, 99, 1);
        self.layer.cornerRadius = 5;
        self.layer.masksToBounds = YES;
        
        self.topTitle = topTitle;
        self.centerTitle = centerTitle;
        self.bottomTitle = bottomTitle;
        //添加子控件
        [self addsubViews];
    }
    return self;
}

- (void)addsubViews{
    //增加上面的Label
    UILabel *topLabel = [[UILabel alloc] init];
    [self addSubview:topLabel];
    
    CGFloat topLabelH = 12;
    CGFloat topLabelX = 6;
    CGFloat labelW = self.width - topLabelX * 2;
    [topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(topLabelX);
        make.top.mas_equalTo(self.mas_top).mas_offset(6);
        make.size.mas_equalTo(CGSizeMake(labelW, topLabelH));
    }];
    topLabel.textColor = [UIColor whiteColor];
    topLabel.font = [UIFont systemFontOfSize:12.0];
    topLabel.text = self.topTitle;
    
    //增加下面的Label
    UILabel *bottomLabel = [[UILabel alloc] init];
    [self addSubview:bottomLabel];
    
    CGFloat bottomLabelH = 10;
    [bottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).mas_offset(-6);
        make.bottom.mas_equalTo(self.mas_bottom).mas_offset(-6);
        make.size.mas_equalTo(CGSizeMake(labelW, bottomLabelH));
    }];
    bottomLabel.textColor = [UIColor whiteColor];
    bottomLabel.font = [UIFont systemFontOfSize:10.0];
    bottomLabel.text = self.bottomTitle;
    bottomLabel.textAlignment = NSTextAlignmentRight;

    ////增加中间的Label
    UILabel *centerLabel = [[UILabel alloc] init];
    [self addSubview:centerLabel];
    self.centerLabel = centerLabel;
    
    CGFloat centerLabelX = 6;
    [centerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(centerLabelX);
        make.top.mas_equalTo(topLabel.mas_bottom);
        make.bottom.mas_equalTo(bottomLabel.mas_top);
        make.width.mas_equalTo(labelW);
    }];
    centerLabel.textColor = [UIColor whiteColor];
    centerLabel.font = [UIFont systemFontOfSize:18.0];
    centerLabel.text = self.centerTitle;
    centerLabel.textAlignment = NSTextAlignmentCenter;
    
}
- (void)setCenterTitle:(NSString *)centerTitle{
    _centerTitle = centerTitle;
    
    self.centerLabel.text = centerTitle;
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
