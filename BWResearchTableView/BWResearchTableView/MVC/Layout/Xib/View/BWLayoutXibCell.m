//
//  BWLayoutXibCell.m
//  BWResearchTableView
//
//  Created by BobWong on 16/11/29.
//  Copyright © 2016年 BobWongStudio. All rights reserved.
//

#import "BWLayoutXibCell.h"

@interface BWLayoutXibCell ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintLine0;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintLine1;

@end

@implementation BWLayoutXibCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    _constraintLine0.constant = 0.5;
    _constraintLine1.constant = 0.5;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
