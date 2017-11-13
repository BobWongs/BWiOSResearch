//
//  AppDelegate.m
//  BWObjective-CResearch-iOS
//
//  Created by BobWong on 16/8/5.
//  Copyright © 2016年 BobWong. All rights reserved.
//

#import "AppDelegate.h"
#import "BWHomeViewController.h"
#import "BWMeController.h"
#import "BWBaseNavigationController.h"
#import "BWResearch2VC.h"
#import "BWResearch3VC.h"
#import "BWResearch4VC.h"
#import "BWResearch5VC.h"
#import "BWResearch6VC.h"
#import "BWResearch7VC.h"
#import "BWResearch8VC.h"
#import "BWResearch9VC.h"
#import "BWResearch10VC.h"
#import "UINavigationController+BMExtension.h"
#import "BWResearch11VC.h"
#import "BWResearch12VC.h"
#import "BWResearch13VC.h"
#import "BWResearch14VC.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    UIApplication.sharedApplication.statusBarHidden = NO;
    
    
//    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
//    NSDateComponents *comps = nil;
//    comps = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:[NSDate date]];
//    NSDateComponents *adcomps = [[NSDateComponents alloc] init];
//    [adcomps setYear:0];
//    [adcomps setMonth:0];
//    [adcomps setDay:-1];
//
//    NSDate *dateLast = [calendar dateByAddingComponents:adcomps toDate:[NSDate date] options:0];
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    [formatter setDateFormat:@"yyyyMMddHHmmss"];
//    NSString *dateStringLast = [formatter stringFromDate:dateLast];
//    NSLog(@"%@", dateStringLast);
    
    
//    BWHomeViewController *vcHome = [[BWHomeViewController alloc] init];
//    UINavigationController *nvgtVCHome = [[UINavigationController alloc] initWithRootViewController:vcHome];
//    nvgtVCHome.tabBarItem.title = @"HomeTab";
//    
//    BWMeController *vcMe = [BWMeController new];
//    vcMe.title = @"Me";
//    BWBaseNavigationController *nvgtVCMe = [[BWBaseNavigationController alloc] initFullScreenBackWithRootViewController:vcMe];
//    nvgtVCMe.tabBarItem.title = @"MeTab";
    
    
//    BWResearch2VC *researchVC = [BWResearch2VC new];
//    UINavigationController *researchNvgtVC = [[UINavigationController alloc] initWithRootViewController:researchVC];
//    researchNvgtVC.tabBarItem.title = @"Research2";
    
//    BWResearch3VC *researchVC = [BWResearch3VC new];
//    BWResearch4VC *researchVC = [BWResearch4VC new];
//    BWResearch5VC  *researchVC = [BWResearch5VC new];
    Class vcClass = [BWResearch14VC class];
    
//    UINavigationController *researchNvgtVC = [UINavigationController bmB2B_defaultStyleWithRootViewController:[vcClass new]];
    UINavigationController *researchNvgtVC = [[UINavigationController alloc] initWithRootViewController:[vcClass new]];
    researchNvgtVC.tabBarItem.title = NSStringFromClass(vcClass);
    
    UITabBarController *tabVC = [UITabBarController new];
    tabVC.viewControllers = @[researchNvgtVC];
//    tabVC.selectedIndex = 1;
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = tabVC;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    
//    for (NSInteger i = 0; i < 20000; i++) {
//        @autoreleasepool {
//            UIImage *image = [UIImage imageNamed:@"icon_discovery_selected"];
//            NSNumber *number = [NSNumber numberWithInteger:i];
//            NSLog(@"number: %@", number);
//            NSLog(@"image: %@", image);
//        }
//    }
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
