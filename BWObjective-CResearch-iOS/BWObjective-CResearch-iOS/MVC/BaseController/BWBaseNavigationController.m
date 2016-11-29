//
//  BWBaseNavigationController.m
//  BWObjective-CResearch-iOS
//
//  Created by BobWong on 16/10/18.
//  Copyright © 2016年 BobWong. All rights reserved.
//

#import "BWBaseNavigationController.h"

#define kFullScreenBack 0  // 是否开启全屏右滑

@implementation BWBaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (instancetype)initFullScreenBackWithRootViewController:(UIViewController *)rootViewController {
    if (self = [super initWithRootViewController:rootViewController]) {
#if kFullScreenBack == 1
        // 获取手势，并且关闭此手势
        UIGestureRecognizer *gestureRecognizer = self.interactivePopGestureRecognizer;
        gestureRecognizer.enabled = NO;
        // 获取手势的回调数组
        NSMutableArray *arrayTargets = [gestureRecognizer valueForKey:@"_targets"];
        // 获取系统的侧滑手势的回调对象和方法
        id target = [[arrayTargets firstObject] valueForKey:@"target"];
        SEL selector = NSSelectorFromString(@"handleNavigationTransition:");
        // 创建一个手势，添加上去
        UIPanGestureRecognizer *grPan = [[UIPanGestureRecognizer alloc] initWithTarget:target action:selector];
        [gestureRecognizer.view addGestureRecognizer:grPan];
#endif
        
        self.navigationBar.tintColor = [UIColor blueColor];
//        self.navigationBar.backgroundColor = [UIColor orangeColor];
        self.navigationBar.barTintColor = [UIColor orangeColor];
        
//        self.navigationBar.backIndicatorImage = [UIImage imageNamed:@"bw_icon_back_100"];
//        self.navigationBar.backIndicatorTransitionMaskImage = [UIImage imageNamed:@"bw_icon_back_100"];
    }
    return self;
}

@end
