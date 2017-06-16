//
//  YYPickContentTableViewCell.m
//  lcjfarm
//
//  Created by wyy on 16/8/9.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import "YYPickContentTableViewCell.h"

@interface YYPickContentTableViewCell ()

@property (nonatomic, weak) UILabel *contentLabel;

@end

@implementation YYPickContentTableViewCell
+ (instancetype)pickContentTableViewCellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"YYPickContentTableViewCell";
    YYPickContentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[YYPickContentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    return cell;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //增加Label
        UILabel *label = [[UILabel alloc] init];
        [self.contentView addSubview:label];
        label.numberOfLines = 0;
        label.font = [UIFont systemFontOfSize:15.0];
        label.textColor = kBlackTextColor;
        self.contentLabel = label;
    }
    return self;
}

- (void)setContent:(NSString *)content{
    _content = content;
    
    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
    attr[NSFontAttributeName] = [UIFont systemFontOfSize:15.0];
    CGFloat contentLabelW = kWidthScreen - 10 - 18;
    CGFloat contentLabelH = [content boundingRectWithSize:CGSizeMake(contentLabelW, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:attr context:nil].size.height;
    self.contentLabel.frame = CGRectMake(10, 5, contentLabelW, contentLabelH);
    
    self.contentLabel.text = content;
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
