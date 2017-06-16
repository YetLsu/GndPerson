//
//  YYShopCommentTableViewCell.m
//  lcjfarm
//
//  Created by wyy on 16/9/13.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import "YYShopCommentTableViewCell.h"
#import "YYShopCommentModel.h"

#define labelFont [UIFont systemFontOfSize:13.0]

@interface YYShopCommentTableViewCell ()
/**
 *  用户头像
 */
@property (nonatomic, weak) UIImageView *iconImageView;
/**
 *  用户名称
 */
@property (nonatomic, weak) UILabel *nameLabel;
/**
 *  时间Label
 */
@property (nonatomic, weak) UILabel *timeLabel;
/**
 *  留言内容
 */
@property (nonatomic, weak) UILabel *commentLabel;
/**
 *  卖家回复label
 */
@property (nonatomic, weak) UILabel *replayLabel;
/**
 *  线
 */
@property (nonatomic, weak) UIView *lineView;
@end

@implementation YYShopCommentTableViewCell

+ (instancetype)shopCommentTableViewCellWithtableView:(UITableView *)tableView{
    static NSString *ID = @"YYShopCommentTableViewCell";
    YYShopCommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        cell = [[YYShopCommentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //添加子控件
        [self addSubViews];
        
        //增加约束
        [self addConstraints];
        
        //设置views
        [self setViews];
        
    }
    return self;
}
/**
 *  添加子控件
 */
- (void)addSubViews{
    //用户头像
    UIImageView *iconImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:iconImageView];
    self.iconImageView = iconImageView;
    
    //用户名称
    UILabel *nameLabel = [[UILabel alloc] init];
    [self.contentView addSubview:nameLabel];
    self.nameLabel = nameLabel;
    
    //时间Label
    UILabel *timeLabel = [[UILabel alloc] init];
    [self.contentView addSubview:timeLabel];
    self.timeLabel = timeLabel;
    
    //留言内容
    UILabel *commentLabel = [[UILabel alloc] init];
    [self.contentView addSubview:commentLabel];
    self.commentLabel = commentLabel;
    
    //卖家回复label
    UILabel *replayLabel = [[UILabel alloc] init];
    [self.contentView addSubview:replayLabel];
    self.replayLabel = replayLabel;
    
    //线
    UIView *lineView = [[UILabel alloc] init];
    [self.contentView addSubview:lineView];
    self.lineView = lineView;
}

/**
 *  增加约束
 */
- (void)addConstraints{
    
    CGFloat iconImageViewW = 40;
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(12);
        make.top.mas_equalTo(12);
        make.size.mas_equalTo(CGSizeMake(iconImageViewW, iconImageViewW));
    }];
    
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.iconImageView.mas_right).mas_offset(12);
        make.top.bottom.mas_equalTo(self.iconImageView);
        make.width.mas_equalTo(150);
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView).mas_offset(-12);
        make.width.mas_equalTo(90);
        make.height.mas_equalTo(25);
        make.top.mas_equalTo(self.iconImageView);
    }];
    //用户评论
    [self.commentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).mas_offset(12);
        make.top.mas_equalTo(self.iconImageView.mas_bottom).mas_offset(12);
        make.right.mas_equalTo(self.contentView).mas_offset(-12);
    }];
    
    //卖家回复
    [self.replayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.commentLabel);
        make.top.mas_equalTo(self.commentLabel.mas_bottom).mas_offset(12);
        make.right.mas_equalTo(self.contentView).mas_offset(-12);
    }];
    
    //线
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.contentView);
        make.height.mas_equalTo(0.5);
    }];
}

/**
 *  设置views
 */
- (void)setViews{
    
    CGFloat iconImageViewW = 40;
    self.iconImageView.layer.cornerRadius = iconImageViewW/2.0;
    self.iconImageView.layer.masksToBounds = YES;
    
    self.nameLabel.textColor = kGray99TextColor;
    self.nameLabel.font = labelFont;
    
    self.commentLabel.font = labelFont;
    self.commentLabel.textColor = kBlackTextColor;
    self.commentLabel.numberOfLines = 0;
    
    self.timeLabel.textColor = kGrayTextColor;
    self.timeLabel.font = [UIFont systemFontOfSize:12.0];
    self.timeLabel.textAlignment = NSTextAlignmentRight;
    
    self.replayLabel.font = labelFont;
    self.replayLabel.numberOfLines = 0;
    
    self.lineView.backgroundColor = kGrayLineColor;
}

- (void)setModel:(YYShopCommentModel *)model{
    _model = model;
    
    self.iconImageView.image = [UIImage imageNamed:@"profile_icon_noligin"];
    
    self.nameLabel.text = model.username;
    
    self.timeLabel.text = model.metime;
    
    self.commentLabel.text = model.medetails;
    
    CGFloat commentLabelW = kWidthScreen - 12 * 2;
    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
    attr[NSFontAttributeName] = labelFont;
    CGFloat commentLabelH = [model.medetails boundingRectWithSize:CGSizeMake(commentLabelW, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:attr context:nil].size.height + 1;
    
    [self.commentLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(commentLabelH);
    }];

    NSString *str = nil;
    NSMutableAttributedString *replayLabelStr = nil;
    if (![model.codetails isEqual:[NSNull null]]) {
        str = [NSString stringWithFormat:@"卖家回复：%@", model.codetails];
        
        replayLabelStr = [[NSMutableAttributedString alloc] initWithString:str];
        [replayLabelStr addAttribute:NSForegroundColorAttributeName value:kRGBAColor(8, 187, 89, 1) range:NSMakeRange(5, str.length - 5)];
        [replayLabelStr addAttribute:NSForegroundColorAttributeName value:kBlackTextColor range:NSMakeRange(0, 4)];
    }
    
    
    self.replayLabel.attributedText = replayLabelStr;
    
    
    CGFloat replayLabelH = [str boundingRectWithSize:CGSizeMake(commentLabelW, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:attr context:nil].size.height + 1;
    
    [self.replayLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(replayLabelH);
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
