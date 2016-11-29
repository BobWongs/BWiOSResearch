//
//  BWDynamicHeightController.m
//  BWResearchTableView
//
//  Created by BobWong on 16/10/20.
//  Copyright © 2016年 BobWongStudio. All rights reserved.
//

#import "BWDynamicHeightController.h"
#import "BWDynamicCell.h"

@interface BWDynamicHeightController () <UITableViewDataSource, UITableViewDelegate, UIGestureRecognizerDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) NSMutableArray *arrayHeight;

@property (nonatomic, strong) BWDynamicCell *cellToCalculate;

@end

@implementation BWDynamicHeightController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _dataSource = [NSMutableArray array];
    _arrayHeight = [NSMutableArray array];
    NSString *text = @"Textgeiniwan123";
    NSString *strToAdd = @"";
    for (NSInteger index = 0; index < 50; index++) {
        if (index == 0) {
            strToAdd = text;
        } else {
            strToAdd = [NSString stringWithFormat:@"%@\n%@", strToAdd, text];
        }
        
        [_dataSource addObject:strToAdd];
    }
    
    [self calculateCellHeight];
    [self setUI];
}

- (void)calculateCellHeight {
    if (!_cellToCalculate) {
        _cellToCalculate = [[BWDynamicCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    }
    
    for (NSInteger index = 0 ; index < _dataSource.count; index++) {
        [self setCellUI:_cellToCalculate WithModel:_dataSource[index]];
        
//        [_cellToCalculate setNeedsUpdateConstraints];
//        [_cellToCalculate updateConstraintsIfNeeded];
//        [_cellToCalculate setNeedsLayout];
//        [_cellToCalculate layoutIfNeeded];
//        [_cellToCalculate layoutSubviews];
        
        CGFloat height = [_cellToCalculate.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
        height += 1.0;  // 加上线条高度
        [_arrayHeight addObject:@(height)];
    }
}

- (void)setCellUI:(BWDynamicCell *)cell
        WithModel:(NSString *)string {
    cell.lbText.text = string;
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
    BWDynamicCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[BWDynamicCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.lbText.text = _dataSource[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [_arrayHeight[indexPath.row] floatValue];
}

@end
