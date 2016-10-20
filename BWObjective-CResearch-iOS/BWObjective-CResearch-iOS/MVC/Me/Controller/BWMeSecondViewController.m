//
//  BWMeSecondController.m
//  BWObjective-CResearch-iOS
//
//  Created by BobWong on 16/10/18.
//  Copyright © 2016年 BobWong. All rights reserved.
//

#import "BWMeSecondViewController.h"
#import <UIKit/UIKit.h>

@interface BWMeSecondViewController () <UIGestureRecognizerDelegate>

@end

@implementation BWMeSecondViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    /*
     导航条返回按钮自定义
     */
    CGFloat height = 30, h_bar = 44;
    CGFloat width_back_image = height / 2, width_title = 40;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, (h_bar - height) / 2, width_back_image + width_title, height);  // 15：按钮图像宽度，40：按钮文本宽度
    [button setImage:[UIImage imageNamed:@"bw_icon_back_100"] forState:UIControlStateNormal];
    [button setTitle:@"返回" forState:UIControlStateNormal];
    [button setTitleColor:UIColor.grayColor forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(btnActionBack) forControlEvents:UIControlEventTouchUpInside];

    UIBarButtonItem *itemLeft = [[UIBarButtonItem alloc] initWithCustomView:button];
    UIBarButtonItem * spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];  // 创建UIBarButtonSystemItemFixedSpace的Item，让返回按钮紧靠屏幕边缘
    spaceItem.width = -15;  // 将宽度设为负值，相对于不设值的Item，正值Item往右偏，负值Item往左偏移，设为-15则为最左边
    self.navigationItem.leftBarButtonItems = @[spaceItem, itemLeft];
    
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
}

- (void)btnActionBack {
    if (self.navigationController.viewControllers.count == 1) {
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    NSLog(@"gestureRecognizerShouldBegin");
    return NO;
}

@end

/*
 删除代码
 UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 16.5, 30)];
 imageView.image = [UIImage imageNamed:@"bw_icon_back_100"];
 [button addSubview:imageView];
 
 UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imageView.frame), 0, 50, 44)];
 label.text = @"返回";
 label.numberOfLines = 1;
 [button addSubview:label];
*/