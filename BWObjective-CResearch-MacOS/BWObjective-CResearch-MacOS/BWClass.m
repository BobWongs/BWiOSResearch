//
//  BWClass.m
//  BWObjective-CResearch-MacOS
//
//  Created by BobWong on 2017/3/10.
//  Copyright © 2017年 BobWong. All rights reserved.
//

#import "BWClass.h"
#import <objc/runtime.h>

NSString *const BWKey = @"BWKey";

@implementation BWClass

void myMethodIMP(id self, SEL _cmd)
{
    NSLog(@"myMethodIMP");
}

+ (BOOL)resolveInstanceMethod:(SEL)sel {
    // IMP: void(*)(void)函数指针
    class_addMethod(self, sel, (IMP)myMethodIMP, "v@:");
    
    return YES;
}

- (void)doSomething {
    NSLog(@"do something");
}

- (id)forwardingTargetForSelector:(SEL)aSelector {
    NSLog(@"forwardingTargetForSelector");
    return @[@"123", @"321"];
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    NSLog(@"forwardInvocation");
}

@end
