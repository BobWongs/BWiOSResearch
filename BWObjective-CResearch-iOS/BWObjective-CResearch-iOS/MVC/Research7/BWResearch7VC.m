//
//  BWResearch7VC.m
//  BWObjective-CResearch-iOS
//
//  Created by BobWong on 2017/8/1.
//  Copyright © 2017年 BobWong. All rights reserved.
//

#import "BWResearch7VC.h"
#import <UILabel+BWExtension.h>
#import "UIButton+BMExtension.h"
#import "BWResearch7View.h"
#import "UIAlertController+BMExtension.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface BWResearch7VC ()

@property (weak, nonatomic) IBOutlet UIButton *fromIBButton;
@property (strong, nonatomic) IBOutlet BWResearch7View *topView;

@end

@implementation BWResearch7VC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
//    [self bundle];
//    [self sandbox];
    
    
    
    [self testUI];
}


- (void)alertVC {
    UIAlertController *alertVC = [UIAlertController bmB2B_alertControllerDefaultStyleWithMessage:@"提示文案" confirmHandler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"confirm");
    } cancelHandler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"cancel");
    }];
    [self.navigationController presentViewController:alertVC animated:YES completion:nil];
}

#pragma mark - UI Control

- (void)testUI {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(40, 64 + 50, SCREEN_WIDTH - 40 * 2, 50);
    [button setTitle:@"Button: Code + Frame" forState:UIControlStateNormal];
//    button.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:button];
    
    
    [button bmB2B_setButtonWithType:BMb2bButtonType_btn1_1];
    
    [self.fromIBButton bmB2B_setButtonWithType:BMb2bButtonType_btn1_1];
    
    
    [self.fromIBButton addTarget:self action:@selector(alertVC) forControlEvents:UIControlEventTouchUpInside];
}


#pragma mark - File System

- (void)bundle {
    NSString *mainBundlePath = [NSBundle mainBundle].bundlePath;
    NSLog(@"mainBundlePath: %@", mainBundlePath);
    
    NSString *path0 = [[NSBundle mainBundle] pathForResource:@"temp0" ofType:@"txt"];
    NSLog(@"path0: %@", path0);
    NSString *str0 = [NSString stringWithContentsOfURL:[NSURL fileURLWithPath:path0] encoding:NSUTF8StringEncoding error:nil];
    NSLog(@"str0: %@", str0);
    
    NSString *path1 = [[NSBundle mainBundle] pathForResource:@"temp1" ofType:@"txt"];
    NSLog(@"path1: %@", path1);
    if (!path1) {
        path1 = [[NSBundle mainBundle] pathForResource:@"temp1" ofType:@"txt"inDirectory:@"BWResource1"];
        NSLog(@"path1: %@", path1);
        if (path1) {
            NSString *str1 = [NSString stringWithContentsOfURL:[NSURL fileURLWithPath:path1] encoding:NSUTF8StringEncoding error:nil];
            NSLog(@"str1: %@", str1);
        }
    }
    
    //    NSBundle *bundle2 = [NSBundle bundleWithPath:[NSString stringWithFormat:@"%@/BWResource2.bundle", mainBundlePath]];
    //    NSBundle *bundle2 = [NSBundle bundleWithPath:[NSString stringWithFormat:@"/BWResource2.bundle"]];
    NSBundle *bundle2 = [NSBundle bundleWithPath:[NSBundle.mainBundle pathForResource:@"BWResource2" ofType:@"bundle"]];
    
    NSString *path2 = [bundle2 pathForResource:@"temp2" ofType:@"txt"];
    
    //    NSString *path2 = [NSBundle pathForResource:@"temp2" ofType:@"txt"inDirectory:@"BWResource2"];
    NSLog(@"path2: %@", path2);
    if (path2) {
        NSString *str2 = [NSString stringWithContentsOfURL:[NSURL fileURLWithPath:path2] encoding:NSUTF8StringEncoding error:nil];
        NSLog(@"str2: %@", str2);
    }
    
    NSBundle *bundle3 = [NSBundle bundleWithPath:[NSBundle.mainBundle pathForResource:@"BWResource3" ofType:@"bundle"]];
    NSString *path3 = [bundle3 pathForResource:@"temp3" ofType:@"txt"];
    NSLog(@"path3: %@", path3);
    if (path3) {
        NSString *str3 = [NSString stringWithContentsOfURL:[NSURL fileURLWithPath:path3] encoding:NSUTF8StringEncoding error:nil];
        NSLog(@"str3: %@", str3);
    }
}

- (void)sandbox {
    
}

@end
