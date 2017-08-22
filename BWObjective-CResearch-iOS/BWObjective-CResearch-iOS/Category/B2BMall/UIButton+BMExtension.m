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
            [self bm_setB2bButton1WithNormalBgGradientColorArray:BMb2b_brand_color1 highlightedBgColor:BMb2b_sub_color1 disabledBgColor:BMb2b_AFD0F8];
            break;
        case BMb2bButtonType_btn1_2:
            [self bm_setB2bButton1WithNormalBgGradientColorArray:BMb2b_brand_color2 highlightedBgColor:BMb2b_sub_color2 disabledBgColor:BMb2b_F8C4AF];
            break;
//        case BMb2bButtonType_btn2_1:
//            <#statements#>
//            break;
//        case BMb2bButtonType_btn2_2:
//            <#statements#>
//            break;
//        case BMb2bButtonType_btn3_1:
//            <#statements#>
//            break;
//        case BMb2bButtonType_btn3_2:
//            <#statements#>
//            break;
//        case BMb2bButtonType_btn3_3:
//            <#statements#>
//            break;
//        case BMb2bButtonType_btn3_4:
//            <#statements#>
//            break;
    }
}

- (void)bm_setB2bButton1WithNormalBgGradientColorArray:(NSArray<UIColor *> *)colorArray highlightedBgColor:(UIColor *)highlightedBgColor disabledBgColor:(UIColor *)disabledBgColor {
    UIImage *normalBgImage = [UIImage bm_gradientImageWithColorArray:colorArray size:CGSizeMake(1, 1)];
    [self bm_setButtonWithTitleFont:[UIFont boldSystemFontOfSize:16.0] titleColor:[UIColor whiteColor] normalBgImage:normalBgImage highlightedBgColor:highlightedBgColor disabledBgColor:disabledBgColor cornerRadius:4.0 borderColor:nil borderWidth:0];
}

+ (UIButton *)bm_b2bButton2WithBackgroundImageStartColor:(UIColor *)startColor endColor:(UIColor *)endColr {
    return nil;
}

+ (UIButton *)bm_b2bButton3WithBackgroundImageStartColor:(UIColor *)startColor endColor:(UIColor *)endColr {
    return nil;
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

- (void)bm_setBackgroundGradientNormalImageWithColorArray:(NSArray<UIColor *> *)colorArray {
    [self bm_setBackgroundGradientNormalImageWithColorArray:colorArray size:CGSizeMake(1.0, 1.0)];
}

- (void)bm_setBackgroundGradientNormalImageWithColorArray:(NSArray<UIColor *> *)colorArray size:(CGSize)size {
    [self setBackgroundImage:[UIImage bm_gradientImageWithColorArray:colorArray size:size] forState:UIControlStateNormal];
}

@end
