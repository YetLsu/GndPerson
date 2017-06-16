//
//  YYPickEightTableViewCell.m
//  lcjfarm
//
//  Created by wyy on 16/8/8.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import "YYPickEightTableViewCell.h"

#import "YYPickDetailTableViewDataSource.h"
#import "YYPickDetailTableViewDelegate.h"

#import "YYPickEightCollectionViewCell.h"

#import "YYPickTableViewModel.h"

@interface YYPickEightTableViewCell (){
    YYPickDetailTableViewDataSource *_pickDataSource;
    YYPickDetailTableViewDelegate *_pickDelegate;
    
    
}


@end

@implementation YYPickEightTableViewCell

YYPickTableViewModel *_model;

+ (instancetype)pickEightTableViewCellWithPickModel:(YYPickTableViewModel *)model{
    YYPickEightTableViewCell *cell = [[YYPickEightTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    
    _model = model;
    
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        //增加collectionView
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(35, 35);
        
        CGFloat lineMargin = 12;
        
        layout.minimumLineSpacing = lineMargin * 2;
        
        CGFloat interMagin = (kWidthScreen - 4 * 35)/8.0;
        layout.minimumInteritemSpacing = interMagin * 2;
        layout.sectionInset = UIEdgeInsetsMake(lineMargin, interMagin, lineMargin, interMagin);
       
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kWidthScreen, 118) collectionViewLayout:layout];
        collectionView.backgroundColor = [UIColor whiteColor];
        
        
        [self.contentView addSubview:collectionView];
        static NSString *cellID = @"cellID";
        [collectionView registerClass:[YYPickEightCollectionViewCell class] forCellWithReuseIdentifier:cellID];
        
        _pickDataSource = [[YYPickDetailTableViewDataSource alloc] initWithPickFarmWithPickModel:_model];
        collectionView.dataSource = _pickDataSource;
        
        _pickDelegate = [[YYPickDetailTableViewDelegate alloc] init];
        collectionView.delegate = _pickDelegate;
        
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
