//
//  BWResearch8SecondVC.m
//  BWObjective-CResearch-iOS
//
//  Created by BobWong on 2017/9/12.
//  Copyright © 2017年 BobWong. All rights reserved.
//

#import "BWResearch8SecondVC.h"
#import "BMValidCodeTimeManager.h"

@interface BWResearch8SecondVC ()

@property (weak, nonatomic) IBOutlet UIButton *actionButton;

@end

@implementation BWResearch8SecondVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [[BMValidCodeTimeManager sharedInstance] continuteLastCountDownAnimation:self.actionButton withType:BMValidCodeTimeTypeRegister];
}

- (IBAction)startAction:(id)sender {
    [[BMValidCodeTimeManager sharedInstance] startCountDownAnimationInButton:self.actionButton withType:BMValidCodeTimeTypeRegister];
}

@end
