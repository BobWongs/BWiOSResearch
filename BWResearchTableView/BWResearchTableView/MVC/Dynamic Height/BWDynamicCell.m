//
//  BWDynamicCell.m
//  BWResearchTableView
//
//  Created by BobWong on 16/10/20.
//  Copyright © 2016年 BobWongStudio. All rights reserved.
//

#import "BWDynamicCell.h"

@interface BWDynamicCell ()

@end

@implementation BWDynamicCell

#pragma mark - 生命周期

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUI];
        [self setConstraints];
    }
    return self;
}

#pragma mark - Getter and Setter

- (UILabel *)lbText {
    if (!_lbText) {
        _lbText = [[UILabel alloc] init];
        _lbText.numberOfLines = 0;
        _lbText.textAlignment = NSTextAlignmentLeft;
        _lbText.font = [UIFont systemFontOfSize:15.0];
    }
    return _lbText;
}

#pragma mark - 事件响应

#pragma mark - 共有方法

#pragma mark - 私有方法

- (void)setUI {
    [self.contentView addSubview:self.lbText];
}

- (void)setConstraints {
    [_lbText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(8);
        make.right.mas_equalTo(-8);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.lbText.mas_bottom);
    }];
}

@end
