//
//  BMButtonsScrollView.m
//  BWObjective-CResearch-iOS
//
//  Created by BobWong on 2017/10/20.
//  Copyright © 2017年 BobWong. All rights reserved.
//

#import "BMButtonsScrollView.h"

#define BM_BUTTON_SCROLL_VIEW_UIColorFromHex(hexValue) \
[UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0 \
green:((float)((hexValue & 0x00FF00) >>  8))/255.0 \
blue:((float)((hexValue & 0x0000FF) >>  0))/255.0 \
alpha:1.0]

@implementation BMButtonsScrollView

#pragma mark - View Life

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _alignment = BMButtonsScrollViewAlignmentJustify;
        _normalColor = BM_BUTTON_SCROLL_VIEW_UIColorFromHex(0x757575);
        _selectedColor = BM_BUTTON_SCROLL_VIEW_UIColorFromHex(0x0058F1);
        _font = [UIFont systemFontOfSize:14.0];
        _space = 20;
        _inset = 10;
        _showIndicator = NO;
        _indicatorHeight = 2;
        _indicatorColor = _selectedColor;
    }
    return self;
}

#pragma mark - Public Method

#pragma mark - Action

- (void)selectAction:(UIButton *)sender {
    
}

#pragma mark - Private Method

#pragma mark - Getter and Setter

- (void)setTitleArray:(NSArray<NSString *> *)titleArray {
    _titleArray = titleArray;
    
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    if (!titleArray || !titleArray.count) return;
    
    __block CGFloat max_x = 0;
    CGFloat height = self.frame.size.height;
    [titleArray enumerateObjectsUsingBlock:^(NSString * _Nonnull title, NSUInteger idx, BOOL * _Nonnull stop) {
        CGFloat width = [[self class] widthForString:title font:_font];
        width = _space + width + _space;
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(max_x, 0, width, height);
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitleColor:_normalColor forState:UIControlStateNormal];
        button.titleLabel.font = _font;
        [button addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        
        max_x = CGRectGetMaxX(button.frame) + _space;
    }];
    
//    self.contentOffset =
}

- (void)setToSelectIndex:(NSInteger)toSelectIndex {
    _toSelectIndex = toSelectIndex;
}

#pragma mark - Tool

+ (CGFloat)widthForString:(NSString *)string font:(UIFont *)font {
    if (!string || !font) return 0.0;
    CGSize sizeToFit = [string sizeWithAttributes:@{NSFontAttributeName: font}];
    return ceilf(sizeToFit.width);
}

@end
