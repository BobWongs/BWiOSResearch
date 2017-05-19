//
//  BWResearch3VC.m
//  BWObjective-CResearch-iOS
//
//  Created by BobWong on 2017/3/1.
//  Copyright © 2017年 BobWong. All rights reserved.
//

#import "BWResearch3VC.h"
#import <Masonry.h>

@interface BWResearch3VC () <UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate>

@end

@implementation BWResearch3VC

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    
    return NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    // ---------- TextField ----------
    
//    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(20, 150, 200, 50)];
//    textField.delegate = self;
//    textField.returnKeyType = UIReturnKeyGo;
//    textField.backgroundColor = [UIColor greenColor];
//    [self.view addSubview:textField];
//    
//    // ---------- TextField ----------
//    
//    
//    // ---------- Gradient ----------
//    CAGradientLayer *gLayer = [CAGradientLayer layer];
//    gLayer.frame = CGRectMake(60, 150, 200, 100);
////    gLayer.opacity = 0.3;
//    
////    gLayer.startPoint = CGPointMake(0, 0);
////    gLayer.endPoint = CGPointMake(0, 1);
//    
//    UIColor *colorBegin = [UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:0.0];
//    UIColor *colorEnd = [UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:0.6];
//    gLayer.colors = @[(__bridge id)colorBegin.CGColor, (__bridge id)colorEnd.CGColor];
//
//    [self.view.layer addSublayer:gLayer];
    
//    //初始化CAGradientlayer对象，使它的大小为UIView的大小
//    self.gradientLayer = [CAGradientLayer layer];
//    self.gradientLayer.frame = self.theView.bounds;
//    
//    //设置渐变区域的起始和终止位置（范围为0-1）
//    self.gradientLayer.startPoint = CGPointMake(0, 0);
//    self.gradientLayer.endPoint = CGPointMake(0, 1);
//    
//    //设置颜色数组
//    self.gradientLayer.colors = @[(__bridge id)[UIColor blueColor].CGColor,
//                                  (__bridge id)[UIColor redColor].CGColor];
//    
//    //设置颜色分割点（范围：0-1）
//    self.gradientLayer.locations = @[@(0.5f), @(1.0f)];
    // ---------- Gradient ----------
    
    
    // ---------- UILabel deleted line ----------
//    UILabel *label = [[UILabel alloc] init];
//    label.text = @"hello";
//    label.numberOfLines = 1;
//    label.textAlignment = NSTextAlignmentLeft;
//    label.textColor = [UIColor blackColor];
//    [self.view addSubview:label];
//
//    NSDictionary *attribtues = @{
//                                 NSStrikethroughStyleAttributeName: @(NSUnderlineStyleSingle),
//                                 NSStrikethroughColorAttributeName: [UIColor redColor]
//                                 };
//    NSAttributedString * attr = [[NSAttributedString alloc] initWithString:@"label" attributes:attribtues];
//    label.attributedText = attr;
//    
//    [label mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(20);
//        make.right.mas_equalTo(-100);
//        make.top.mas_equalTo(150);
//        make.height.mas_equalTo(50);
//    }];
    
    
    // ---------- UIScrollView KVO ----------
//    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(10, 100, 200, 300)];
//    scrollView.backgroundColor = [UIColor grayColor];
//    scrollView.contentSize = CGSizeMake(0, 1000);
//    [self.view addSubview:scrollView];
//
//    [scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    
    
    // ---------- UIButton image and title inset ----------
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//    button.frame = CGRectMake(100, 200, 200, 50);
//    [button setTitle:@"ButtonTitle" forState:UIControlStateNormal];
//    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [button setImage:[UIImage imageNamed:@"icon_discovery_selected"] forState:UIControlStateNormal];
//    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
//    button.backgroundColor = [UIColor greenColor];
//    [self.view addSubview:button];
//    
//    CGFloat space = 20;
//    CGFloat space_divide = space / 2;
//    button.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
//    button.titleEdgeInsets = UIEdgeInsetsMake(0, 30, 0, 0);
    
    
    // ---------- UITableView ----------
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 100)];
    bgView.backgroundColor = [UIColor grayColor];
    tableView.backgroundView = bgView;
    
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.backgroundColor = [UIColor clearColor];
    }
    cell.textLabel.text = @"Hello";
    
    return cell;
}

- (void)buttonAction:(id)sender
{
    NSLog(@"button action");
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
//    NSLog(@"change is %@", change);
    
    CGPoint offset = [change[NSKeyValueChangeNewKey] CGPointValue];
    CGFloat offsetY = offset.y;
    
    NSLog(@"offset y is %f", offsetY);
}

@end
