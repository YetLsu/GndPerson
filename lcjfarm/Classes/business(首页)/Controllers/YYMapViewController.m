//
//  YYMapViewController.m
//  lcjfarm
//
//  Created by wyy on 16/7/8.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import "YYMapViewController.h"
#import "YYFruitShopModel.h"
#import "YYPickTableViewModel.h"

#import "YYMapBottomView.h"
#import <MapKit/MapKit.h>

#import "YYUserTool.h"

@interface YYMapViewController ()<CLLocationManagerDelegate, MKMapViewDelegate>{
    YYFruitShopModel * _shopModel;
    YYPickTableViewModel *_pickModel;
    NSInteger _tag;
}
@property (nonatomic, strong) CLGeocoder *geocoder;

@property (nonatomic, strong) CLLocationManager *manager;
/**
 *  地图
 */
@property (nonatomic, weak) MKMapView *mapView;
@end

@implementation YYMapViewController
- (CLGeocoder *)geocoder{
    if (!_geocoder) {
        _geocoder = [[CLGeocoder alloc] init];
    }
    return _geocoder;
}
- (CLLocationManager *)manager{
    if (!_manager) {
        _manager = [[CLLocationManager alloc] init];
        _manager.delegate = self;
        //设置定位精度
        _manager.desiredAccuracy = kCLLocationAccuracyBest;
        //定位频率,每隔10米定位一次
        CLLocationDistance distance = 10;
        _manager.distanceFilter = distance;
    }
    return _manager;
}
/**
 *  店铺模型创建方法,tag1
 */
- (instancetype)initWithFruitShopModel:(YYFruitShopModel *)shopModel andTag:(NSInteger)tag{
    if (self = [super init]) {
        _shopModel = shopModel;
        _tag = tag;
    }
    return self;
}

/**
 *  采摘模型创建方法,tag2
 */
- (instancetype)initWithPickModel:(YYPickTableViewModel *)pickModel andTag:(NSInteger)tag{
    if (self = [super init]) {
        _pickModel = pickModel;
        _tag = tag;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    //增加上面部分的地图控件和底部的View
    [self addMapViewAndBottomView];
    
    //增加左上角返回按钮
    [self addLeftBackBtn];
    
    //开始定位
    [self.manager startUpdatingLocation];
    
    YYUserModel *userModel = [YYUserTool userModel];
    
    double deltaLat;
    double deltaLon;
    if (_tag == 1) {
        deltaLat = fabs(userModel.lat.doubleValue - _shopModel.lat.doubleValue);
        deltaLon = fabs(userModel.lon.doubleValue - _shopModel.lon.doubleValue);
    }
    else if (_tag == 2){
        deltaLat = fabs(userModel.lat.doubleValue - _pickModel.lat.doubleValue);
        deltaLon = fabs(userModel.lon.doubleValue - _pickModel.lon.doubleValue);
    }
    // 设置用户的位置为地图的中心点
    MKCoordinateSpan span = MKCoordinateSpanMake(deltaLat * 2.5, deltaLon * 2.5);
    
    
    [self.mapView setRegion:MKCoordinateRegionMake(CLLocationCoordinate2DMake(userModel.lat.doubleValue, userModel.lon.doubleValue), span) animated:YES];
    
    //添加店铺大头针
    [self addAnnotation];
}
#pragma mark 增加上面部分的地图控件和底部的View
/**
 *  增加上面部分的地图控件和底部的View
 */
- (void)addMapViewAndBottomView{
    //增加底部的View
    YYMapBottomView *bottomView = [[[NSBundle mainBundle] loadNibNamed:@"YYMapBottomView" owner:nil options:nil] lastObject];
    [self.view addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.view);
        make.height.mas_equalTo(185);
    }];
    if (_tag == 1) {
        bottomView.shopModel = _shopModel;
    }
    else{
        bottomView.pickModel = _pickModel;
    }
#pragma mark 增加地图导航按钮的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(mapNavClick) name:kNotificationNavigationMapClick object:bottomView];
    //增加地图控件
    MKMapView *mapView = [[MKMapView alloc] init];
    [self.view addSubview:mapView];
    self.mapView = mapView;
    [mapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(self.view);
        make.bottom.mas_equalTo(bottomView.mas_top);
    }];
    //设置地图的样式
    self.mapView.mapType = MKMapTypeStandard;
    //设置地图的跟随方式
    self.mapView.userTrackingMode = MKUserTrackingModeFollowWithHeading;
    self.mapView.delegate = self;
}
#pragma mark 地图导航按钮被点击
/**
 *  地图导航按钮被点击
 */
