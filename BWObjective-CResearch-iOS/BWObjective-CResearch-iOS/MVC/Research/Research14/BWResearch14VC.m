//
//  BWResearch14VC.m
//  BWObjective-CResearch-iOS
//
//  Created by BobWong on 2017/11/7.
//  Copyright © 2017年 BobWong. All rights reserved.
//

#import "BWResearch14VC.h"

@interface BWResearch14VC ()

@property (weak, nonatomic) IBOutlet UIView *view0;

@end

@implementation BWResearch14VC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self test0];
}

- (void)test0 {
    self.view0.layer.shadowColor = [UIColor blackColor].CGColor;
    self.view0.layer.shadowRadius = 2.0;
    self.view0.layer.shadowOpacity = 0.2;
    self.view0.layer.shadowOffset = CGSizeMake(0, 4);
}

@end
