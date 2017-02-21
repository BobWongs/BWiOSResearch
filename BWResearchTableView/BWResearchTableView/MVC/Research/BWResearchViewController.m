//
//  BWResearchViewController.m
//  BWResearchTableView
//
//  Created by BobWong on 2017/2/20.
//  Copyright © 2017年 BobWongStudio. All rights reserved.
//

#import "BWResearchViewController.h"

@interface BWResearchViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UIView *viewHeader;  ///< Header

@property (strong, nonatomic) NSMutableArray *dataSource;  ///< Data source

@end

@implementation BWResearchViewController

#pragma mark - View Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Research";
    self.view.backgroundColor = [UIColor blueColor];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(action)];
    self.navigationItem.rightBarButtonItem = item;
    
    [self setData];
    [self setUI];
    [self setConstraints];
    [self loadData];
}

#pragma mark - Public Method

#pragma mark - Action

- (void)action {
    CGRect frame = self.viewHeader.frame;
    frame.size.height = 100;
    self.viewHeader.frame = frame;
}

#pragma mark - Network

#pragma mark - Custom Delegate

#pragma mark - System Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
    return self.dataSource ? self.dataSource.count : 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.textLabel.text = @"one";
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
}

#pragma mark - Private Method

- (void)setData
{
    self.dataSource = [NSMutableArray new];
}

- (void)setUI
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:tableView];
    
    UIView *viewHeader = [[UIView alloc] init];
    self.viewHeader = viewHeader;
    viewHeader.backgroundColor = [UIColor greenColor];
    tableView.tableHeaderView = viewHeader;
    
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    
//    [viewHeader mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(0);
//        make.width.mas_equalTo(320);
//        make.top.mas_equalTo(0);
//        make.height.mas_equalTo(150);
//    }];
    
    viewHeader.frame = CGRectMake(0, 0, 320, 200);
}

- (void)setConstraints
{
    
}

- (void)loadData
{
    
}

#pragma mark - Getter and Setter

@end
