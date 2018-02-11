//
//  BWResearch15VC.m
//  BWObjective-CResearch-iOS
//
//  Created by BobWong on 2017/11/13.
//  Copyright © 2017年 BobWong. All rights reserved.
//

#import "BWResearch15VC.h"
#import "BWTest15View.h"

@interface BWResearch15VC ()

@property (strong, nonatomic) BWTest15View *test0View;

@end

@implementation BWResearch15VC

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"viewDidLoad");
    
//    [self test0];
}

- (void)test1 {
    UIImage *image = [UIImage imageNamed:@""];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
}

- (void)test0 {
    BWTest15View *test0View = [[BWTest15View alloc] init];
    self.test0View = test0View;
    test0View.backgroundColor = [UIColor grayColor];
    [self.view addSubview:test0View];
    
    UIView *view = [[UIView alloc] initWithFrame:test0View.bounds];
    view.backgroundColor = [UIColor lightTextColor];
    [test0View addSubview:view];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"viewWillAppear");
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSLog(@"viewDidAppear");
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    NSLog(@"viewWillDisappear");
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    NSLog(@"viewDidDisappear");
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    NSLog(@"viewWillLayoutSubviews");
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    NSLog(@"viewDidLayoutSubviews");
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.navigationController pushViewController:[UIViewController new] animated:YES];
}

- (IBAction)changeFrame:(id)sender {
    self.test0View.frame = CGRectMake(20, 100, 200, 50);
//    self.test0View.backgroundColor = [UIColor grayColor];
    
//    [self.view addSubview:self.test0View];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
