//
//  BWResearch5VC.m
//  BWObjective-CResearch-iOS
//
//  Created by BobWong on 2017/6/12.
//  Copyright © 2017年 BobWong. All rights reserved.
//

#import "BWResearch5VC.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#define STATUS_HEIGHT 20.0
#define NAVI_HEIGTH 44.0

@interface BWResearch5VC ()

@property (strong, nonatomic) UITextField *textField;  ///< <#Comments#>

@end

@implementation BWResearch5VC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.textField = [[UITextField alloc] initWithFrame:CGRectMake(30, SCREEN_HEIGHT - 150, 200, 50)];
    self.textField.backgroundColor = [UIColor greenColor];
    [self.view addSubview:self.textField];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyboardShow:(NSNotification *)notification {
    NSDictionary *userInfo = notification.userInfo;
    
    CGRect frame_k = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat offset = frame_k.size.height - (SCREEN_HEIGHT - STATUS_HEIGHT - NAVI_HEIGTH - CGRectGetMaxY(self.textField.frame));
    if (offset <= 0) return ;  // 如果为负值则不移动
    
    [[self class] view:self.view reframeY:-offset];
}

- (void)keyboardHide:(NSNotification *)notification {
    [[self class] view:self.view reframeY:0];
}

+ (void)view:(UIView *)view reframeY:(CGFloat)y {
    CGRect frame = view.frame;
    frame.origin.y = y;
    
    [UIView animateWithDuration:.25 animations:^{
        view.frame = frame;
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

@end
