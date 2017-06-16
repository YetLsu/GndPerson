//
//  YYHomeTopCollectionViewCell.m
//  lcjfarm
//
//  Created by wyy on 16/8/16.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import "YYHomeTopCollectionViewCell.h"
#import "YYSeasonFruitModel.h"

@interface YYHomeTopCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end

@implementation YYHomeTopCollectionViewCell
+ (instancetype)homeTopCollectionViewCellWithCollectionView:(UICollectionView *)collectionView andIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"YYHomeTopCollectionViewCell";
    
    YYHomeTopCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    
    return cell;
    
}
- (void)setModel:(YYSeasonFruitModel *)model{
    _model = model;
    
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:model.iconimgurl]];
    
    self.nameLabel.text = model.name;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    self.nameLabel.font = [UIFont systemFontOfSize:15.0];
    self.nameLabel.textColor = kBlackTextColor;
    self.nameLabel.adjustsFontSizeToFitWidth = YES;
}

@end
