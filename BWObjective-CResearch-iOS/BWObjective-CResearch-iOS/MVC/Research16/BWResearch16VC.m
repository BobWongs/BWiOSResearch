//
//  BWResearch16VC.m
//  BWObjective-CResearch-iOS
//
//  Created by BobWong on 2017/11/23.
//  Copyright © 2017年 BobWong. All rights reserved.
//

#import "BWResearch16VC.h"
#import "BWResearch16View.h"

@interface BWResearch16VC ()

@end

@implementation BWResearch16VC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self test0];
}

- (void)test0 {
    BWResearch16View *view = [[BWResearch16View alloc] initWithFrame:CGRectMake(20, 150, 200, 100)];
    view.backgroundColor = [UIColor lightTextColor];
    [self.view addSubview:view];
}

@end
