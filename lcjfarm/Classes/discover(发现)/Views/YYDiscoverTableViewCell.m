//
//  YYDiscoverTableViewCell.m
//  lcjfarm
//
//  Created by wyy on 16/8/10.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import "YYDiscoverTableViewCell.h"
#import "YYDiscoverTableViewCellModel.h"

@interface YYDiscoverTableViewCell ()
@property (weak, nonatomic) IBOutlet UIView *lineView;

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;

@end

@implementation YYDiscoverTableViewCell
+ (instancetype)discoverTableViewCellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"YYDiscoverTableViewCell";
    YYDiscoverTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YYDiscoverTableViewCell" owner:nil options:nil] lastObject];
    }
    return cell;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    self.lineView.backgroundColor = kGrayLineColor;
    self.titleLabel.font = [UIFont systemFontOfSize:20.0];
    self.titleLabel.textColor = kBlackTextColor;
    self.titleLabel.font = [UIFont systemFontOfSize:20.0];
    self.detailLabel.textColor = kGray99TextColor;
    self.detailLabel.font = [UIFont systemFontOfSize:16.0];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModel:(YYDiscoverTableViewCellModel *)model{
    _model = model;
    self.iconImageView.image = model.iconImage;
    
    self.titleLabel.text = model.title;
    
    self.detailLabel.text = model.detailTitle;
    
}
@end
