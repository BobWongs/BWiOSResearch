//
//  UIViewController+BWExtension.m
//  BWObjective-CResearch-iOS
//
//  Created by BobWong on 16/10/17.
//  Copyright © 2016年 BobWong. All rights reserved.
//

#import "UIViewController+BWExtension.h"
#import <objc/runtime.h>

@implementation UIViewController (BWExtension)

//+ (void)load {
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        Class class = [self class];
//        
//        SEL originalSelector = @selector(viewDidLoad);
//        SEL swizzledSelector = @selector(bw_viewDidLoad);
//        
//        Method originalMethod = class_getInstanceMethod(class, originalSelector);
//        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
//        
//        BOOL success = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
//        if (success) {
//            class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
//        } else {
//            method_exchangeImplementations(originalMethod, swizzledMethod);
//        }
//    });
//}

- (void)bw_viewDidLoad {
    [self bw_viewDidLoad];
    
//    self.view.backgroundColor = [UIColor whiteColor];
}

@end
