//
//  YYCityTableViewCell.m
//  lcjfarm
//
//  Created by wyy on 16/7/15.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import "YYCityTableViewCell.h"

#import "YYCityModel.h"

@interface YYCityTableViewCell ()
/**
 *  城市名称Label
 */
@property (weak, nonatomic) IBOutlet UILabel *cityNameLabel;
/**
 *  线条View
 */
@property (weak, nonatomic) IBOutlet UIView *lineView;
@end

@implementation YYCityTableViewCell
+ (instancetype)cityTableViewCellWithTableView:(UITableView *)tableView{
    static NSString *identifier = @"YYCityTableViewCell";
    
    YYCityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YYCityTableViewCell" owner:nil options:nil] lastObject];
    }
    
    return cell;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.cityNameLabel.textColor = kBlackTextColor;
    
    self.lineView.backgroundColor = kGrayLineColor;
}

- (void)setModel:(YYCityModel *)model{
    _model = model;
    
    self.cityNameLabel.text = model.name;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
