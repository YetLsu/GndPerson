//
//  YYHomeTopCollectionViewCell.h
//  lcjfarm
//
//  Created by wyy on 16/8/16.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YYSeasonFruitModel;

@interface YYHomeTopCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) YYSeasonFruitModel *model;

+ (instancetype)homeTopCollectionViewCellWithCollectionView:(UICollectionView *)collectionView andIndexPath:(NSIndexPath *)indexPath;
@end
