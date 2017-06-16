//
//  YYSearchHotTableViewCell.m
//  lcjfarm
//
//  Created by wyy on 16/8/16.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import "YYSearchHotTableViewCell.h"

#import "YYSearchWordModel.h"


@interface YYSearchHotTableViewCell ()

/**
 *  搜索词
 */
@property (nonatomic, weak) UILabel *searchLabel;
/**
 *  搜索热度图片
 */
@property (nonatomic, weak) UIImageView *hotImageView;
/**
 *  搜索数量
 */
@property (nonatomic, weak) UILabel *numberLabel;
/**
 *  线
 */
@property (nonatomic, weak) UIView *lineView;
@end

@implementation YYSearchHotTableViewCell
+ (instancetype)searchHotTableViewCellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"YYSearchHotTableViewCell";
    YYSearchHotTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[YYSearchHotTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //增加控件
        [self addSubviews];
        
        //增加约束
        [self setConstraints];
        
        //设置Views
        [self setViews];
    }
    
    return self;
}
#pragma mark 增加控件
/**
 *  增加控件
 */
- (void)addSubviews{
    /**
     *  搜索词
     */
    UILabel *searchLabel = [[UILabel alloc] init];
    [self.contentView addSubview:searchLabel];
    self.searchLabel = searchLabel;
    /**
     *  搜索热度图片
     */
    UIImageView *hotImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:hotImageView];
    self.hotImageView = hotImageView;
    /**
     *  搜索数量
     */
    UILabel *numberLabel = [[UILabel alloc] init];
    [self.contentView addSubview:numberLabel];
    self.numberLabel = numberLabel;
    //增加线
    UIView *lineView = [[UIView alloc] init];
    [self.contentView addSubview:lineView];
    self.lineView = lineView;
    
}
/**
 *  增加约束
 */
- (void)setConstraints{
    //搜索词
    [self.searchLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(12);
        make.width.mas_equalTo(70);
        make.top.mas_equalTo(self.contentView.mas_top);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).mas_offset(-0.5);
    }];
    //搜索热度图片
    CGFloat hotImageViewTop = (38 - 15)/2.0;
    [self.hotImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.searchLabel.mas_right).mas_offset(10);
        make.height.mas_equalTo(15);
        make.top.mas_equalTo(hotImageViewTop);
    }];
    //搜索数量
    [self.numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView.mas_right).mas_offset(-10);
        make.width.mas_equalTo(50);
        make.top.mas_equalTo(self.contentView.mas_top);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).mas_offset(-0.5);
    }];
    
    //线
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.mas_equalTo(self.contentView);
        make.height.mas_equalTo(0.5);
        
    }];
}
/**
 *  设置Views
 */
- (void)setViews{
    self.searchLabel.textColor = kGrayTextColor;
    self.searchLabel.font = [UIFont systemFontOfSize:14.0];
    
    self.numberLabel.textColor = kGrayTextColor;
    self.numberLabel.font = [UIFont systemFontOfSize:14.0];
    
    self.lineView.backgroundColor = kGrayLineColor;
    
    self.numberLabel.textAlignment = NSTextAlignmentRight;
}

- (void)setModel:(YYSearchWordModel *)model{
    _model = model;
    
    self.searchLabel.text = model.name;
    
    self.numberLabel.text = model.hot_search;
    
    [self.hotImageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(model.imageW);
    }];
    self.hotImageView.image = model.hotImage;
    
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
