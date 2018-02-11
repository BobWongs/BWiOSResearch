//
//  BWResearch16View.m
//  BWObjective-CResearch-iOS
//
//  Created by BobWong on 2017/11/23.
//  Copyright © 2017年 BobWong. All rights reserved.
//

#import "BWResearch16View.h"

@implementation BWResearch16View

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    // Point
    
    // Line
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 10.0);
    
    
    CGContextMoveToPoint(context, 100, 60);
    CGContextAddLineToPoint(context, 200, 300);
    CGContextStrokePath(context);
    
    
}

@end
