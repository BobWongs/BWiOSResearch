//
//  BWProgressHUD.m
//  BWResearchShowHUD
//
//  Created by BobWong on 16/10/28.
//  Copyright © 2016年 BobWongStudio. All rights reserved.
//

#import "BWProgressHUD.h"

#define FONT_TEXT [UIFont systemFontOfSize:17]
#define COLOR_TEXT [UIColor blackColor]
#define COLOR_HIGHTLIGHT_TEXT [UIColor redColor]

#define BW_WEAK_SELF __weak typeof(self) weakSelf = self
#define BW_STRONG_SELF typeof(weakSelf) __strong strongSelf = weakSelf

@interface BWProgressHUD ()

@property (nonatomic, strong) UIView *viewBg;
@property (nonatomic, strong) UILabel *lbHUD;

@end

@implementation BWProgressHUD

+ (BWProgressHUD *)sharedView {
    static dispatch_once_t once;
    static BWProgressHUD *sharedView;
    dispatch_once(&once, ^ {
        sharedView = [[self alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    });
    return sharedView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.alpha = 0.0;
        
        _viewBg = [[UIView alloc] initWithFrame:self.bounds];
        _viewBg.backgroundColor = [UIColor blackColor];
        _viewBg.alpha = 0.4;
        [self addSubview:_viewBg];
        
        // Frame布局
        _lbHUD = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 115)];
        _lbHUD.center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
        _lbHUD.numberOfLines = 0;
        _lbHUD.textAlignment = NSTextAlignmentCenter;
        _lbHUD.font = FONT_TEXT;
        _lbHUD.textColor = COLOR_TEXT;
        _lbHUD.backgroundColor = [UIColor whiteColor];
        _lbHUD.layer.cornerRadius = 4.0;
        _lbHUD.clipsToBounds = YES;
        [self addSubview:_lbHUD];
        
        
        // Constraints布局
    }
    return self;
}

+ (void)showDescriptionText:(NSString *)textDesc
              highlightText:(NSString *)textHighlight {
    NSString *textAll = [NSString stringWithFormat:@"%@%@", textDesc, textHighlight];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:textAll];
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setLineSpacing:10.0];
    style.alignment = NSTextAlignmentCenter;
    NSDictionary *dictAttrDesc = @{
                                   NSFontAttributeName: FONT_TEXT,
                                   NSForegroundColorAttributeName: COLOR_TEXT,
                                   NSParagraphStyleAttributeName: style
                                   };
    NSDictionary *dictAttrHL = @{
                                 NSFontAttributeName: FONT_TEXT,
                                 NSForegroundColorAttributeName: COLOR_HIGHTLIGHT_TEXT,
                                 NSParagraphStyleAttributeName: style
                                 };
    
    NSRange rangeDesc = [textAll rangeOfString:textDesc];
    NSRange rangeHighlight = [textAll rangeOfString:textHighlight];
    [attributedString setAttributes:dictAttrDesc range:rangeDesc];
    [attributedString setAttributes:dictAttrHL range:rangeHighlight];
    
    [self sharedView].lbHUD.attributedText = attributedString;
    
    // 显示和移除，伴随渐变的动画效果
    [self sharedView].alpha = 0.0;
    [[UIApplication sharedApplication].keyWindow addSubview:[self sharedView]];
    [UIView animateWithDuration:.25 animations:^{
        [self sharedView].alpha = 1.0;
    } completion:^(BOOL finished) {
        [self hideShowedHUDAnimationWithText:textAll completion:^(BOOL finished) {
            [[self sharedView] removeFromSuperview];
        }];
    }];
    
    
//    NSTimeInterval displayInterval = [[self class] displayDurationForString:textAll];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(displayInterval * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//
//        [UIView animateWithDuration:.25 animations:^{
//            [self sharedView].alpha = 0.0;
//        } completion:^(BOOL finished) {
//            [[self sharedView] removeFromSuperview];
//        }];
//    });
}

+ (void)showDescriptionText:(NSString *)textDesc {
    [[self class] showDescriptionText:textDesc highlightText:@""];
}

+ (void)showDescriptionHideTheShowedHudText:(NSString *)textDesc {
    if ([[self class] isEqualFloatA:[self sharedView].alpha floatB:0.0]) {
        // 当前没有，则直接显示
        [self showDescriptionText:textDesc];
    } else {
        // 当前已有，则先隐藏之前已经添加的
        [self hideShowedHUDAnimationWithText:textDesc completion:^(BOOL finished) {
            [[self sharedView] removeFromSuperview];
            [self showDescriptionText:textDesc];
        }];
    }
}

+ (void)showNewLabelDescriptionText:(NSString *)textDesc {
    /*
     用新Label来显示，移除时则从最顶部逐个进行移除，这个比较难于实现
     */
}

+ (void)hideShowedHUDAnimationWithText:(NSString *)textDesc
                            completion:(void (^ __nullable)(BOOL finished))completion {
    NSTimeInterval displayInterval = [[self class] displayDurationForString:textDesc];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(displayInterval * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [UIView animateWithDuration:.25 animations:^{
            [self sharedView].alpha = 0.0;
        } completion:completion];
    });
}

+ (NSTimeInterval)displayDurationForString:(NSString*)string {
    return MIN((float)string.length*0.13 + 0.5, 5.0);
}

+ (BOOL)isEqualFloatA:(float)a
               floatB:(float)b {
    NSDecimalNumber *numA = [NSDecimalNumber decimalNumberWithString:@(a).stringValue];
    NSDecimalNumber *numB = [NSDecimalNumber decimalNumberWithString:@(b).stringValue];
    
    if ([numA compare:numB] == NSOrderedSame) {
        return YES;
    }
    return NO;
}

@end
