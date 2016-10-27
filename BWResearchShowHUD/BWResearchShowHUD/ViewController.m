//
//  ViewController.m
//  BWResearchShowHUD
//
//  Created by BobWong on 16/10/27.
//  Copyright © 2016年 BobWongStudio. All rights reserved.
//

#import "ViewController.h"
#import "BMScanedResultHUD.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *itemRight = [[UIBarButtonItem alloc] initWithTitle:@"Show" style:UIBarButtonItemStylePlain target:self action:@selector(buttonRightItemAct:)];
    self.navigationItem.rightBarButtonItem = itemRight;
}

- (void)buttonRightItemAct:(UIButton *)sender
{
    [BMScanedResultHUD showDescriptionText:@"该编码不属于此还衣单！\n请扫描正确编码"];
}

@end
