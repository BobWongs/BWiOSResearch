//
//  BWResearch4VC.m
//  BWObjective-CResearch-iOS
//
//  Created by BobWong on 2017/4/25.
//  Copyright © 2017年 BobWong. All rights reserved.
//

#import "BWResearch4VC.h"

@interface BWResearch4VC () <UIScrollViewDelegate>

@end

@implementation BWResearch4VC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(20, 100, 200, 500)];
    scrollView.backgroundColor = [UIColor grayColor];
    scrollView.contentSize = CGSizeMake(2000, 1000);
    scrollView.delegate = self;
    [self.view addSubview:scrollView];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSLog(@"scrollViewDidEndDecelerating");
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    NSLog(@"- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate");
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    NSLog(@"scrollViewDidEndScrollingAnimation");
}

@end
