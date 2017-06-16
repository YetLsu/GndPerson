//
//  YYPickIntroThreeCell.m
//  lcjfarm
//
//  Created by wyy on 16/7/6.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import "YYPickIntroThreeCell.h"
#import "YYPickIntroModel.h"

@interface YYPickIntroThreeCell ()
/**
 *  图标
 */
@property (nonatomic, weak) UIImageView *iconImageView;
/**
 *  标题
 */
@property (nonatomic, weak) UILabel *titleLabel;
/**
 *  介绍
 */
@property (nonatomic, weak) UILabel *contentLabel;
/**
 *  分割线
 */
@property (nonatomic, weak) UIView *lineView;

@end

@implementation YYPickIntroThreeCell
+ (instancetype)pickIntroThreeCellWithTableView:(UITableView *)tableView{
    static NSString *identifier = @"YYPickIntroThreeCell";
    YYPickIntroThreeCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[YYPickIntroThreeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //添加子控件
        [self addSubViews];
        
        //设置约束
        [self setConstraints];
    }
    return self;
}
#pragma mark 添加子控件
/**
 *  添加子控件
 */
- (void)addSubViews{
    [self.contentView removeConstraints:[self.contentView constraints]];
    //图标
    UIImageView *iconImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:iconImageView];
    self.iconImageView = iconImageView;
    self.iconImageView.contentMode = UIViewContentModeRight;
    //标题
    UILabel *titleLabel = [[UILabel alloc] init];
    [self.contentView addSubview:titleLabel];
    self.titleLabel = titleLabel;
    self.titleLabel.textColor = kBlackTextColor;
    self.titleLabel.font = [UIFont systemFontOfSize:18.0];
    self.titleLabel.textColor = kBlackTextColor;
    
    //介绍
    UILabel *contentLabel = [[UILabel alloc] init];
    [self.contentView addSubview:contentLabel];
    self.contentLabel = contentLabel;
    self.contentLabel.textColor = kBlackTextColor;
    UIFont *labelFont = [UIFont systemFontOfSize:15];
    self.contentLabel.font = labelFont;
    self.contentLabel.numberOfLines = 0;
    //分割线
    UIView *lineView = [[UIView alloc] init];
    [self.contentView addSubview:lineView];
    self.lineView = lineView;
    self.lineView.backgroundColor = kGrayLineColor;
    
    
}
#pragma mark 设置约束
/**
 *  设置约束
 */
- (void)setConstraints{
    CGFloat titleW = 75;
    CGFloat iconW = 27;
    CGFloat iconH = 18;
    CGFloat allW = titleW + iconW + k12WidthMargin;
    CGFloat iconX = (kWidthScreen - allW)/2.0;
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(iconW, iconH));
        make.top.mas_equalTo(self.contentView).mas_offset(k12HeightMargin);
        make.left.mas_equalTo(iconX);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.iconImageView.mas_right).mas_offset(k12WidthMargin);
        make.size.mas_equalTo(CGSizeMake(titleW, iconH));
        make.top.mas_equalTo(self.iconImageView);
    }];
    
}
- (void)setModel:(YYPickIntroModel *)model{
    _model = model;
   
    self.iconImageView.image =  model.icon;
    self.titleLabel.text = model.title;
   
    //设置介绍的约束
    self.contentLabel.attributedText = model.content;
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).mas_offset(12);
        make.right.mas_equalTo(self.contentView).mas_offset(-12);
        make.top.mas_equalTo(self.titleLabel.mas_bottom).mas_offset(8);
        make.height.mas_equalTo(model.contentH + 2);
    }];
    
    //设置分割线的约束
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.contentLabel);
        make.bottom.mas_equalTo(self.contentView.mas_bottom);
        if ([model.title isEqualToString:@"适宜人群"]) {
            make.height.mas_equalTo(0);
        }
        else{
            make.height.mas_equalTo(0.5);
        }
        
    }];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
