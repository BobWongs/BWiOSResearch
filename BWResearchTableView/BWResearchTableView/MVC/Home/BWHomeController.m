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
#import "BWSortByPinyinVC.h"
#import "BWLayoutXibVC.h"

#define bw_NSStringFromClass(Class) NSStringFromClass([Class class])

@interface BWHomeController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSArray *dataSource;

@end

@implementation BWHomeController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Home";
    _dataSource = @[bw_NSStringFromClass(BWDynamicHeightController),
                    bw_NSStringFromClass(BWFlexibleController),
                    bw_NSStringFromClass(BWHybridController),
                    bw_NSStringFromClass(BWSortByPinyinVC),
                    bw_NSStringFromClass(BWLayoutXibVC)
                    ];
    
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

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    static NSString *headerId = @"Header";
    BWCustomHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerId];
    if (!headerView) {
        headerView = [[BWCustomHeaderView alloc] initWithReuseIdentifier:headerId];
    }
    
    headerView.lbLeft.text = @"日期";
    
    return headerView;
}

@end


@implementation BWCustomHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
//        CGRect frame = self.frame;
//        frame.size.width = [UIScreen mainScreen].bounds.size.width;
//        self.frame = frame;
        
        self.backgroundColor = [UIColor grayColor];
        
        _lbLeft = [[UILabel alloc] init];
        _lbLeft.font = [UIFont systemFontOfSize:12.0];
        [self.contentView addSubview:_lbLeft];
        
        [_lbLeft mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.mas_equalTo(0);
        }];
    }
    return self;
}

@end
