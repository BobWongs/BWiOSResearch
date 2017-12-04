//
//  BMMapNavigationTool.m
//  BWObjective-CResearch-iOS
//
//  Created by BobWong on 2017/12/4.
//  Copyright © 2017年 BobWong. All rights reserved.
//

#import "BMMapNavigationTool.h"

@implementation BMMapNavigationTool

#pragma mark - Public Method

+ (void)navigateWithCoordinate:(CLLocationCoordinate2D)coordinate {
    NSLog(@"coordinate: %f, %f", coordinate.longitude, coordinate.latitude);
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alertController addAction:[UIAlertAction actionWithTitle:@"使用苹果地图导航" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self appleNavigateWithCoordinate:coordinate];
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"使用百度地图导航" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self baiduNavigateWithCoordinate:coordinate];
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"使用高德地图导航" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self amapNavigateWithCoordinate:coordinate];
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [[[self class] currentViewController] presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - Tool

/** 苹果自带地图导航 */
+ (void)appleNavigateWithCoordinate:(CLLocationCoordinate2D)coordinate {
    //        MKMapItem *currentLocation =[MKMapItem mapItemForCurrentLocation];
    //
    //        MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:self.coordinate addressDictionary:nil]];
    //
    //        [MKMapItem openMapsWithItems:@[currentLocation,toLocation] launchOptions:@{MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving,
    //                                                                                   MKLaunchOptionsShowsTrafficKey:[NSNumber numberWithBool:YES]}];
}

/** 高德地图导航 */
+ (void)amapNavigateWithCoordinate:(CLLocationCoordinate2D)coordinate {
    if (![self canOpenAmap]) return;
    
    NSString *applicationName = [NSBundle mainBundle].infoDictionary[@"CFBundleDisplayName"];
    NSString *schemeString = [NSString stringWithFormat:@"iosamap://navi?sourceApplication=%@&poiname=fangheng&poiid=BGVIS&lat=%.6f&lon=%.6f&dev=1&style=0", applicationName, coordinate.latitude, coordinate.longitude];
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
+ (void)baiduNavigateWithCoordinate:(CLLocationCoordinate2D)coordinate {
    
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

+ (UIViewController *)currentViewController {
#warning 待研究
    return nil;
}

@end
