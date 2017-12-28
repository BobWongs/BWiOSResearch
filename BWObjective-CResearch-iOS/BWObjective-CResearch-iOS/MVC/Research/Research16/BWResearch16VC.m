//
//  BWResearch16VC.m
//  BWObjective-CResearch-iOS
//
//  Created by BobWong on 2017/11/23.
//  Copyright © 2017年 BobWong. All rights reserved.
//

#import "BWResearch16VC.h"

@interface BWResearch16VC ()

@end

@implementation BWResearch16VC

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)continueAction:(id)sender {
    NSLog(@"self: %@", self);
    
    NSLog(@"");
    
    
}

- (IBAction)callMethod:(id)sender {
    
}

- (IBAction)testAction:(id)sender {
//    NSMethodSignature *signature = [[self class] instanceMethodSignatureForSelector:@selector(customSelector:)];
//    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
//    invocation.target = self;
//    invocation.selector = @selector(customSelector:);
//
//    NSString *argument0 = @"argument0";
//    [invocation setArgument:&argument0 atIndex:2];
//    [invocation invoke];
    
    [[self class] invokeWithTarget:self selector:@selector(customSelector:) arguments:@[@"argm0"]];
}

- (void)customSelector:(NSString *)argument0 {
    NSLog(@"Custom Selector: %@", argument0);
}

+ (void)invokeWithTarget:(id)target selector:(SEL)selector arguments:(NSArray *)arguments {
    NSMethodSignature *signature = [[target class] instanceMethodSignatureForSelector:selector];
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    invocation.target = target;
    invocation.selector = selector;

    if (arguments && arguments.count > 0) {
        [arguments enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [invocation setArgument:&obj atIndex:2 + idx];
        }];
    }
    
    [invocation invoke];
}

@end
