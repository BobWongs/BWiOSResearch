//
//  BWMeController.m
//  BWObjective-CResearch-iOS
//
//  Created by BobWong on 16/10/18.
//  Copyright © 2016年 BobWong. All rights reserved.
//

#import "BWMeController.h"
#import "BWMeSecondViewController.h"

@implementation BWMeController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(20, 100, 50, 40);
    [button setTitle:@"Push" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    
}

- (void)buttonAction:(id)sender
{
    BWMeSecondViewController *vc = [BWMeSecondViewController new];
    vc.title = @"New";
    vc.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
