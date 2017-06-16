//
//  YYSeasonFruitViewController.m
//  lcjfarm
//
//  Created by wyy on 16/7/11.
//  Copyright © 2016年 WYY. All rights reserved.
//
#define topMonthViewH ((10 + 12)/603.0*kNoNavHeight + 25)
#define swipeableViewY (topMonthViewH + 24 + 64)
#define swipeableViewH (15 + 16 + 12 + 16 + 12 + 22 + 12 + 250/603.0 *kNoNavHeight)
#import "YYSeasonFruitViewController.h"
#import "YYSeasonFruitView.h"
#import "YYSeasonFruitModel.h"

#import "YYSeasonFruitDeatilViewController.h"

#import "AKPickerView.h"


@interface YYSeasonFruitViewController ()<AKPickerViewDataSource, AKPickerViewDelegate, ZLSwipeableViewDataSource>{
    NSMutableArray *_seasonFruitModelsArray;
    NSUInteger _index;
}
/**
 *  换一个按钮
 */
@property (nonatomic, weak) UIButton *changeBtn;
/**
 *  我要吃按钮
 */
@property (nonatomic, weak) UIButton *eatBtn;
/**
 *  月份的View
 */
@property (nonatomic, weak) AKPickerView *pickerView;
/**
 *  月份的数组
 */
@property (nonatomic, strong) NSArray *monthArray;

@property (nonatomic, assign) NSInteger monthIndex;
/**
 *  中间的View
 */
@property (nonatomic, strong) ZLSwipeableView *swipeableView;

@end

@implementation YYSeasonFruitViewController

- (ZLSwipeableView *)swipeableView{
    if (!_swipeableView) {
        CGFloat xMargin = 40/375.0 *kWidthScreen;
        CGFloat width = (kWidthScreen - 2 * xMargin);
        _swipeableView = [[ZLSwipeableView alloc] initWithFrame:CGRectMake(xMargin, swipeableViewY, width, swipeableViewH)];
        
        /**
         *  根据获取的数据设置页数
         */
        _swipeableView.numberOfActiveViews = _seasonFruitModelsArray.count;
        // Required Data Source
        self.swipeableView.dataSource = self;
        
        // Optional Delegate
        _swipeableView.delegate = self;
        
        _swipeableView.translatesAutoresizingMaskIntoConstraints = NO;
        _swipeableView.backgroundColor = [UIColor grayColor];
        //添加手势
        [self addTagForSwipeableView];
    }
    return _swipeableView;
}

/**
 *  获取数据
 */
