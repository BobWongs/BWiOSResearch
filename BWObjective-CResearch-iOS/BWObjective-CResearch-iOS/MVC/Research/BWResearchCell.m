//
//  BWResearchCell.m
//  BWObjective-CResearch-iOS
//
//  Created by BobWong on 16/12/9.
//  Copyright © 2016年 BobWong. All rights reserved.
//

#import "BWResearchCell.h"
#import "Masonry.h"

@implementation BWResearchCell

#pragma mark - 生命周期

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
//        CGRect frame = self.frame;
//        frame.size.width = SCREEN_WIDTH;
//        self.frame = frame;
        
        [self setUI];
        [self setConstraints];
    }
    return self;
}

#pragma mark - Getter and Setter

#pragma mark - 事件响应

#pragma mark - 共有方法

#pragma mark - 私有方法

- (void)setUI {
    
    UILabel *lb0 = [UILabel new];
    lb0.text = @"label0\nlabel0\nlabel0\nlabel0\n";
    lb0.numberOfLines = 0;
    lb0.backgroundColor = [UIColor grayColor];
    [self.contentView addSubview:lb0];
    
    UIView *view0 = [UIView new];
    view0.backgroundColor = [UIColor greenColor];
    [self.contentView addSubview:view0];
    
//    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(self);
//    }];
    
    [lb0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(view0.mas_left).offset(-20);
        make.top.mas_equalTo(10);
        make.bottom.mas_equalTo(-10);  // 在这里进行设置
    }];
    [view0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-20);
        make.width.mas_equalTo(50);
        make.top.mas_equalTo(20);
        make.bottom.mas_equalTo(-20);
    }];

    // 不能这样设置约束，会报错，直接在lb0中进行设置
//    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.mas_equalTo(lb0.mas_bottom).offset(-10);
//    }];
    
}

- (void)setConstraints {
    
}

@end
