//
//  BWResearch17VC.m
//  BWObjective-CResearch-iOS
//
//  Created by BobWong on 2017/11/29.
//  Copyright © 2017年 BobWong. All rights reserved.
//

#import "BWResearch17VC.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapLocationKit/AMapLocationKit.h>

@interface BWResearch17VC () <AMapLocationManagerDelegate, MAMapViewDelegate>

@property (strong, nonatomic) MAMapView *mapView;
@property (strong, nonatomic) AMapLocationManager *locationManager;

@end

@implementation BWResearch17VC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self amapDemo];
    [self amapLocatingDemo];
}

- (void)amapDemo {
    [[AMapServices sharedServices] setEnableHTTPS:YES];
    
    ///把地图添加至view
    [self.view addSubview:self.mapView];
    
    MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc] init];
    pointAnnotation.coordinate = CLLocationCoordinate2DMake(23.143315, 113.538691);
    pointAnnotation.title = @"体育生态公园";
    pointAnnotation.subtitle = @"公园Subtitle";
    [self.mapView addAnnotation:pointAnnotation];
}

- (void)amapLocatingDemo {
    [self.locationManager startUpdatingLocation];
}

- (void)stopAmapLocating {
    [self.locationManager stopUpdatingLocation];
}

#pragma mark - AMapLocationManagerDelegate

- (void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location {
    NSLog(@"location:{lat:%f; lon:%f; accuracy:%f}", location.coordinate.latitude, location.coordinate.longitude, location.horizontalAccuracy);
}

#pragma mark - MAMapViewDelegate

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation {
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *pointReuseIndentifier = @"pointReuseIndentifier";
        MAPinAnnotationView *annotationView = (MAPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndentifier];
        if (annotationView == nil)
        {
            annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndentifier];
        }
        annotationView.canShowCallout= YES;       //设置气泡可以弹出，默认为NO
        annotationView.animatesDrop = YES;        //设置标注动画显示，默认为NO
        annotationView.draggable = YES;        //设置标注可以拖动，默认为NO
        annotationView.pinColor = MAPinAnnotationColorPurple;
        annotationView.image = [UIImage imageNamed:@"icon_discovery_selected"];
        //设置中心点偏移，使得标注底部中间点成为经纬度对应点
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
