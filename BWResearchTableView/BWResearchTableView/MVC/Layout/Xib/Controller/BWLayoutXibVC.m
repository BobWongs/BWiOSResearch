//
//  BWLayoutXibVC.m
//  BWResearchTableView
//
//  Created by BobWong on 16/11/29.
//  Copyright © 2016年 BobWongStudio. All rights reserved.
//

#import "BWLayoutXibVC.h"

@interface BWLayoutXibVC ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation BWLayoutXibVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dataSource = [NSMutableArray new];
    NSString *string = @"text";
    for (NSInteger i = 0; i < 20; i++) {
        if (i == 0) {
            [_dataSource addObject:string];
            continue ;
        }
        
        string = [string stringByAppendingString:[NSString stringWithFormat:@"%@\ntexttext", string]];
        [_dataSource addObject:string];
    }
    
    [_tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSource ? _dataSource.count : 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#cellId#>];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:<#UITableViewCellStyle#> reuseIdentifier:<#cellId#>];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return <#CGFloat#>;
}

@end