- (void)getDatasFromInternetWithMonth:(NSString *)month{
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"month"] = month;
    
    [NSObject GET:@"http://app.guonongda.com:8080/sf/month.do" parameters:parameters progress:^(NSProgress *downloadProgress) {
        
    } completionHandler:^(NSDictionary *responseObject, NSError *error) {
        
//        YYLog(@"%@", responseObject);
        NSArray *dataArray = responseObject[@"data"];
//        YYLog(@"数据:%lu",(unsigned long)dataArray.count);
        
        if (dataArray.count > 0) {
            [_seasonFruitModelsArray removeAllObjects];
        }
        else{
            [MBProgressHUD showError:@"该月份应季水果信息正在收集中"];
        }
        for (NSDictionary *dic in dataArray) {
//            YYLog(@"%@",dic);
            YYSeasonFruitModel *model = [[YYSeasonFruitModel alloc] init];
            
            [model setValuesForKeysWithDictionary:dic];
            
            [_seasonFruitModelsArray addObject:model];
            
        }
        YYLog(@"加载完毕");
        [self.swipeableView discardAllViews];
        [self.swipeableView removeFromSuperview];
        _index = 0;
        

        [self.view addSubview:self.swipeableView];
        self.swipeableView.numberOfActiveViews = _seasonFruitModelsArray.count;
//
//        YYLog(@"swipeable的frame:%@", NSStringFromCGRect(self.swipeableView.frame));
//        [self.swipeableView rewind];
      
      
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _seasonFruitModelsArray = [NSMutableArray array];
    
    //设置导航栏的内容
    [self setNavView];
    
    //增加上面月份的View
    [self addMonthView];
    
    //增加下面的两个按钮
    [self addTwoBtn];
    
    NSDate *currentDate = [NSDate date];//获取当前时间，日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM"];
    NSString *dateString = [dateFormatter stringFromDate:currentDate];
    
    self.monthIndex = dateString.integerValue - 1;
    
    [self.pickerView selectItem:self.monthIndex animated:NO];

    
}
#pragma mark 设置导航栏的内容
/**
 *  设置导航栏的内容
 */
- (void)setNavView{
    
    /**
     *  增加老陈家农场的图片
     */
    UIImageView *titleImageView = [[UIImageView alloc] init];
    titleImageView.image = [UIImage imageNamed:@"home_fruit_title"];
    [titleImageView sizeToFit];
    self.navigationItem.titleView = titleImageView;
    
}
#pragma mark 增加上面月份的View
/**
 *  增加上面月份的View
 */
- (void)addMonthView{
    UIView *monthView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, kWidthScreen, topMonthViewH)];
    [self.view addSubview:monthView];
    
    monthView.backgroundColor = kRGBAColor(252, 255, 245, 1);
    
    [YYLcjFarmTool addLineViewWithFrame:CGRectMake(0, topMonthViewH - 0.5, kWidthScreen, 0.5) andView:monthView];
    
    //增加月份的collectionView
    CGFloat pickerViewW = 205;
    CGFloat pickerViewX = (kWidthScreen - pickerViewW)/2.0;
    AKPickerView *pickerView = [[AKPickerView alloc] initWithFrame:CGRectMake(pickerViewX, 0, pickerViewW, topMonthViewH)];
    [monthView addSubview:pickerView];
    self.pickerView = pickerView;
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
    self.pickerView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    
    self.pickerView.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:13];
    self.pickerView.highlightedFont = [UIFont fontWithName:@"HelveticaNeue" size:20];
    self.pickerView.interitemSpacing = 10.0;
    self.pickerView.fisheyeFactor = 0.001;
    self.pickerView.pickerViewStyle = AKPickerViewStyle3D;
    self.pickerView.maskDisabled = false;

    [self.pickerView reloadData];
    
    //增加左边的按钮
    CGFloat leftBtnW = 50;
    CGFloat leftBtnX = (kWidthScreen - pickerViewW - leftBtnW * 2)/2.0;
    UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(leftBtnX, 0, leftBtnW, topMonthViewH)];
    [leftBtn setImage:[UIImage imageNamed:@"seasonFruit_back"] forState:UIControlStateNormal];
    [monthView addSubview:leftBtn];
    
    [leftBtn bk_addEventHandler:^(id sender) {
        if (self.monthIndex == 0) {
            self.monthIndex = 12;
        }
        self.monthIndex -= 1;
        [self.pickerView selectItem:self.monthIndex animated:YES];
    } forControlEvents:UIControlEventTouchUpInside];
    
    //增加右边的按钮
    CGFloat rightBtnX = leftBtnX + leftBtnW + pickerViewW;
    UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(rightBtnX,0, leftBtnW, topMonthViewH)];
    [rightBtn setImage:[UIImage imageNamed:@"seasonFruit_next"] forState:UIControlStateNormal];
    [monthView addSubview:rightBtn];
    
    [rightBtn bk_addEventHandler:^(id sender) {
        if (self.monthIndex == 11) {
            self.monthIndex = -1;
        }
        self.monthIndex += 1;
        [self.pickerView selectItem:self.monthIndex animated:YES];
    } forControlEvents:UIControlEventTouchUpInside];
    
}
#pragma mark 为ZLSwipeableView添加单击手饰
/**
 *  为ZLSwipeableView添加单击手饰
 */
- (void)addTagForSwipeableView{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(singleTap:)];
    // 允许用户交互
    self.swipeableView.userInteractionEnabled = YES;
    
    [self.swipeableView addGestureRecognizer:tap];
}
/**
 *  单击之后触发的方法
 */
- (void)singleTap:(id)sender{
    YYLog(@"点击ZLSwipeableView");
    
    UITapGestureRecognizer *singleTap = (UITapGestureRecognizer *)sender;
    ZLSwipeableView *swipeableView = (ZLSwipeableView *)singleTap.view;
    YYSeasonFruitView *firstView = (YYSeasonFruitView *)swipeableView.topView;
    YYSeasonFruitDeatilViewController *seasonFruitDetail = [[YYSeasonFruitDeatilViewController alloc] initWithSeasonFruitModel:firstView.model];
    [self.navigationController pushViewController:seasonFruitDetail animated:YES];
    
}
/**
 *  增加下面的两个按钮
 */
