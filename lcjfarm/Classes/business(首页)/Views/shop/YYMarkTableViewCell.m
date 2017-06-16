//
//  YYMarkTableViewCell.m
//  q
//
//  Created by wyy on 16/9/8.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import "YYMarkTableViewCell.h"
#import "YYMarkModel.h"

@interface YYMarkTableViewCell ()
/**
 *  水果图片
 */
@property (nonatomic, weak) UIImageView *iconImageView;
/**
 *  水果名称
 */
@property (nonatomic, weak) UILabel *fruitNameLabel;
/**
 *  线条
 */
@property (nonatomic, weak) UIView *lineView;
@end

@implementation YYMarkTableViewCell

+ (instancetype)markTableViewCellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"YYMarkTableViewCell";
    YYMarkTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[YYMarkTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //增加控件
        [self addSubviews];
        
        //增加约束
        [self addConstraints];
        
        //设置Views
        [self setViews];
    }
    return self;
}
/**
 *  增加控件
 */
- (void)addSubviews{
    //水果图片
    UIImageView *iconImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:iconImageView];
    self.iconImageView = iconImageView;
    
    //水果名称
    UILabel *fruitNameLabel = [[UILabel alloc] init];
    [self.contentView addSubview:fruitNameLabel];
    self.fruitNameLabel = fruitNameLabel;
    
    //线条
    UIView *lineView = [[UIView alloc] init];
    [self.contentView addSubview:lineView];
    self.lineView = lineView;
   
}

/**
 *  增加约束
 */
- (void)addConstraints{
    //水果图片
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).mas_offset(12);
        make.top.mas_equalTo(self.contentView).mas_offset(12);
        make.bottom.mas_equalTo(self.contentView).mas_offset(-12);
        make.width.mas_equalTo(40);
    }];
    
    //水果名称
    [self.fruitNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.iconImageView.mas_right).mas_offset(12);
        make.top.bottom.mas_equalTo(self.iconImageView);
        make.width.mas_equalTo(200);
    }];

    //线条
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.contentView);
        make.height.mas_equalTo(0.5);
    }];

}

/**
 *  设置Views
 */
- (void)setViews{
    self.iconImageView.layer.cornerRadius = 3;
    self.iconImageView.layer.masksToBounds = YES;
    
    self.fruitNameLabel.font = [UIFont systemFontOfSize:17.0];
    
    self.lineView.backgroundColor = kGrayLineColor;
    
    self.fruitNameLabel.textColor = kBlackTextColor;
}
- (void)setModel:(YYMarkModel *)model{
    _model = model;
    
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:model.imgurl]];
    
    self.fruitNameLabel.text = model.fruitname;

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
