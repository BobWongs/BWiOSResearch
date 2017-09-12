//
//  BWResearch8VC.m
//  BWObjective-CResearch-iOS
//
//  Created by BobWong on 2017/8/29.
//  Copyright © 2017年 BobWong. All rights reserved.
//

#import "BWResearch8VC.h"
#import <FLAnimatedImage.h>
#import <AFNetworkReachabilityManager.h>
#import "BMValidCodeTimeManager.h"
#import "BWResearch8SecondVC.h"

@interface BWResearch8VC ()

@property (weak, nonatomic) IBOutlet UIButton *actionButton;

@end

@implementation BWResearch8VC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [[BMValidCodeTimeManager sharedInstance] continuteLastCountDownAnimation:self.actionButton withType:BMValidCodeTimeTypeQuickLogin];
}

- (IBAction)startAction:(id)sender {
    [[BMValidCodeTimeManager sharedInstance] startCountDownAnimationInButton:self.actionButton withType:BMValidCodeTimeTypeQuickLogin];
}

- (IBAction)pushIntoAction:(id)sender {
    [self.navigationController pushViewController:[BWResearch8SecondVC new] animated:YES];
}

- (IBAction)showLoading:(id)sender {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"loading" ofType:@"gif"];
    FLAnimatedImage *image = [FLAnimatedImage animatedImageWithGIFData:[NSData dataWithContentsOfFile:filePath]];
    FLAnimatedImageView *imageView = [[FLAnimatedImageView alloc] init];
    imageView.animatedImage = image;
    imageView.frame = CGRectMake(50.0, 200.0, 100.0, 100.0);
    [self.view addSubview:imageView];
}

- (IBAction)checkNetwork:(id)sender {
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager managerForDomain:@"http://tmallapi.bluemoon.com.cn"];
    AFNetworkReachabilityStatus status = manager.networkReachabilityStatus;
    NSLog(@"Status: %ld", (long)status);
    [manager startMonitoring];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        NSLog(@"Status: %ld", (long)status);
    }];
    
}

@end
