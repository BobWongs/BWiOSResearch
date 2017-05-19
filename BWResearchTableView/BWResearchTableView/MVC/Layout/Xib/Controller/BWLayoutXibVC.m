//
//  BWLayoutXibVC.m
//  BWResearchTableView
//
//  Created by BobWong on 16/11/29.
//  Copyright © 2016年 BobWongStudio. All rights reserved.
//

#import "BWLayoutXibVC.h"
#import "BWLayoutXibCell.h"
#import "UITableViewCell+BWExtension.h"

@interface BWLayoutXibVC ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) BWLayoutXibCell *cellToCalculate;

@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) NSMutableArray *arrayHeight;

@end

@implementation BWLayoutXibVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dataSource = [NSMutableArray new];
    _arrayHeight = [NSMutableArray new];
    
    __block NSString *string = @"text";
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        for (NSInteger i = 0; i < 20; i++) {
            if (i == 0) {
                [_dataSource addObject:string];
                continue ;
            }
            
            string = [string stringByAppendingString:[NSString stringWithFormat:@"%@\ntexttext", string]];
            [_dataSource addObject:string];
        }
        
        [self calculateCellHeight];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    });
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSource ? _dataSource.count : 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BWLayoutXibCell *cell = [BWLayoutXibCell bw_cellXibWithTableView:tableView];
    [self setData:_dataSource[indexPath.row] InCell:cell];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
        [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (_arrayHeight.count > 0 && _arrayHeight[indexPath.row]) {
        return [_arrayHeight[indexPath.row] floatValue];
    }
    
    return 200;
}

- (void)setData:(NSString *)address InCell:(BWLayoutXibCell *)cell {
    cell.lbOrder.text = @"this is an order code";
    cell.lbName.text = @"bobwong";
    [cell.btnPhone setTitle:@"10001" forState:UIControlStateNormal];
    cell.lbAddress.text = address;
    cell.lbSumMoney.text = @"money";
    cell.lbTargetAmount.text = @"target amount";
    cell.lbRealAmount.text = @"real amount";
}

- (void)calculateCellHeight {
    if (!_cellToCalculate) {
        _cellToCalculate = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([BWLayoutXibCell class]) owner:nil options:nil] firstObject];  // 使用从Bundle中加载资源的方式
    }
    
    for (NSInteger index = 0 ; index < _dataSource.count; index++) {
        [self setData:_dataSource[index] InCell:_cellToCalculate];
        
        CGFloat height = [_cellToCalculate.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
        height += 1.0;  // 加上线条高度
        
        [_arrayHeight addObject:@(height)];
    }
}

@end
