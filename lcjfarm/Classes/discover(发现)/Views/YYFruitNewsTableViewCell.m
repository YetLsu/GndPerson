//
//  YYFruitNewsTableViewCell.m
//  lcjfarm
//
//  Created by wyy on 16/7/13.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import "YYFruitNewsTableViewCell.h"
#import "YYFruitNewsModel.h"


@interface YYFruitNewsTableViewCell ()
/**
 *  水果咨询展示图ImageView
 */
@property (weak, nonatomic) IBOutlet UIImageView *fruitNewImageView;
/**
 *  水果咨询标题Label
 */
@property (weak, nonatomic) IBOutlet UILabel *fruitNewsNameLabel;
/**
 *  水果咨询时间Label
 */
@property (weak, nonatomic) IBOutlet UILabel *fruitNewTimeLabel;
/**
 *  水果咨询简介Label
 */
@property (weak, nonatomic) IBOutlet UILabel *fruitNewIntroLabel;
@end

@implementation YYFruitNewsTableViewCell

+ (instancetype)fruitNewsTableViewCellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"YYFruitNewsTableViewCell";
    YYFruitNewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YYFruitNewsTableViewCell" owner:nil options:nil] lastObject];
    }
    return cell;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    //设置单元格的背景颜色
    self.contentView.backgroundColor = kViewBgGrayColor;
    //设置label的属性
    self.fruitNewsNameLabel.textColor = kBlackTextColor;
    self.fruitNewIntroLabel.textColor = kGrayTextColor;
    self.fruitNewTimeLabel.textColor = kGrayTextColor;
}

- (void)setModel:(YYFruitNewsModel *)model{
    _model = model;
    //水果咨询展示图ImageView
    [self.fruitNewImageView sd_setImageWithURL:[NSURL URLWithString:model.showimgurl]];
    //水果咨询标题Label
    self.fruitNewsNameLabel.text = model.title;
    //水果咨询时间Label
    self.fruitNewTimeLabel.text = model.create_d;
    //水果咨询简介Label
    self.fruitNewIntroLabel.text = model.introduction;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
