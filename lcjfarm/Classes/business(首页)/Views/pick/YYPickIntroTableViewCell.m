//
//  YYPickIntroTableViewCell.m
//  lcjfarm
//
//  Created by wyy on 16/7/5.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import "YYPickIntroTableViewCell.h"
#import "YYPickTableViewModel.h"

@interface YYPickIntroTableViewCell ()
/**
 *  店铺名称
 */
@property (weak, nonatomic) IBOutlet UILabel *shopNameLabel;

/**
 *  店铺距离label
 */
@property (weak, nonatomic) IBOutlet UILabel *shopDistanceLabel;
/**
 *  多少人喜欢左边的星星图标
 */
@property (weak, nonatomic) IBOutlet UIImageView *shopLikeImageView;
/**
 *  多少人喜欢label
 */
@property (weak, nonatomic) IBOutlet UILabel *shopLikeNumLabel;
/**
 *  分割线
 */
@property (weak, nonatomic) IBOutlet UIView *lineView;
/**
 *  店铺营业时间左边imageView
 */
@property (weak, nonatomic) IBOutlet UIImageView *shopTimeImageView;
/**
 *  店铺营业时间Label
 */
@property (weak, nonatomic) IBOutlet UILabel *shopTimeLabel;
/**
 *  电话Button
 */
@property (weak, nonatomic) IBOutlet UIButton *shopPhoneBtn;

/**
 *  地址左边imageView
 */
@property (weak, nonatomic) IBOutlet UIImageView *shopAddressImageView;
/**
 *  店铺地址Label
 */
@property (weak, nonatomic) IBOutlet UILabel *shopAddressLabel;
/**
 *  导航Button
 */
@property (weak, nonatomic) IBOutlet UIButton *shopAddressBtn;

@end

@implementation YYPickIntroTableViewCell
+ (instancetype)pickIntroTableViewCellWithTableView:(UITableView *)tableView{
    static NSString *identifier = @"YYPickIntroTableViewCell";
    YYPickIntroTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YYPickIntroTableViewCell" owner:nil options:nil] lastObject];
    }
    return cell;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    //清楚所有约束
    [self.contentView removeConstraints:[self.contentView constraints]];
    //设置views的位置
    [self setViewsConstraint];
    
    //设置views的属性
    [self setViews];
    
    //添加按钮点击事件
    [self addBtnsAction];
}
#pragma mark 设置views的位置
/**
 *  设置views的位置
 */
- (void)setViewsConstraint{
    CGFloat margin24 = k12HeightMargin * 2;
    CGFloat shopNameLabelH = 18;
    [self.shopNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.contentView);
        make.height.mas_equalTo(shopNameLabelH);
        make.top.mas_equalTo(self.contentView).mas_offset(margin24);
    }];
    
    CGFloat starAndDistanceMargin = k12HeightMargin;
    CGFloat distanceLabelH = 15;
    [self.shopDistanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.contentView);
        make.height.mas_equalTo(distanceLabelH);
        make.top.mas_equalTo(self.shopNameLabel.mas_bottom).mas_offset(starAndDistanceMargin);
    }];
    
    CGFloat starIconH = 10;
    [self.shopLikeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.shopDistanceLabel.mas_bottom).mas_offset(k12HeightMargin);
        make.size.mas_equalTo(CGSizeMake(starIconH, starIconH));
    }];
    [self.shopLikeNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.shopLikeImageView.mas_right).mas_offset(5);
        make.right.mas_equalTo(self.contentView);
        make.height.mas_equalTo(10);
        make.top.mas_equalTo(self.shopLikeImageView);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).mas_offset(12);
        make.right.mas_equalTo(self.contentView).mas_offset(-12);
        make.height.mas_equalTo(0.5);
        make.top.mas_equalTo(self.shopLikeNumLabel.mas_bottom).mas_offset(margin24);
    }];
    
    CGFloat yMargin18 = 18/603.0*kNoNavHeight;
    CGFloat timeIconH = 13;
    [self.shopTimeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(12);
        make.size.mas_equalTo(CGSizeMake(timeIconH, timeIconH));
        make.top.mas_equalTo(self.lineView.mas_bottom).mas_offset(yMargin18);
    }];
    
    CGFloat btnH = 25;
    [self.shopPhoneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(btnH + 24, btnH + k12HeightMargin));
        make.top.mas_equalTo(self.lineView.mas_bottom);
    }];
    
    [self.shopTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.shopTimeImageView.mas_right).mas_offset(10);
        make.top.bottom.mas_equalTo(self.shopTimeImageView);
        make.right.mas_equalTo(self.shopPhoneBtn.mas_left).mas_offset(-10);
        
    }];
    
    CGFloat yMargin23 = 23/603.0*kNoNavHeight;
    [self.shopAddressImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.shopTimeImageView);
        make.top.mas_equalTo(self.shopTimeImageView.mas_bottom).mas_offset(yMargin23);
        make.height.mas_equalTo(timeIconH);
    }];
    
    
    [self.shopAddressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.shopTimeLabel);
        make.centerY.mas_equalTo(self.shopAddressImageView.mas_centerY);
        make.height.mas_equalTo(15);
    }];
    
    [self.shopAddressBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.shopPhoneBtn);
        make.centerY.mas_equalTo(self.shopAddressImageView.mas_centerY);
        make.height.mas_equalTo(btnH + 10);
    }];
    
}
#pragma mark 设置views的属性
/**
 *  设置views的属性
 */
