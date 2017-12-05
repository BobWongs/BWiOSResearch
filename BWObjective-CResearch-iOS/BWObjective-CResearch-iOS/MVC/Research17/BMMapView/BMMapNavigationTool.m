//
//  BMMapNavigationTool.m
//  BWObjective-CResearch-iOS
//
//  Created by BobWong on 2017/12/4.
//  Copyright © 2017年 BobWong. All rights reserved.
//

#import "BMMapNavigationTool.h"
#import <MapKit/MapKit.h>
#import <MAMapKit/MAAnnotation.h>

@implementation BMMapNavigationTool

#pragma mark - Public Method

+ (void)navigateFrom:(id<MAAnnotation>)fromAnnotation to:(id<MAAnnotation>)toAnnotation {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    if ([self canOpenAmap]) {
        [alertController addAction:[UIAlertAction actionWithTitle:@"高德地图" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self appleNavigateFrom:fromAnnotation to:toAnnotation];
        }]];
    }
    if ([self canOpenBaiduMap]) {
        [alertController addAction:[UIAlertAction actionWithTitle:@"百度地图" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self baiduMapNavigateFrom:fromAnnotation to:toAnnotation];
        }]];
    }
    if ([self canOpenQQMap]) {
        [alertController addAction:[UIAlertAction actionWithTitle:@"腾讯地图" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self qqMapNavigateFrom:fromAnnotation to:toAnnotation];
        }]];
    }
    [alertController addAction:[UIAlertAction actionWithTitle:@"Apple 地图" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self amapNavigateFrom:fromAnnotation to:toAnnotation];
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [[[self class] currentViewController] presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - Tool

/** Apple地图导航 */
+ (void)appleNavigateFrom:(id<MAAnnotation>)fromAnnotation to:(id<MAAnnotation>)toAnnotation {
    MKMapItem *currentLocation =[MKMapItem mapItemForCurrentLocation];
    MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:toAnnotation.coordinate addressDictionary:nil]];
    [MKMapItem openMapsWithItems:@[currentLocation, toLocation] launchOptions:@{MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving,
                                                                                MKLaunchOptionsShowsTrafficKey:[NSNumber numberWithBool:YES]}];
}

/** 高德地图导航 */
+ (void)amapNavigateFrom:(id<MAAnnotation>)fromAnnotation to:(id<MAAnnotation>)toAnnotation {
    if (![self canOpenAmap]) return;
    
    CLLocationCoordinate2D toCoordinate = toAnnotation.coordinate;
    NSString *applicationName = [self appName];
    NSString *schemeString = [NSString stringWithFormat:@"iosamap://navi?sourceApplication=%@&poiname=fangheng&poiid=BGVIS&lat=%.6f&lon=%.6f&dev=1", applicationName, toCoordinate.latitude, toCoordinate.longitude];
    [self openWithSchemeString:schemeString];
}

+ (BOOL)canOpenAmap {
    NSURL *scheme = [NSURL URLWithString:@"iosamap://"];
    BOOL canOpen = [[UIApplication sharedApplication] canOpenURL:scheme];
    if (!canOpen) {
        NSLog(@"未安装高德地图");
        return NO;
    }
    return YES;
}

/** 百度地图导航 */
+ (void)baiduMapNavigateFrom:(id<MAAnnotation>)fromAnnotation to:(id<MAAnnotation>)toAnnotation {
    if (![self canOpenBaiduMap]) return;
    
    CLLocationCoordinate2D toCoordinate = toAnnotation.coordinate;
    NSString *applicationName = [self appName];
    NSString *schemeString = [NSString stringWithFormat:@"baidumap://map/direction?destination=%f,%f&mode=driving&=gcj02coord_type&src=%@", toCoordinate.latitude, toCoordinate.longitude, applicationName];
    [self openWithSchemeString:schemeString];
}

+ (BOOL)canOpenBaiduMap {
    NSURL *scheme = [NSURL URLWithString:@"baidumap://"];
    BOOL canOpen = [[UIApplication sharedApplication] canOpenURL:scheme];
    if (!canOpen) {
        NSLog(@"未安装百度地图");
        return NO;
    }
    return YES;
}

+ (void)qqMapNavigateFrom:(id<MAAnnotation>)fromAnnotation to:(id<MAAnnotation>)toAnnotation {
    if (![self canOpenQQMap]) return;
    
    CLLocationCoordinate2D fromCoordinate = fromAnnotation.coordinate;
    CLLocationCoordinate2D toCoordinate = toAnnotation.coordinate;
    NSString *applicationName = [self appName];
    NSString *schemeString = [NSString stringWithFormat:@"qqmap://map/routeplan?type=drive&fromcoor=%f,%f&tocoord=%f,%f&coord_type=2&policy=0&referer=%@", fromCoordinate.latitude, fromCoordinate.latitude, toCoordinate.latitude, toCoordinate.longitude, applicationName];
    [self openWithSchemeString:schemeString];
}

+ (BOOL)canOpenQQMap {
    NSURL *scheme = [NSURL URLWithString:@"qqmap://"];
    BOOL canOpen = [[UIApplication sharedApplication] canOpenURL:scheme];
    if (!canOpen) {
        NSLog(@"未安装腾讯地图");
        return NO;
    }
    return YES;
}

+ (void)openWithSchemeString:(NSString *)schemeString {
    NSURL *scheme = [NSURL URLWithString:schemeString];
    if ([[UIDevice currentDevice].systemVersion integerValue] >= 10) {  // iOS10以后,使用新API
        [[UIApplication sharedApplication] openURL:scheme options:@{} completionHandler:^(BOOL success) { NSLog(@"scheme调用结束"); }];
    }
    else {  // iOS10以前,使用旧API
        [[UIApplication sharedApplication] openURL:scheme];
    }
}

+ (NSString *)appName {
    return [NSBundle mainBundle].infoDictionary[@"CFBundleDisplayName"];
}

+ (UIViewController *)currentViewController {
    UIViewController *rootVC = UIApplication.sharedApplication.keyWindow.rootViewController;
    if ([rootVC isKindOfClass:[UINavigationController class]]) {
        UINavigationController *navRootVC = (UINavigationController *)rootVC;
        return navRootVC.viewControllers.lastObject;
    }
    if ([rootVC isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tabBarRootVC = (UITabBarController *)rootVC;
        UIViewController *selectedVC = tabBarRootVC.selectedViewController;
        if ([selectedVC isKindOfClass:[UINavigationController class]]) {
            UINavigationController *navSelectedVC = (UINavigationController *)selectedVC;
            return navSelectedVC.viewControllers.lastObject;
        }
        return selectedVC;
    }
    return rootVC;
}

@end
