//
//  UIButton+BMExtension.m
//  BWObjective-CResearch-iOS
//
//  Created by BobWong on 2017/8/21.
//  Copyright © 2017年 BobWong. All rights reserved.
//

#import "UIButton+BMExtension.h"
#import "UIImage+BMExtension.h"

@implementation UIButton (BMExtension)

+ (UIButton *)bm_buttonWithType:(BMb2bButtonType)type {
    UIButton *button;
    
    if (!button) button = [UIButton new];
    return button;
}

- (void)bm_setButtonWithType:(BMb2bButtonType)type {
    switch (type) {
        case BMb2bButtonType_btn1_1:
            self
            break;
        case BMb2bButtonType_btn1_2:
            <#statements#>
            break;
        case BMb2bButtonType_btn2_1:
            <#statements#>
            break;
        case BMb2bButtonType_btn2_2:
            <#statements#>
            break;
        case BMb2bButtonType_btn3_1:
            <#statements#>
            break;
        case BMb2bButtonType_btn3_2:
            <#statements#>
            break;
        case BMb2bButtonType_btn3_3:
            <#statements#>
            break;
        case BMb2bButtonType_btn3_4:
            <#statements#>
            break;
    }
}

//+ (UIButton *)bm_buttonWithTitleFont:(UIFont *)titleFont titleColor:(UIColor *)titleColor normalBgImage:(UIImage *)normalBgImage highlightedBgColor:(UIColor *)highlightedBgColor disabledBgColor:(UIColor *)disabledBgColor cornerRadius:(CGFloat)cornerRadius borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth {
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//    
//}

+ (UIButton *)bm_b2bButton1WithNormalBgGradientColorArray:(NSArray<UIColor *> *)colorArray {
    return [self bm_buttonWithTitleFont:<#(UIFont *)#> titleColor:<#(UIColor *)#> normalBgImage:<#(UIImage *)#> highlightedBgColor:<#(UIColor *)#> disabledBgColor:<#(UIColor *)#> cornerRadius:<#(CGFloat)#> borderColor:<#(UIColor *)#> borderWidth:<#(CGFloat)#>]
}

- (void)bm_setB2bButton1WithNormalBgGradientColorArray:(NSArray<UIColor *> *)colorArray {
    UIImage *normalBgImage = [UIImage bm_gradientImageWithColorArray:colorArray size:CGSizeMake(1, 1)];
    [self bm_setButtonWithTitleFont:[UIFont boldSystemFontOfSize:16.0] titleColor:[UIColor whiteColor] normalBgImage:normalBgImage highlightedBgColor:BMb2b_sub_color1 disabledBgColor:<#(UIColor *)#> cornerRadius:<#(CGFloat)#> borderColor:<#(UIColor *)#> borderWidth:<#(CGFloat)#>]
}

+ (UIButton *)bm_b2bButton2WithBackgroundImageStartColor:(UIColor *)startColor endColor:(UIColor *)endColr {
    
}

+ (UIButton *)bm_b2bButton3WithBackgroundImageStartColor:(UIColor *)startColor endColor:(UIColor *)endColr {
    
}

- (void)bm_setButtonWithTitleFont:(UIFont *)titleFont titleColor:(UIColor *)titleColor normalBgImage:(UIImage *)normalBgImage highlightedBgColor:(UIColor *)highlightedBgColor disabledBgColor:(UIColor *)disabledBgColor cornerRadius:(CGFloat)cornerRadius borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth {
    self.titleLabel.font = titleFont;
    [self setTitleColor:titleColor forState:UIControlStateNormal];
    self.layer.cornerRadius = cornerRadius;
    [self setBackgroundImage:normalBgImage forState:UIControlStateNormal];
    [self setBackgroundImage:[UIImage bm_imageWithColor:highlightedBgColor] forState:UIControlStateHighlighted];
    [self setBackgroundImage:[UIImage bm_imageWithColor:disabledBgColor] forState:UIControlStateDisabled];
    
    if (borderColor) {
        self.layer.borderColor = borderColor.CGColor;
        self.layer.borderWidth = borderWidth;
    }
}

@end
