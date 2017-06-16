//
//  YYSearchFruitNewsTableViewCell.m
//  lcjfarm
//
//  Created by wyy on 16/8/17.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import "YYSearchFruitNewsTableViewCell.h"
#import "YYFruitNewsModel.h"


@interface YYSearchFruitNewsTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *fruitNewsImageView;

@property (weak, nonatomic) IBOutlet UILabel *fruitNewsNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *fruitNewsContentLabel;

@end

@implementation YYSearchFruitNewsTableViewCell

+ (instancetype)YYSearchFruitNewsTableViewCellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"YYSearchFruitNewsTableViewCell";
    YYSearchFruitNewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YYSearchFruitNewsTableViewCell" owner:nil options:nil] lastObject];
    }
    return cell;
}
- (void)awakeFromNib {
    [super awakeFromNib];
   
    self.lineView.backgroundColor = kGrayLineColor;
    
    self.fruitNewsNameLabel.textColor = kBlackTextColor;
    
    self.fruitNewsContentLabel.textColor = kRGBAColor(105.0, 105.0, 105.0, 1.0);
    
}
- (void)setModel:(YYFruitNewsModel *)model{
    _model = model;
    
    [self.fruitNewsImageView sd_setImageWithURL:[NSURL URLWithString:model.showimgurl]];
    
    self.fruitNewsNameLabel.text = model.title;
    self.fruitNewsContentLabel.text = model.introduction;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