- (void)mapNavClick{
    
    //目的地位置
    CLLocationCoordinate2D destCoordinate;
    if (_tag == 1) {
        destCoordinate = CLLocationCoordinate2DMake(_shopModel.lat.doubleValue, _shopModel.lon.doubleValue);
    }
    else if (_tag == 2){
        destCoordinate = CLLocationCoordinate2DMake(_pickModel.lat.doubleValue, _pickModel.lon.doubleValue);
    }

    
    CLLocation *destLocation = [[CLLocation alloc] initWithLatitude:destCoordinate.latitude longitude:destCoordinate.longitude];
    [self.geocoder reverseGeocodeLocation:destLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        CLPlacemark *destCp = [placemarks firstObject];
        MKPlacemark *destMp = [[MKPlacemark alloc] initWithPlacemark:destCp];
        MKMapItem *destItem = [[MKMapItem alloc] initWithPlacemark:destMp];
        //获取当前位置
        MKMapItem *sourceItem = [MKMapItem mapItemForCurrentLocation];
        
        
        // 1.将起点和终点item放入数组中
        NSArray *items = @[sourceItem, destItem];
        
        // 2.设置Options参数(字典)
        NSDictionary *options = @{
                                  MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeWalking,
                                  MKLaunchOptionsMapTypeKey : @(MKMapTypeSatellite),
                                  MKLaunchOptionsShowsTrafficKey : @YES
                                  };
        
        [MKMapItem openMapsWithItems:items launchOptions:options];
        
    }];

}

#pragma mark 增加左上角返回按钮
/**
 *  增加左上角返回按钮
 */
- (void)addLeftBackBtn{
    UIButton *btn = [[UIButton alloc] init];
    [self.view addSubview:btn];
    [btn setImage:[UIImage imageNamed:@"home_map_previous"] forState:UIControlStateNormal];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view);
        make.top.mas_equalTo(20);
        make.size.mas_equalTo(CGSizeMake(52.5, 44));
    }];
    [btn bk_addEventHandler:^(id sender) {
        [self.navigationController popViewControllerAnimated:YES];
    } forControlEvents:UIControlEventTouchUpInside];
    
}
/**
 *  添加大头针
 *
 */
- (void)addAnnotation{
    MKPointAnnotation *myannotation = [[MKPointAnnotation alloc] init];
    
    if (_tag == 1) {
        myannotation.coordinate = CLLocationCoordinate2DMake(_shopModel.lat.doubleValue, _shopModel.lon.doubleValue);
        myannotation.title = _shopModel.name;
        myannotation.subtitle = [NSString stringWithFormat:@"营业时间:%@", _shopModel.time];
    }
    else if (_tag == 2){
        myannotation.coordinate = CLLocationCoordinate2DMake(_pickModel.lat.doubleValue, _pickModel.lon.doubleValue);
        myannotation.title = _pickModel.name;
        myannotation.subtitle = [NSString stringWithFormat:@"营业时间:%@", _pickModel.time];
    }

    [self.mapView addAnnotation:myannotation];
}

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        
        return nil;
    }
    
    static NSString *ID = @"YYMapViewController";
    MKAnnotationView *view = [mapView dequeueReusableAnnotationViewWithIdentifier:ID];
    if (!view) {
        view = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:ID];
    }
    //设置标注的图片
    view.image=[UIImage imageNamed:@"home_shop_address_map_icon"];
    //点击显示图详情视图 必须MJPointAnnotation对象设置了标题和副标题
    view.canShowCallout=YES;
   
    //设置拖拽 可以通过点击不放进行拖拽
    view.draggable=YES;
    return view;
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
//    YYLog(@"定位到用户当前位置");
    
    double deltaLat;
    double deltaLon;
    if (_tag == 1) {
        deltaLat = fabs(userLocation.coordinate.latitude - _shopModel.lat.doubleValue);
        deltaLon = fabs(userLocation.coordinate.longitude - _shopModel.lon.doubleValue);
    }
    else if (_tag == 2){
        deltaLat = fabs(userLocation.coordinate.latitude - _pickModel.lat.doubleValue);
        deltaLon = fabs(userLocation.coordinate.longitude - _pickModel.lon.doubleValue);
    }
    // 设置用户的位置为地图的中心点
    MKCoordinateSpan span = MKCoordinateSpanMake(deltaLat * 2.5, deltaLon * 2.5);

    [self.mapView setRegion:MKCoordinateRegionMake(userLocation.coordinate, span) animated:YES];

}
- (void)mapViewWillStartLoadingMap:(MKMapView *)mapView{
    YYLog(@"map");
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
