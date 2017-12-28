//
//  BWTest15View.m
//  BWObjective-CResearch-iOS
//
//  Created by BobWong on 2017/11/20.
//  Copyright © 2017年 BobWong. All rights reserved.
//

#import "BWTest15View.h"

@implementation BWTest15View

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        NSLog(@"initWithCoder");
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        NSLog(@"initWithFrame");
    }
    return self;
}

- (instancetype)init {
    if (self = [super init]) {
        NSLog(@"init");
    }
    return self;
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    NSLog(@"setFrame");
}

- (void)layoutSubviews {
    [super layoutSubviews];
    NSLog(@"layoutSubviews");
}

- (void)drawRect:(CGRect)rect {
    NSLog(@"drawRect, rect: %f, %f, %f, %f", rect.origin.x, rect.origin.y, rect.size.width, rect.size.height);
    
    self.backgroundColor = [UIColor orangeColor];
}

@end
