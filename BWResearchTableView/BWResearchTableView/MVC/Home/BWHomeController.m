//
//  BWHomeController.m
//  BWResearchTableView
//
//  Created by BobWong on 16/10/20.
//  Copyright © 2016年 BobWongStudio. All rights reserved.
//

#import "BWHomeController.h"
#import "BWDynamicHeightController.h"
#import "BWFlexibleController.h"
#import "BWHybridController.h"

#define bw_NSStringFromClass(Class) NSStringFromClass([Class class])

@interface BWHomeController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSArray *dataSource;

@end

@implementation BWHomeController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _dataSource = @[bw_NSStringFromClass(BWDynamicHeightController), bw_NSStringFromClass(BWFlexibleController), bw_NSStringFromClass(BWHybridController)];
    
    [self setUI];
}

- (void)setUI
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSource ? _dataSource.count : 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.textLabel.text = _dataSource[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    NSString *strClass = _dataSource[indexPath.row];
    Class class = NSClassFromString(strClass);
    UIViewController *vc = [[class alloc] init];
    vc.title = strClass;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
