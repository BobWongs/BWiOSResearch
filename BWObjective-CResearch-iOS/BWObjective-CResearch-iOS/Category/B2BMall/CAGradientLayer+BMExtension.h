//
//  CAGradientLayer+BMExtension.h
//  BWObjective-CResearch-iOS
//
//  Created by BobWong on 2017/8/18.
//  Copyright © 2017年 BobWong. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

//#define BMb2b_brand_color1_start [UIColor colorWithHexString:@"3EB4FF"]  // 影响主流程的控件：按钮、icon，起始渐变色
//#define BMb2b_brand_color1_end [UIColor colorWithHexString:@"0378FF"]  // 终止渐变色
//#define BMb2b_brand_color2_start [UIColor colorWithHexString:@"FFA909"]  // 与购物相关流程的按钮，起始渐变色
//#define BMb2b_brand_color2_end [UIColor colorWithHexString:@"FF682A"]  // 终止渐变色

#define BMb2b_brand_color1_start [UIColor greenColor]  // 影响主流程的控件：按钮、icon，起始渐变色
#define BMb2b_brand_color1_end [UIColor yellowColor]  // 终止渐变色
#define BMb2b_brand_color2_start [UIColor whiteColor]  // 与购物相关流程的按钮，起始渐变色
#define BMb2b_brand_color2_end [UIColor blackColor]  // 终止渐变色

@interface CAGradientLayer (BMExtension)

/** 创建渐变Layer */
+ (CAGradientLayer *)bm_gradientLayerWithSize:(CGSize)size
                                   startColor:(CGColorRef)startColorRef
                                     endColor:(CGColorRef)endColorRef
                                   startPoint:(CGPoint)startPoint
                                     endPoint:(CGPoint)endPoint;

+ (CAGradientLayer *)bm_gradientLayerInB2BBrandColor1WithSize:(CGSize)size;
+ (CAGradientLayer *)bm_gradientLayerInB2BBrandColor2WithSize:(CGSize)size;

@end
