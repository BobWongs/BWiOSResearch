//
//  BMMapView.m
//  BWObjective-CResearch-iOS
//
//  Created by BobWong on 2017/11/30.
//  Copyright © 2017年 BobWong. All rights reserved.
//

#import "BMMapView.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapLocationKit/AMapLocationKit.h>
#import "BMCustomAnnotationView.h"
#import "BMMapNavigationTool.h"

@interface BMMapView () <AMapLocationManagerDelegate, MAMapViewDelegate>

@property (nonatomic, strong) MAMapView *mapView;
@property (nonatomic, strong) UIButton *locateButton;
@property (nonatomic, strong) UIButton *zoomInButton;  ///< 放大
@property (strong, nonatomic) UIButton *zoomOutButton;  ///< 缩小

@property (strong, nonatomic) AMapLocationManager *locationManager;

@end

@implementation BMMapView

#pragma mark - Life Cycle

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUI];
    }
    return self;
}

#pragma mark - Action

- (void)locatingAction {
#warning 待研究
    NSLog(@"locatingAction");
    
#warning 待验证
    self.mapView.centerCoordinate = self.mapView.userLocation.coordinate;
}

- (void)zoomInAction {
    double zoomLevel = self.mapView.zoomLevel;
    zoomLevel += 1;
    [self.mapView setZoomLevel:zoomLevel animated:YES];
    [self refreshScalingButtons];
}

- (void)zoomOutAction {
    double zoomLevel = self.mapView.zoomLevel;
    zoomLevel -= 1;
    [self.mapView setZoomLevel:zoomLevel animated:YES];
    [self refreshScalingButtons];
}

#pragma mark - Private Method

- (void)setUI {
    [self addSubview:self.mapView];
    
    UIButton *locateButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.locateButton = locateButton;
    locateButton.frame = CGRectMake(10, CGRectGetMaxY(self.mapView.frame) - 10 - 30, 30, 30);
#warning 坑位
    [locateButton setImage:[UIImage imageNamed:@"icon_discovery_selected"] forState:UIControlStateNormal];
    [locateButton addTarget:self action:@selector(locatingAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:locateButton];
    
    UIButton *zoomOutButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.zoomOutButton = zoomOutButton;
    zoomOutButton.frame = CGRectMake(CGRectGetWidth(self.mapView.frame) - 10 - 30, CGRectGetHeight(self.mapView.frame) - 10 - 30, 30, 30);
#warning 待填坑
    [zoomOutButton setImage:[UIImage imageNamed:@"icon_discovery_selected"] forState:UIControlStateNormal];
    [zoomOutButton setImage:[UIImage imageNamed:@"icon_discovery_selected"] forState:UIControlStateDisabled];
    [zoomOutButton addTarget:self action:@selector(zoomOutAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:zoomOutButton];
    
    UIButton *zoomInButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.zoomInButton = zoomInButton;
    zoomInButton.frame = CGRectMake(CGRectGetWidth(self.mapView.frame) - 10 - 30, CGRectGetMinX(zoomOutButton.frame) - 30, 30, 30);
#warning 待填坑
    [zoomInButton setImage:[UIImage imageNamed:@"icon_discovery_selected"] forState:UIControlStateNormal];
    [zoomInButton setImage:[UIImage imageNamed:@"icon_discovery_selected"] forState:UIControlStateDisabled];
    [zoomInButton addTarget:self action:@selector(zoomInAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:zoomInButton];
}

- (void)refreshScalingButtons {
    double zoomLevel = self.mapView.zoomLevel;
    self.zoomInButton.enabled = zoomLevel < 20;
    self.zoomOutButton.enabled = zoomLevel > 3;
}

#pragma mark - AMapLocationManagerDelegate

- (void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location {
    NSLog(@"location:{lat:%f; lon:%f; accuracy:%f}", location.coordinate.latitude, location.coordinate.longitude, location.horizontalAccuracy);
}

#pragma mark - MAMapViewDelegate

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation {
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *reuseIndetifier = @"annotationReuseIndetifier";
        BMCustomAnnotationView *annotationView = (BMCustomAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:reuseIndetifier];
        if (annotationView == nil)
        {
            annotationView = [[BMCustomAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:reuseIndetifier];
        }
        // 设置为NO，用以调用自定义的calloutView
        annotationView.canShowCallout = NO;
        // 设置中心点偏移，使得标注底部中间点成为经纬度对应点
        annotationView.image = [UIImage imageNamed:@"icon_discovery_selected"];
        annotationView.centerOffset = CGPointMake(0, -30);
        annotationView.calloutView.navigationBlock = ^{
            [BMMapNavigationTool navigateWithCoordinate:annotation.coordinate];
        };
        
        return annotationView;
    }
    return nil;
}

#pragma mark - Setter and Getter

- (MAMapView *)mapView {
    if (!_mapView) {
        ///初始化地图
        _mapView = [[MAMapView alloc] initWithFrame:self.bounds];
        _mapView.delegate = self;
        ///如果您需要进入地图就显示定位小蓝点，则需要下面两行代码
        _mapView.showsUserLocation = YES;
        _mapView.userTrackingMode = MAUserTrackingModeFollow;
    }
    return _mapView;
}

- (AMapLocationManager *)locationManager {
    if (!_locationManager) {
        _locationManager = [[AMapLocationManager alloc] init];
        _locationManager.delegate = self;
    }
    return _locationManager;
}

@end
