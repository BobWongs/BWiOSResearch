//
//  BMLeftTextRightIconStyle0Button.m
//  BWObjective-CResearch-iOS
//
//  Created by BobWong on 2017/5/8.
//  Copyright © 2017年 BobWong. All rights reserved.
//

#import "BMLeftTextRightIconStyle0Button.h"

@implementation BMLeftTextRightIconStyle0Button

#pragma mark - View Life

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setUI];
        [self setConstraints];
    }
    return self;
}

#pragma mark - Public Method

#pragma mark - Private Method

- (void)setUI
{
    UILabel *label = [[UILabel alloc] init];
    label.text = @" ";
    label.numberOfLines = 1;
    label.textAlignment = NSTextAlignmentLeft;
    label.font = [UIFont systemFontOfSize:15.0];
    label.textColor = [UIColor darkGrayColor];
    [self addSubview:label];
}

- (void)setConstraints
{
    
}

#pragma mark - Getter and Setter

@end