- (void)addTwoBtn{

    CGFloat scale = kNoNavHeight/603.0;
    CGFloat btnH = 86 * scale;
    CGFloat btnW = btnH;
    CGFloat btnMargin = 50;
    CGFloat changeBtnX = (kWidthScreen - btnW * 2 - btnMargin)/2.0;
    
    CGFloat changeBtnY = (kHeightScreen - btnH - swipeableViewH - swipeableViewY)/2.0 + swipeableViewY + swipeableViewH;
    //换一个按钮
    UIButton *changeBtn = [[UIButton alloc] init];
    changeBtn.frame = CGRectMake(changeBtnX, changeBtnY, btnW, btnH);
    [changeBtn setBackgroundImage:[UIImage imageNamed:@"home_season_changeBtn"] forState:UIControlStateNormal];
    [self.view addSubview:changeBtn];
    self.changeBtn = changeBtn;

    [self.changeBtn bk_addEventHandler:^(id sender) {
        [self.swipeableView swipeTopViewToLeft];
    } forControlEvents:UIControlEventTouchUpInside];
    
    //我要吃按钮
    UIButton *eatBtn = [[UIButton alloc] init];
    eatBtn.frame = CGRectMake(changeBtnX + btnW + btnMargin, changeBtnY, btnW, btnH);
    [eatBtn setBackgroundImage:[UIImage imageNamed:@"home_season_eat"] forState:UIControlStateNormal];
    [self.view addSubview:eatBtn];
    self.eatBtn = eatBtn;

    [self.eatBtn bk_addEventHandler:^(id sender) {
        YYSeasonFruitView *firstView = (YYSeasonFruitView *)self.swipeableView.topView;
        YYSeasonFruitDeatilViewController *seasonFruitDetail = [[YYSeasonFruitDeatilViewController alloc] initWithSeasonFruitModel:firstView.model];
        [self.navigationController pushViewController:seasonFruitDetail animated:YES];
    } forControlEvents:UIControlEventTouchUpInside];
}
- (void)viewDidLayoutSubviews {
    [self.swipeableView loadViewsIfNeeded];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - ZLSwipeableView的代理方法
/**
 *  换一个的direction为1，我要吃的direction为2
 */
- (void)swipeableView:(ZLSwipeableView *)swipeableView
         didSwipeView:(UIView *)view
          inDirection:(ZLSwipeableViewDirection)direction {
//    YYLog(@"did swipe in direction: %zd", direction);
}

- (void)swipeableView:(ZLSwipeableView *)swipeableView didCancelSwipe:(UIView *)view {
//    YYLog(@"did cancel swipe");
}

- (void)swipeableView:(ZLSwipeableView *)swipeableView
  didStartSwipingView:(UIView *)view
           atLocation:(CGPoint)location {
//    YYLog(@"did start swiping at location: x %f, y %f", location.x, location.y);
}

//- (void)swipeableView:(ZLSwipeableView *)swipeableView
//          swipingView:(UIView *)view
//           atLocation:(CGPoint)location
//          translation:(CGPoint)translation {
//    YYLog(@"swiping at location: x %f, y %f, translation: x %f, y %f", location.x, location.y,
//          translation.x, translation.y);
//}

- (void)swipeableView:(ZLSwipeableView *)swipeableView
    didEndSwipingView:(UIView *)view
           atLocation:(CGPoint)location {
//    YYLog(@"did end swiping at location: x %f, y %f", location.x, location.y);
}

#pragma mark - ZLSwipeableView的数据源方法
- (UIView *)nextViewForSwipeableView:(ZLSwipeableView *)swipeableView {
    YYLog(@"下一页");
    if (_index >= _seasonFruitModelsArray.count) {
        _index = 0;
    }

    YYSeasonFruitView *view = [[YYSeasonFruitView alloc] initWithFrame:swipeableView.bounds];
    view.backgroundColor = [UIColor whiteColor];
    view.layer.cornerRadius = 5.0;
    view.layer.masksToBounds = YES;
    view.layer.borderWidth = 1.0;
    view.layer.borderColor = [kGrayLineColor CGColor];
    view.model = _seasonFruitModelsArray[_index];
    YYLog(@"%lu",(unsigned long)_index);
    _index++;

    return view;
}
#pragma mark - AKPickerViewDataSource

- (NSUInteger)numberOfItemsInPickerView:(AKPickerView *)pickerView
{
    return self.monthArray.count;
}
- (NSString *)pickerView:(AKPickerView *)pickerView titleForItem:(NSInteger)item
{
    return self.monthArray[item];
}
#pragma mark - AKPickerViewDelegate
- (void)pickerView:(AKPickerView *)pickerView didSelectItem:(NSInteger)item
{
    self.monthIndex = item;
    NSString *str = [NSString stringWithFormat:@"%ld",item + 1];
    [self getDatasFromInternetWithMonth:str];
}
- (void)pickerView:(AKPickerView *)pickerView configureLabel:(UILabel *const)label forItem:(NSInteger)item
{
    label.highlightedTextColor = kRGBAColor(140, 192, 39, 1.0);
    label.textColor = kRGBAColor(188, 233, 10, 1.0);
}

/**
 *  懒加载月份
 */
- (NSArray *)monthArray{
    if (!_monthArray) {
        _monthArray = @[@"1月",
                        @"2月",
                        @"3月",
                        @"4月",
                        @"5月",
                        @"6月",
                        @"7月",
                        @"8月",
                        @"9月",
                        @"10月",
                        @"11月",
                        @"12月"];
    }
    return _monthArray;
}
@end
