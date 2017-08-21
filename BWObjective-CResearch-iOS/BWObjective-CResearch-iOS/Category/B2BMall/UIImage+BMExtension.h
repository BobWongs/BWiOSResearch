//
//  UIImage+BMExtension.h
//  BWObjective-CResearch-iOS
//
//  Created by BobWong on 2017/8/21.
//  Copyright © 2017年 BobWong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (BMExtension)

+ (UIImage *)bm_gradientImageFromLayer:(CALayer *)layer;

+ (UIImage *)bm_gradientImageWithSize:(CGSize)size
                           startColor:(CGColorRef)startColorRef
                             endColor:(CGColorRef)endColorRef
                           startPoint:(CGPoint)startPoint
                             endPoint:(CGPoint)endPoint;

+ (UIImage *)bm_gradientImageInB2BBrandColor1WithSize:(CGSize)size;
+ (UIImage *)bm_gradientImageInB2BBrandColor2WithSize:(CGSize)size;

@end
