//
//  BMCardBannerIndicatorView.m
//  BWiOSComponents
//
//  Created by BobWong on 2017/8/24.
//  Copyright © 2017年 BobWongStudio. All rights reserved.
//

#import "BMCardBannerIndicatorView.h"

#define BM_CARD_BANNER_INDICATOR_UIColorFromRGB(rgbValue) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0x00FF00) >>  8))/255.0 \
blue:((float)((rgbValue & 0x0000FF) >>  0))/255.0 \
alpha:1.0]

@interface BMCardBannerIndicatorView ()

@property (strong, nonatomic) UIView *selectedRoundCircleView;

@end

@implementation BMCardBannerIndicatorView

#pragma mark - Life Cycle

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _alignment = BMCardBannerIndicatorAlignmentCenter;
        _selectedStyle = BMCardBannerIndicatorSelectedStyleCircle;
        _pointWidth = 4.0;
        _pointSpace = 6.0;
        _horizonalMargin = 12.0;
        _verticalMargin = 4.0;
        _roundCircleWidth = 8.0;
        _roundCircleHeight = _pointWidth;
        _roundCircleCornerRadius = 2.0;
        _normalColor = BM_CARD_BANNER_INDICATOR_UIColorFromRGB(0xBABABA);
        _selectedColor = [UIColor whiteColor];
    }
    return self;
}

#pragma mark - Public Method

- (void)setViewWithPointCount:(NSInteger)count {
    [self setViewWithPointCount:count selectedIndex:0];
}

- (void)setViewWithPointCount:(NSInteger)count selectedIndex:(NSInteger)index {
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    if (count == 0 || count == 1) return;  // 为0或者1时，不用显示
    
    CGFloat max_x = 0, pointWidth = _pointWidth, space = _pointSpace;
    for (NSInteger i = 0; i < count; i++) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(max_x, 0, pointWidth, pointWidth)];
        view.tag = 1 + i;
        view.backgroundColor = _normalColor;
        view.layer.cornerRadius = pointWidth / 2;
        [self addSubview:view];
        
        max_x = CGRectGetMaxX(view.frame) + space;
    }
    
    // Reframe
    CGFloat selfWidth = max_x - space;
    CGFloat superViewWidth = self.superview ? CGRectGetWidth(self.superview.frame) : CGRectGetWidth([UIScreen mainScreen].bounds);
    CGRect frame = self.frame;
    frame.origin.y = self.superview ? CGRectGetHeight(self.superview.frame) - _verticalMargin - _pointWidth : _verticalMargin;
    frame.size.width = selfWidth;
    frame.size.height = pointWidth;  // height=width
    // Relocate X
    switch (_alignment) {
        case BMCardBannerIndicatorAlignmentCenter:
        {
            frame.origin.x = (superViewWidth - selfWidth) / 2;
            break;
        }
        case BMCardBannerIndicatorAlignmentLeft:
        {
            frame.origin.x = _horizonalMargin;
            break;
        }
            
        case BMCardBannerIndicatorAlignmentRight:
        {
            frame.origin.x = superViewWidth - _horizonalMargin - selfWidth;
            break;
        }
    }
    self.frame = frame;
    
    self.selectedIndex = index;
}

#pragma mark - Private Method

#pragma mark - Setter and Getter

- (void)setSelectedIndex:(NSInteger)selectedIndex {
    _selectedIndex = selectedIndex;
    
    if (_selectedStyle == BMCardBannerIndicatorSelectedStyleRoundCircle) {
        UIView *view = [self viewWithTag:1 + selectedIndex];
        self.selectedRoundCircleView.center = view.center;  // 跟选中圆点view的同一center
        [self addSubview:self.selectedRoundCircleView];
        return;
    }
       
    // Others
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull subview, NSUInteger idx, BOOL * _Nonnull stop) {
        subview.backgroundColor = _normalColor;
        if (idx == selectedIndex) subview.backgroundColor = _selectedColor;
    }];
}

- (UIView *)selectedRoundCircleView {
    if (!_selectedRoundCircleView) {
        _selectedRoundCircleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _roundCircleWidth, _roundCircleHeight)];
        _selectedRoundCircleView.layer.cornerRadius = _roundCircleCornerRadius;
        _selectedRoundCircleView.backgroundColor = _selectedColor;
    }
    return _selectedRoundCircleView;
}

- (void)setCircleCenterXRate:(CGFloat)circleCenterXRate circleOffsetRate:(CGFloat)offsetRate {
    self.selectedRoundCircleView.alpha = offsetRate;
    
    CGRect frame = self.selectedRoundCircleView.frame;
    frame.size.width = offsetRate * _roundCircleWidth;
    self.selectedRoundCircleView.frame = frame;
    
    self.selectedRoundCircleView.center = CGPointMake(circleCenterXRate * self.frame.size.width, CGRectGetMidY(self.selectedRoundCircleView.frame));
}

@end
