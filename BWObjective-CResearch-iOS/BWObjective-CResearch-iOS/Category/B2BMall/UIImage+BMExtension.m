//
//  UIImage+BMExtension.m
//  BWObjective-CResearch-iOS
//
//  Created by BobWong on 2017/8/21.
//  Copyright © 2017年 BobWong. All rights reserved.
//

#import "UIImage+BMExtension.h"
#import "CAGradientLayer+BMExtension.h"

@implementation UIImage (BMExtension)

+ (UIImage *)bm_gradientImageFromLayer:(CALayer *)layer {
    UIGraphicsBeginImageContextWithOptions(layer.frame.size, NO, 0);
    [layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *)bm_gradientImageWithSize:(CGSize)size
                           startColor:(CGColorRef)startColorRef
                             endColor:(CGColorRef)endColorRef
                           startPoint:(CGPoint)startPoint
                             endPoint:(CGPoint)endPoint {
    CAGradientLayer *layer = [CAGradientLayer bm_gradientLayerWithSize:size startColor:startColorRef endColor:endColorRef startPoint:startPoint endPoint:endPoint];
    return [[self class] bm_gradientImageFromLayer:layer];
}

+ (UIImage *)bm_gradientImageInB2BBrandColor1WithSize:(CGSize)size {
    CAGradientLayer *layer = [CAGradientLayer bm_gradientLayerInB2BBrandColor1WithSize:size];
    return [[self class] bm_gradientImageFromLayer:layer];
}

+ (UIImage *)bm_gradientImageInB2BBrandColor2WithSize:(CGSize)size {
    CAGradientLayer *layer = [CAGradientLayer bm_gradientLayerInB2BBrandColor2WithSize:size];
    return [[self class] bm_gradientImageFromLayer:layer];
}

@end
