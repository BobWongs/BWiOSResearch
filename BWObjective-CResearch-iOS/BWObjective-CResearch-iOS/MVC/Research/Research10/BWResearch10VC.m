//
//  BWResearch10VC.m
//  BWObjective-CResearch-iOS
//
//  Created by BobWong on 2017/9/28.
//  Copyright © 2017年 BobWong. All rights reserved.
//

#import "BWResearch10VC.h"
#import "BWTest10View.h"

@interface BWResearch10VC () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation BWResearch10VC

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self test0];
}

- (void)test0 {
    BWTest10View *view0 = [[BWTest10View alloc] initWithFrame:CGRectMake(20, 100, 300, 100)];
    view0.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:view0];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.textLabel.text = @"Text";
    return cell;
}

@end
