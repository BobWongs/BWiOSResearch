//
//  BWResearch9VC.m
//  BWObjective-CResearch-iOS
//
//  Created by BobWong on 2017/9/18.
//  Copyright © 2017年 BobWong. All rights reserved.
//

#import "BWResearch9VC.h"
#import <YYCategories.h>
#import <Masonry.h>

@interface BWResearch9VC ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *view0Top;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *view1Top;

@property (weak, nonatomic) IBOutlet UIView *view1;
@property (weak, nonatomic) IBOutlet UILabel *testLabel;

@end

@implementation BWResearch9VC

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self test1];
    [self test2];
}

- (void)test2 {
    UIViewController *parentVC = UIApplication.sharedApplication.keyWindow.rootViewController.parentViewController;
    UIViewController *presentingVC = UIApplication.sharedApplication.keyWindow.rootViewController.presentingViewController;
    UIViewController *presentedVC = UIApplication.sharedApplication.keyWindow.rootViewController.presentedViewController;
    NSLog(@"\n ing: %@\n, ed:%@", presentingVC, presentedVC);
    NSLog(@"\n parent: %@", parentVC);
    
    UITabBarController *tabBarVC = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
}

- (void)test0 {
    //    NSLog(@"view0Top, firstItem: %@, SecondItem: %@", self.view0Top.firstItem, self.view0Top.secondItem);
    [[self class] bm_setAttributeInLabel:self.testLabel WithText:@"月亮券支付 余额\n 您当前的月亮券" normalColor:[UIColor orangeColor] normalFont:[UIFont systemFontOfSize:12.0] highlightedText:@"月亮券支付" highlightedColor:[UIColor grayColor] highlightedFont:[UIFont systemFontOfSize:14.0]];
    
    UIApplication.sharedApplication.statusBarStyle = UIStatusBarStyleLightContent;
}

- (void)test1 {
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *view = [[UIVisualEffectView alloc] initWithEffect:effect];
    view.alpha = 0.8;
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
}

//- (void)viewDidAppear:(BOOL)animated {
//    [super viewDidAppear:animated];
//    [self setNeedsStatusBarAppearanceUpdate];
//}
//
- (BOOL)prefersStatusBarHidden {
    return NO;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

//- (IBAction)change:(id)sender {
//    
//}

+ (void)bm_setAttributeInLabel:(UILabel *)label
                      WithText:(NSString *)text
                         normalColor:(UIColor *)colorNormal
                          normalFont:(UIFont *)fontNormal
                     highlightedText:(NSString *)textHighlighted
                    highlightedColor:(UIColor *)colorHighlighted
                     highlightedFont:(UIFont *)fontHighlighted {
    if (![text containsString:textHighlighted]) return;  // 不包含
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text];
    
    CGFloat normalHeight = [@"支付" heightForFont:fontNormal width:CGFLOAT_MAX];
    CGFloat highlightedHeight = [@"支付" heightForFont:fontHighlighted width:CGFLOAT_MAX];
    CGFloat offset = (highlightedHeight - normalHeight) / 2;
    NSLog(@"offset: %f", offset);
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setLineSpacing:6.0];
    
    NSDictionary *dictAttrNormal = @{
                                     NSFontAttributeName: fontNormal,
                                     NSForegroundColorAttributeName: colorNormal,
                                     NSParagraphStyleAttributeName: style
                                     };
    NSDictionary *dictAttrHighlighted = @{
                                          NSFontAttributeName: fontHighlighted,
                                          NSForegroundColorAttributeName: colorHighlighted,
                                          NSBaselineOffsetAttributeName: @(offset),
                                          NSParagraphStyleAttributeName: style
                                          };
    
    NSRange rangeHighlighted = [text rangeOfString:textHighlighted];
    [attributedString setAttributes:dictAttrNormal range:NSMakeRange(0, text.length)];
    [attributedString setAttributes:dictAttrHighlighted range:rangeHighlighted];
    
    label.attributedText = attributedString;
}

@end
