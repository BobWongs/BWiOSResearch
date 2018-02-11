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
//#import <AMapLocationKit/AMapLocationKit.h>
#import "BMCustomAnnotationView.h"
#import "BMAmapViewController.h"

@interface BWResearch17VC () </*AMapLocationManagerDelegate, */MAMapViewDelegate>

@property (strong, nonatomic) MAMapView *mapView;
//@property (strong, nonatomic) AMapLocationManager *locationManager;

@end

@implementation BWResearch17VC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
//    [self amapDemo];
//    [self amapLocatingDemo];
}

- (IBAction)toAmapAction:(id)sender {
    MAPointAnnotation *pointAnnotation0 = [self testAnnotation0];
    
    BMAmapViewController *amapViewController = [BMAmapViewController new];
    amapViewController.annotationArray = @[pointAnnotation0];
    [self.navigationController pushViewController:amapViewController animated:YES];
}

- (void)amapDemo {
    [[AMapServices sharedServices] setEnableHTTPS:YES];
    
    ///把地图添加至view
    [self.view addSubview:self.mapView];
    
    MAPointAnnotation *pointAnnotation = [self testAnnotation0];
//    [self.mapView addAnnotation:pointAnnotation];
    [self.mapView showAnnotations:@[pointAnnotation] animated:YES];
}

- (MAPointAnnotation *)testAnnotation0 {
    MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc] init];
    pointAnnotation.coordinate = CLLocationCoordinate2DMake(23.143315, 113.538691);
    pointAnnotation.title = @"体育生态公园";
    pointAnnotation.subtitle = @"Subtitle";
    return pointAnnotation;
}

- (void)amapLocatingDemo {
//    [self.locationManager startUpdatingLocation];
}

- (void)stopAmapLocating {
//    [self.locationManager stopUpdatingLocation];
}

#pragma mark - AMapLocationManagerDelegate

//- (void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location {
//    NSLog(@"location:{lat:%f; lon:%f; accuracy:%f}", location.coordinate.latitude, location.coordinate.longitude, location.horizontalAccuracy);
//}

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

//- (AMapLocationManager *)locationManager {
//    if (!_locationManager) {
//        _locationManager = [[AMapLocationManager alloc] init];
//        _locationManager.delegate = self;
//    }
//    return _locationManager;
//}

@end
