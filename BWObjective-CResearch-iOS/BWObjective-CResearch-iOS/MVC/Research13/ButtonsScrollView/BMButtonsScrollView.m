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

@interface BMButtonsScrollView ()

@property (strong, nonatomic) UIView *indicatorView;

@end

@implementation BMButtonsScrollView

@dynamic titleArray, toSelectIndex;  // 去掉属性生成

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
    if (sender.isSelected) return;
    
    for (id subview in self.subviews) {
        if ([subview isKindOfClass:[UIButton class]]) {
            UIButton *button = subview;
            button.selected = NO;
        }
    }
    sender.selected = YES;
    if (_showIndicator) [self reframeIndicatorViewToSelectedIndexWithAnimation:YES];
    if (self.selectedBlock) self.selectedBlock(sender.tag - 1);
}

#pragma mark - Private Method

/** 获取选中Button */
- (UIButton *)selectedButton {
    for (id subview in self.subviews) {
        if ([subview isKindOfClass:[UIButton class]]) {
            UIButton *button = subview;
            if (button.isSelected) return button;
        }
    }
    return nil;
}

#pragma mark - Getter and Setter

- (void)setTitleArray:(NSArray<NSString *> *)titleArray {
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    if (!titleArray || !titleArray.count) return;
    
    __block CGFloat max_x = 0;
    CGFloat height = self.frame.size.height;
    CGFloat space = _space;
    if (_alignment == BMButtonsScrollViewAlignmentJustify) {
        if (titleArray.count > 1) {  // >1，为1在下面的循环中设置
            space = (CGRectGetWidth(self.frame) - [self widthForAllStringInArray:titleArray]) / (titleArray.count - 1);
        }
    }
    
    [titleArray enumerateObjectsUsingBlock:^(NSString * _Nonnull title, NSUInteger idx, BOOL * _Nonnull stop) {
        CGFloat width;
        if (_alignment == BMButtonsScrollViewAlignmentJustify && titleArray.count == 1) {
            width = CGRectGetWidth(self.frame);  // 宽=self的宽
        } else {
            width = [[self class] widthForString:title font:_font];
            width = _inset + width + _inset;  // 扩大按钮点按区域，左右扩张_inset
        }
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = 1 + idx;
        button.frame = CGRectMake(max_x, 0, width, height);
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitleColor:_normalColor forState:UIControlStateNormal];
        [button setTitleColor:_selectedColor forState:UIControlStateSelected];
        button.titleLabel.font = _font;
        [button addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        
        max_x = CGRectGetMaxX(button.frame) + _space;
    }];
    
    if (_alignment == BMButtonsScrollViewAlignmentLeft) {  // 左对齐样式，设置ScrollView的水平滚动范围，减去最后一个的_space
        self.contentSize = CGSizeMake(max_x - _space, self.contentSize.width);
    }
    
    self.toSelectIndex = 0;
}

- (void)setToSelectIndex:(NSInteger)toSelectIndex {
    UIButton *button = [self viewWithTag:1 + toSelectIndex];
    [self selectAction:button];
}

- (UIView *)indicatorView {
    if (!_indicatorView) {
        CGFloat y = self.frame.size.height - _indicatorHeight;
        CGFloat height = self.frame.size.height;
        _indicatorView = [[UIView alloc] initWithFrame:CGRectMake(0, y, 0, height)];
        _indicatorView.backgroundColor = _indicatorColor;
    }
    return _indicatorView;
}

- (void)setShowIndicator:(BOOL)showIndicator {
    if (_showIndicator == showIndicator) return;
    _showIndicator = showIndicator;
    
    if (_showIndicator) {
        UIButton *selectedButton = [self selectedButton];
        if (!selectedButton) return;
        
        [self reframeIndicatorViewToSelectedIndexWithAnimation:NO];  // Reframe indicatorView跟选中button对齐
        [self addSubview:self.indicatorView];
    } else {
        [self.indicatorView removeFromSuperview];
    }
}

- (void)reframeIndicatorViewToSelectedIndexWithAnimation:(BOOL)animation {
    UIButton *selectedButton = [self selectedButton];
    CGRect frame = self.indicatorView.frame;
    frame.origin.x = selectedButton.origin.x;
    frame.size.width = selectedButton.size.width;
    if (animation) {
        [UIView animateWithDuration:0.25 animations:^{
            self.indicatorView.frame = frame;
        }];
    } else {
        self.indicatorView.frame = frame;
    }
}

#pragma mark - Tool

+ (CGFloat)widthForString:(NSString *)string font:(UIFont *)font {
    if (!string || !font) return 0.0;
    CGSize sizeToFit = [string sizeWithAttributes:@{NSFontAttributeName: font}];
    return ceilf(sizeToFit.width);
}

- (CGFloat)widthForAllStringInArray:(NSArray<NSString *> *)array {
    CGFloat width = 0.0;
    for (NSString *string in array) {
        width += [[self class] widthForString:string font:_font];
    }
    return width;
}

@end
