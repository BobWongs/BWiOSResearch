//
//  BWResearch12VC.m
//  BWObjective-CResearch-iOS
//
//  Created by BobWong on 2017/10/10.
//  Copyright © 2017年 BobWong. All rights reserved.
//

#import "BWResearch12VC.h"
#import <UIColor+YYAdd.h>

@interface BWResearch12VC ()

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIView *test1View0;

@end

@implementation BWResearch12VC

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self test1];
//    [self test2];
    [self test3];
}

- (void)test0 {
    CGFloat sw = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = 28;
    CGFloat y = (44 - height) / 2;
    //    CGFloat width = sw - 20 - 48;
    CGFloat width = sw;
    
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, y, width, height)];
    searchBar.placeholder = @"搜索商品";
    self.navigationItem.titleView = searchBar;
}

- (void)test1 {
    self.test1View0.layer.cornerRadius = 4.0;
//    self.test1View0.clipsToBounds = YES;
    
    self.test1View0.layer.shadowColor = [UIColor colorWithHexString:@"0656f1"].CGColor;
    self.test1View0.layer.shadowRadius = 4;
    self.test1View0.layer.shadowOpacity = 0.2;
    self.test1View0.layer.shadowOffset = CGSizeMake(0, 0);
}

- (void)test2 {
    self.title = @"标题";
    
    UINavigationBar *bar = self.navigationController.navigationBar;
    NSLog(@"attr is %@", bar.titleTextAttributes);
    NSLog(@"tint color %@", bar.tintColor);
}

- (void)test3 {
    CGFloat sw = [UIScreen mainScreen].bounds.size.width;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, sw, 44)];
    view.backgroundColor = [UIColor lightGrayColor];
    self.navigationItem.titleView = view;
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:[UIView new]];
    UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];  // 创建
    self.navigationItem.leftBarButtonItems = @[spaceItem, leftItem];
}

@end
