//
//  BWDynamicCell.m
//  BWResearchTableView
//
//  Created by BobWong on 16/10/20.
//  Copyright © 2016年 BobWongStudio. All rights reserved.
//

#import "BWDynamicCell.h"

@interface BWDynamicCell ()

@property (nonatomic, strong) UIView *view0;

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
        _lbText.text = @" ";
        _lbText.numberOfLines = 0;
        _lbText.textAlignment = NSTextAlignmentLeft;
        _lbText.font = [UIFont systemFontOfSize:15.0];
    }
    return _lbText;
}

- (UIView *)view0 {
    if (!_view0) {
        _view0 = [[UIView alloc] init];
        _view0.backgroundColor = [UIColor greenColor];
    }
    return _view0;
}

#pragma mark - 事件响应

#pragma mark - 共有方法

#pragma mark - 私有方法

- (void)setUI {
    self.contentView.backgroundColor = [UIColor grayColor];
    self.backgroundColor = [UIColor orangeColor];
    
    [self.contentView addSubview:self.lbText];
    [self.contentView addSubview:self.view0];
}

- (void)setConstraints {
    BW_WEAK_SELF;
    [_lbText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(8);
        make.right.mas_equalTo(-8);
        make.top.mas_equalTo(0);
//        make.bottom.mas_equalTo(0);
    }];
    [_view0 mas_makeConstraints:^(MASConstraintMaker *make) {
        BW_STRONG_SELF;
        make.left.mas_equalTo(8);
        make.width.mas_equalTo(356);
        make.top.mas_equalTo(strongSelf.lbText.mas_bottom).offset(8);
        make.height.mas_equalTo(50);
    }];
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        BW_STRONG_SELF;
        make.width.mas_equalTo([UIScreen mainScreen].bounds.size.width);
        make.bottom.mas_equalTo(strongSelf.view0.mas_bottom).offset(5);
    }];
}

@end
