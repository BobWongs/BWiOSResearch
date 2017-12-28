//
//  BMTest13View.m
//  BWObjective-CResearch-iOS
//
//  Created by BobWong on 2017/10/26.
//  Copyright © 2017年 BobWong. All rights reserved.
//

#import "BMTest13View.h"

@implementation BMTest13View

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self = (BMTest13View *)[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil].firstObject;
        self.frame = frame;
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

@end
