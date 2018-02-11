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
#import "BWResearch15VC.h"
#import "BWResearch16VC.h"
#import "BWResearch17VC.h"
#import <AMapFoundationKit/AMapFoundationKit.h>
#import "BWNetworkResearchVC.h"
#import "BW3DTouchViewController.h"
#import "BWAnimationViewController.h"
#import "BWCoreDataViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
//    [AMapServices sharedServices].apiKey = @"da91820d52ede7ec7c5c2375944283d6";  // Amap
    
//    UIApplication.sharedApplication.statusBarHidden = NO;
    
    Class vcClass = [BWCoreDataViewController class];
    
//    UINavigationController *researchNvgtVC = [UINavigationController bmB2B_defaultStyleWithRootViewController:[vcClass new]];
    UINavigationController *researchNvgtVC = [[UINavigationController alloc] initWithRootViewController:[vcClass new]];
    researchNvgtVC.tabBarItem.title = NSStringFromClass(vcClass);
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
//    self.window.rootViewController = tabVC;
    self.window.rootViewController = researchNvgtVC;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    NSLog(@"applicationWillResignActive");
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
//    [NSTimer scheduledTimerWithTimeInterval:1.0 block:^(NSTimer * _Nonnull timer) {
//        static NSInteger num = 0;
//        NSLog(@"num: %@", @(num).stringValue);
//        num += 1;
//    } repeats:YES];
    
    NSLog(@"applicationDidEnterBackground");
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
