//
//  BWHomeViewController.m
//  BWObjective-CResearch-iOS
//
//  Created by BobWong on 16/10/12.
//  Copyright © 2016年 BobWong. All rights reserved.
//

#import "BWHomeViewController.h"
#import "BWHomeTableViewCell.h"

@interface BWHomeViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation BWHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    /*
     TableView注册重用Cell
     */
//    [_tableView registerClass:[BWHomeTableViewCell class] forCellReuseIdentifier:NSStringFromClass([BWHomeTableViewCell class])];
//    [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([BWHomeTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([BWHomeTableViewCell class])];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BWHomeTableViewCell *cell = (BWHomeTableViewCell *)[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([BWHomeTableViewCell class])];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([BWHomeTableViewCell class]) owner:nil options:nil].firstObject;
        NSLog(@"new");
    } else {
        NSLog(@"have reuse");
    }
    cell.lbName.text = @"Name";
    cell.lbMobile.text = [NSString stringWithFormat:@"13800138000+%ld", (long)indexPath.row];
    cell.imageView.backgroundColor = [UIColor orangeColor];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

@end
