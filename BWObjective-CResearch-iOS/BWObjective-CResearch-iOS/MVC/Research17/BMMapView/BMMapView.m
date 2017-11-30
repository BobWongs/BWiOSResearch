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

@interface BMMapView () <AMapLocationManagerDelegate, MAMapViewDelegate>

@property (nonatomic, strong) MAMapView *mapView;
@property (nonatomic, strong) UIButton *locateButton;
@property (nonatomic, strong) UIButton *scalingButton;

@property (strong, nonatomic) AMapLocationManager *locationManager;

@end

@implementation BMMapView

#pragma mark - Life Cycle

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
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
        annotationView.image = [UIImage imageNamed:@"icon_discovery_selected"];
        
        // 设置为NO，用以调用自定义的calloutView
        annotationView.canShowCallout = NO;
        
        // 设置中心点偏移，使得标注底部中间点成为经纬度对应点
        annotationView.centerOffset = CGPointMake(0, -30);
        return annotationView;
    }
    return nil;
}

#pragma mark - Setter and Getter

- (MAMapView *)mapView {
    if (!_mapView) {
        ///初始化地图
        _mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
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
