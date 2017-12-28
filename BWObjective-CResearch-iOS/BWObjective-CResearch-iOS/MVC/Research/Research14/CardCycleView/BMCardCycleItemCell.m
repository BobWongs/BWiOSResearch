//
//  BMCardCycleItemCell.m
//  BWObjective-CResearch-iOS
//
//  Created by BobWong on 2017/11/7.
//  Copyright © 2017年 BobWong. All rights reserved.
//

#import "BMCardCycleItemCell.h"

@implementation BMCardCycleItemCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [UIColor whiteColor];
    
    CGFloat cornerRadius = 4.0;
    
    self.layer.cornerRadius = cornerRadius;
    self.layer.shadowColor = [UIColor colorWithHexString:@"0656f1"].CGColor;
    self.layer.shadowRadius = cornerRadius;
    self.layer.shadowOpacity = 0.2;
    self.layer.shadowOffset = CGSizeMake(0, 0);
    self.clipsToBounds = NO;  // CollectionViewCell默认为YES，设为NO，出来阴影效果
    
    self.contentView.layer.cornerRadius = cornerRadius;  //contentView中切圆角
    self.contentView.clipsToBounds = YES;
}

@end