- (void)setViews{
    //设置字体大小
    self.shopNameLabel.font = [UIFont boldSystemFontOfSize:18.0];
    self.shopDistanceLabel.font = [UIFont systemFontOfSize:15.0];
    self.shopLikeNumLabel.font = [UIFont systemFontOfSize:10.0];
    self.shopTimeLabel.font = [UIFont systemFontOfSize:13.0];
    self.shopAddressLabel.font = [UIFont systemFontOfSize:15.0];
    
    //设置字体颜色
    self.shopNameLabel.textColor = kBlackTextColor;
    self.shopDistanceLabel.textColor = kBlackTextColor;
    self.shopLikeNumLabel.textColor = kGray99TextColor;
    self.shopTimeLabel.textColor = kBlackTextColor;
    self.shopAddressLabel.textColor = kBlackTextColor;
    
    //设置线的颜色
    self.lineView.backgroundColor = kGrayLineColor;
    
//    self.shopAddressLabel.adjustsFontSizeToFitWidth = YES;
}
#pragma mark 添加按钮点击事件
/**
 *  添加按钮点击事件
 */
- (void)addBtnsAction{
    [self.shopPhoneBtn bk_addEventHandler:^(id sender) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationPhoneFarmBtnClick object:self userInfo:nil];
    } forControlEvents:UIControlEventTouchUpInside];
    
    [self.shopAddressBtn bk_addEventHandler:^(id sender) {
       
         [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationNavigationFarmBtnClick object:self userInfo:nil];
    } forControlEvents:UIControlEventTouchUpInside];
}
#pragma mark 重写模型的setter方法
/**
 *  重写模型的setter方法
 */
- (void)setModel:(YYPickTableViewModel *)model{
    _model = model;
    //店铺名称设置
    self.shopNameLabel.text = model.name;

    //设置距离
    NSString *distance = nil;
    int juli = model.juli.intValue;
    if (juli > 1000) {
        distance = [NSString stringWithFormat:@"距离我：%.1f千米", juli / 1000.0];
    }
    else{
        distance = [NSString stringWithFormat:@"距离我：%d米",juli];
    }
    
    NSRange blackRange = NSMakeRange(0, 4);
    NSMutableAttributedString *attributeDistance = [[NSMutableAttributedString alloc] initWithString:distance];
    [attributeDistance addAttribute:NSForegroundColorAttributeName value:kBlackTextColor range:blackRange];
    NSRange greenRange = NSMakeRange(4, distance.length - 4);
    [attributeDistance addAttribute:NSForegroundColorAttributeName value:kNavColor range:greenRange];
    self.shopDistanceLabel.attributedText = attributeDistance;
    
    //喜欢人数label
    NSString *likeNum = [NSString stringWithFormat:@"%@人喜欢",model.collectionnum];
    self.shopLikeNumLabel.text = likeNum;
    CGFloat shopLikeNumLabelH = 10;
    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
    attr[NSFontAttributeName] = [UIFont systemFontOfSize:10.0];
    
    CGFloat shopLikeNumLabelW = [likeNum boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, shopLikeNumLabelH) options:NSStringDrawingUsesLineFragmentOrigin attributes:attr context:nil].size.width;
    //根据喜欢人数label的长度设置星星图标的left
    CGFloat starIconW = 10;
    CGFloat shopLikeImageViewX = (kWidthScreen - 5 - starIconW - shopLikeNumLabelW)/2.0;
    [self.shopLikeImageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(shopLikeImageViewX);
    }];
    //营业时间
    self.shopTimeLabel.text = model.time;
    //地址
    self.shopAddressLabel.text = model.address;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
