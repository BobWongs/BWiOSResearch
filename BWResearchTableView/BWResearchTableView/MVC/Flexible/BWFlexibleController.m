//
//  BWFlexibleController.m
//  BWResearchTableView
//
//  Created by BobWong on 16/10/20.
//  Copyright © 2016年 BobWongStudio. All rights reserved.
//

#import "BWFlexibleController.h"
#import "BWFlexibleCell.h"

#define HEIGHT_SHORT 120

#define kHeightShort @"kHeightShort"
#define kHeightNormal @"kHeightNormal"
#define kIsUnfold @"kIsUnfold"

@interface BWFlexibleController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) BWFlexibleCell *cellToCalculate;

@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) NSMutableArray *arrayHeight;

@end

@implementation BWFlexibleController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _dataSource = [NSMutableArray array];
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
    
    _arrayHeight = [NSMutableArray array];
    [self calculateCellHeight];
    
    [self setUI];
}

- (void)setUI
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView = tableView;
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
}

- (void)calculateCellHeight {
    if (!_cellToCalculate) {
        _cellToCalculate = [[BWFlexibleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        [_cellToCalculate setTextLabelUnfold:YES];
    }
    
    for (NSInteger index = 0 ; index < _dataSource.count; index++) {
        _cellToCalculate.lbText.text = _dataSource[index];
        
        CGFloat height = [_cellToCalculate.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
        height += 1.0;  // 加上线条高度
        
        CGFloat height_short = height >= HEIGHT_SHORT ? HEIGHT_SHORT : height;
        
        NSDictionary *dict = @{
                               kHeightShort: @(height_short),
                               kHeightNormal: @(height),
                               kIsUnfold: @(NO)
                               };
        NSMutableDictionary *dictMutable = [NSMutableDictionary dictionaryWithDictionary:dict];
        [_arrayHeight addObject:dictMutable];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSource ? _dataSource.count : 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"Cell";
    BWFlexibleCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[BWFlexibleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.clipsToBounds = YES;
    }
    
    NSInteger row = indexPath.row;
    cell.lbText.text = _dataSource[row];
    
    BW_WEAK_SELF;
    cell.blockChange = ^{
        BW_STRONG_SELF;
        
        NSMutableDictionary *dictMuta = weakSelf.arrayHeight[row];
        BOOL isUnfold = ![dictMuta[kIsUnfold] boolValue];
        dictMuta[kIsUnfold] = @(isUnfold);
        
        [strongSelf.tableView reloadData];
    };
    
    NSMutableDictionary *dictMuta = _arrayHeight[row];
    if ([[self class] isEqualFloatA:[dictMuta[kHeightNormal] floatValue] floatB:[dictMuta[kHeightShort] floatValue]]) {
        [cell setTextLabelUnfold:YES];
    } else {
        [cell setTextLabelUnfold:[dictMuta[kIsUnfold] boolValue]];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dict = _arrayHeight[indexPath.row];
    CGFloat height = [dict[kIsUnfold] boolValue] ? [dict[kHeightNormal] floatValue] : [dict[kHeightShort] floatValue];
    
    return height;
}

#pragma mark - 比较浮点数的大小

bool float_equals(float a,float b) {
    if (fabsf(a - b) <= 1e-6) return true;
    
    return false;
}

+ (BOOL)isEqualFloatA:(float)a
               floatB:(float)b {
    NSNumber *numA = [NSNumber numberWithFloat:a];
    NSNumber *numB = [NSNumber numberWithFloat:b];
    
    if ([numA compare:numB] == NSOrderedSame) {
        return YES;
    }
    return NO;
}

@end
