//
//  YYSeasonFruitIntroTableViewCell.m
//  lcjfarm
//
//  Created by wyy on 16/7/12.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import "YYSeasonFruitIntroTableViewCell.h"
#import "YYSeasonFruitModel.h"


@interface YYSeasonFruitIntroTableViewCell (){
    YYSeasonFruitModel *_model;
}

@end

@implementation YYSeasonFruitIntroTableViewCell

- (instancetype)initWithModel:(YYSeasonFruitModel *)model{
    _model = model;
    if (self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil]) {
        /**
         *  创建label
         */
        UILabel *label = [[UILabel alloc] init];
        [self.contentView addSubview:label];
        //计算label的高度
        CGFloat maxW = kWidthScreen - 12 * 2;
        NSMutableDictionary *attr = [NSMutableDictionary dictionary];
        attr[NSFontAttributeName] = [UIFont systemFontOfSize:13];
        NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
        paragraph.lineSpacing = 5;
        attr[NSParagraphStyleAttributeName] = paragraph;
        
        CGFloat labelH = [_model.introduction boundingRectWithSize:CGSizeMake(maxW, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:attr context:nil].size.height;
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(12);
            make.right.mas_equalTo(self.contentView.mas_right).mas_offset(-12);
            make.top.mas_equalTo(10);
            make.height.mas_equalTo(labelH + 2);
        }];
        
        label.textColor = kGrayTextColor;
        label.numberOfLines = 0;
        attr[NSFontAttributeName] = [UIFont systemFontOfSize:13.0];
        NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:_model.introduction attributes:attr];
        label.attributedText = attrString;
    }
    return self;
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
