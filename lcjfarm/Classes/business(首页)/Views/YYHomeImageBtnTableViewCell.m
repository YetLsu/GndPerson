//
//  YYHomeImageBtnTableViewCell.m
//  lcjfarm
//
//  Created by wyy on 16/6/27.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import "YYHomeImageBtnTableViewCell.h"
#import "YYHomeImageBtnModel.h"

@interface YYHomeImageBtnTableViewCell()
/**
 *  cell中的图片的imageView
 */
@property (nonatomic, weak) UIImageView *btnImageView;

@end

@implementation YYHomeImageBtnTableViewCell
+ (instancetype)homeImageBtnTableViewCellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"YYHomeImageBtnTableViewCell";
    YYHomeImageBtnTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[YYHomeImageBtnTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //创建cell中的图片的imageView
        UIImageView *btnImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:btnImageView];
        self.btnImageView = btnImageView;
        
        __weak __typeof(&*self)weakSelf = self;
        [btnImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.contentView.mas_left).offset(k12WidthMargin);
            make.right.mas_equalTo(weakSelf.contentView.mas_right).offset(-k12WidthMargin);
            make.top.bottom.mas_equalTo(weakSelf.contentView);
        }];
        self.contentView.backgroundColor = kViewBgGrayColor;
        
    }
    return self;
}
- (void)setModel:(YYHomeImageBtnModel *)model{
    _model = model;
    
    self.btnImageView.image = [UIImage imageNamed:model.imageUrlStr];
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
