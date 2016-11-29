//
//  BWFlexibleCell.m
//  BWResearchTableView
//
//  Created by BobWong on 16/10/21.
//  Copyright © 2016年 BobWongStudio. All rights reserved.
//

#import "BWFlexibleCell.h"

@interface BWFlexibleCell ()

@end

@implementation BWFlexibleCell

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
        _lbText.text = @"TextTextTextTextText\nTextTextTextTextText";
        _lbText.numberOfLines = 0;
        _lbText.backgroundColor = [UIColor greenColor];
    }
    return _lbText;
}

- (UIButton *)btnChange {
    if (!_btnChange) {
        _btnChange = [UIButton buttonWithType:UIButtonTypeSystem];
        [_btnChange setTitle:@"Change" forState:UIControlStateNormal];
        _btnChange.backgroundColor = [UIColor orangeColor];
        [_btnChange addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnChange;
}

#pragma mark - 事件响应

- (void)buttonAction:(UIButton *)sender {
    if (self.blockChange) {
        self.blockChange();
    }
}

#pragma mark - 共有方法

#pragma mark - 私有方法

- (void)setUI {
    [self.contentView addSubview:self.lbText];
    [self.contentView addSubview:self.btnChange];
}

- (void)setConstraints {
    BW_WEAK_SELF;
    [_lbText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(10);
        make.height.mas_equalTo(50);
    }];
    [_btnChange mas_makeConstraints:^(MASConstraintMaker *make) {
        BW_STRONG_SELF;
        make.centerX.mas_equalTo(strongSelf.mas_centerX);
        make.width.mas_equalTo(80);
        make.top.mas_equalTo(strongSelf.lbText.mas_bottom).offset(10);
        make.height.mas_equalTo(40);
    }];
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        BW_STRONG_SELF;
        make.width.mas_equalTo([UIScreen mainScreen].bounds.size.width);
        make.bottom.mas_equalTo(strongSelf.btnChange.mas_bottom).offset(8);
    }];
}

- (void)setTextLabelUnfold:(BOOL)unfold {
    if (unfold) {
        [_lbText mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.right.mas_equalTo(-10);
            make.top.mas_equalTo(10);
        }];
    } else {
        [_lbText mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.right.mas_equalTo(-10);
            make.top.mas_equalTo(10);
            make.height.mas_equalTo(50);
        }];
    }
}

@end
