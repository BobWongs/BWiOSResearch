//
//  BWHomeViewController.m
//  BWObjective-CResearch-iOS
//
//  Created by BobWong on 16/10/12.
//  Copyright © 2016年 BobWong. All rights reserved.
//

#import "BWHomeViewController.h"
#import "BWHomeTableViewCell.h"
#import "BWResearchVC.h"

#import "UITableViewRowAction+JZExtension.h"
#import "JZNavigationExtension.h"

@interface BWHomeViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation BWHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    
    self.title = @"Home";
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    /*
     TableView注册重用Cell
     */
//    [_tableView registerClass:[BWHomeTableViewCell class] forCellReuseIdentifier:NSStringFromClass([BWHomeTableViewCell class])];
//    [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([BWHomeTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([BWHomeTableViewCell class])];
    
    
//    self.navigationController.jz_fullScreenInteractivePopGestureEnabled = YES;  // 打开全屏Pop手势
//    [self.navigationController jz_setInteractivePopGestureRecognizerCompletion:^(UINavigationController *navigationController, BOOL finished) {
//        if (finished) {
//            NSLog(@"finished");
//        }
//    }];  // 全屏Pop手势回调
//    self.navigationController.jz_navigationBarTransitionStyle = JZNavigationBarTransitionStyleDoppelganger;  // 改变导航栏渐变动画
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
//    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
//    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    BWHomeTableViewCell *cell = (BWHomeTableViewCell *)[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([BWHomeTableViewCell class])];
    BWHomeTableViewCell *cell = (BWHomeTableViewCell *)[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class])];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([BWHomeTableViewCell class]) owner:nil options:nil].firstObject;
//        NSLog(@"new");
    } else {
//        NSLog(@"have reuse");
    }
    cell.lbName.text = @"Name";
    cell.lbMobile.text = [NSString stringWithFormat:@"13800138000+%ld", (long)indexPath.row];
    cell.imageView.backgroundColor = [UIColor orangeColor];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
        [tableView deselectRowAtIndexPath:indexPath animated:NO];
//    UIViewController *vc = [UIViewController new];
//    vc.title = @"New";
//    vc.view.backgroundColor = [UIColor whiteColor];
//    [self.navigationController pushViewController:vc animated:YES];
    
    BWResearchVC *vcResearch = [[BWResearchVC alloc] init];
    [self.navigationController pushViewController:vcResearch animated:YES];
    
    BWResearchVC *vcResearch2 = [[BWResearchVC alloc] init];
    [self.navigationController pushViewController:vcResearch2 animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

// 实现代理
- (nullable NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    void(^rowActionHandler)(UITableViewRowAction *, NSIndexPath *) = ^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        NSLog(@"%@", action);
        [tableView setEditing:false animated:true];
    };
    
    UIButton *buttonForImage = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    UITableViewRowAction *action1 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault image:[buttonForImage imageForState:UIControlStateNormal] handler:rowActionHandler];
    UITableViewRowAction *action2 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"disenable" handler:rowActionHandler];
    action2.enabled = false;
    UITableViewRowAction *action3 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"emjoy👍" handler:rowActionHandler];
    
    return @[action1,action2,action3];
}

@end
