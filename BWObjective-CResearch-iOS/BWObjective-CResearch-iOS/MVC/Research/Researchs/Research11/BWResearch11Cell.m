//
//  BWResearch11Cell.m
//  BWObjective-CResearch-iOS
//
//  Created by BobWong on 2017/10/10.
//  Copyright © 2017年 BobWong. All rights reserved.
//

#import "BWResearch11Cell.h"

@interface BWResearch11Cell ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topViewWidth;

@end

@implementation BWResearch11Cell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [UIColor orangeColor];
    
    self.topViewWidth.constant = kScreenWidth / 6;
}

@end
