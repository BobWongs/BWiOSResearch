//
//  BMCardBannerIndicatorView.h
//  BWiOSComponents
//
//  Created by BobWong on 2017/8/24.
//  Copyright © 2017年 BobWongStudio. All rights reserved.
//

#import <UIKit/UIKit.h>

/** 指示点对齐方式，默认为在父视图中居中对齐，其他左右对齐则可以设置两边的间距值 */
typedef NS_ENUM(NSInteger, BMCardBannerIndicatorAlignment) {
    BMCardBannerIndicatorAlignmentCenter,  // Default
    BMCardBannerIndicatorAlignmentLeft,
    BMCardBannerIndicatorAlignmentRight
};

/** 选中指示的显示样式 */
typedef NS_ENUM(NSInteger, BMCardBannerIndicatorSelectedStyle) {
    BMCardBannerIndicatorSelectedStyleCircle,  // Default，圆点
    BMCardBannerIndicatorSelectedStyleRoundCircle  // 椭圆
};

@interface BMCardBannerIndicatorView : UIView

@property (assign, nonatomic) BMCardBannerIndicatorAlignment alignment;
@property (assign, nonatomic) BMCardBannerIndicatorSelectedStyle selectedStyle;
@property (assign, nonatomic) CGFloat pointWidth;
@property (assign, nonatomic) CGFloat pointSpace;
@property (assign, nonatomic) CGFloat horizonalMargin;  ///< margin when alignment is left or right
@property (assign, nonatomic) CGFloat verticalMargin;
@property (strong, nonatomic) UIColor *normalColor;
@property (strong, nonatomic) UIColor *selectedColor;

@property (assign, nonatomic) NSInteger selectedIndex;

- (void)setViewWithPointCount:(NSInteger)count;
- (void)setViewWithPointCount:(NSInteger)count selectedIndex:(NSInteger)index;

@end
