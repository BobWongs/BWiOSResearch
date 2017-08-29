//
//  UINavigationController+BMExtension.m
//  BWObjective-CResearch-iOS
//
//  Created by BobWong on 2017/8/29.
//  Copyright © 2017年 BobWong. All rights reserved.
//

#import "UINavigationController+BMExtension.h"

@implementation UINavigationController (BMExtension)

+ (instancetype)bmB2B_defaultStyleWithRootViewController:(UIViewController *)rootViewController {
    return [self bm_rootViewController:rootViewController tintColor:nil barTintColor:nil titleColor:[UIColor whiteColor] titleFont:nil barBgImage:[UIImage imageNamed:@"nav_bg"]];
}

+ (instancetype)bm_rootViewController:(UIViewController *)rootViewController
                            tintColor:(UIColor *)tintColor
                         barTintColor:(UIColor *)barTintColor
                           titleColor:(UIColor *)titleColor
                            titleFont:(UIFont *)titleFont
                           barBgImage:(UIImage *)barBgImage {
    UINavigationController *navgVC = [[UINavigationController alloc] initWithRootViewController:rootViewController];
    if (tintColor) navgVC.navigationBar.tintColor = tintColor;
    if (barTintColor) navgVC.navigationBar.barTintColor = barTintColor;
    
    NSMutableDictionary *attribute = [NSMutableDictionary new];
    if (titleColor) attribute[NSForegroundColorAttributeName] = titleColor;
    if (titleFont) attribute[NSFontAttributeName] = titleFont;
    navgVC.navigationBar.titleTextAttributes = attribute;
    
    if (barBgImage) {
        [navgVC.navigationBar setBackgroundImage:barBgImage forBarMetrics:UIBarMetricsDefault];  // 会隐藏线条，需要加线则在Image上绘制
        navgVC.navigationBar.shadowImage = [UIImage new];  // 设置shadowImage，避免在切换视图的时候导航条的渐变色会很突兀，因为没有背景图
    }
    
    return navgVC;
}

@end
