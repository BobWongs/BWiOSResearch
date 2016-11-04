//
//  ViewController.m
//  BWResearchShowHUD
//
//  Created by BobWong on 16/10/27.
//  Copyright © 2016年 BobWongStudio. All rights reserved.
//

#import "ViewController.h"
#import "BWProgressHUD.h"
#import "MBProgressHUD.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *itemRight1 = [[UIBarButtonItem alloc] initWithTitle:@"Right1" style:UIBarButtonItemStylePlain target:self action:@selector(buttonRightItemAct1:)];
    UIBarButtonItem *itemRight2 = [[UIBarButtonItem alloc] initWithTitle:@"Right2" style:UIBarButtonItemStylePlain target:self action:@selector(buttonRightItemAct2:)];
    self.navigationItem.rightBarButtonItems = @[itemRight1, itemRight2];
}

- (void)buttonRightItemAct1:(UIButton *)sender
{
//    [BWProgressHUD showDescriptionText:@"弹框1弹框1弹框1弹框1弹框1弹框1弹框1弹框1"];
    
    [BWProgressHUD showDescriptionHideTheShowedHudText:@"弹框先隐藏已有弹框弹框先隐藏已有弹框弹框先隐藏已有弹框"];
    
    
    /*
     待优化
     目标效果一：不同文本切换时先隐藏，之后再显示；
     目标效果二：多个文本的弹框都要显示，然后逐个消失；
     */
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [BWProgressHUD showDescriptionHideTheShowedHudText:@"弹框先隐藏已有弹框2弹框先隐藏已有弹框2弹框先隐藏已有弹框2"];
    });
}

- (void)buttonRightItemAct2:(UIButton *)sender {
    [MBProgressHUD ];
}

@end
