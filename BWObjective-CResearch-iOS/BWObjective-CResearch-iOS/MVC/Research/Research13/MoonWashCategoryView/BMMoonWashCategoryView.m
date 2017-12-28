//
//  BMMoonWashCategoryView.m
//  BWObjective-CResearch-iOS
//
//  Created by BobWong on 2017/10/20.
//  Copyright © 2017年 BobWong. All rights reserved.
//

#import "BMMoonWashCategoryView.h"
#import "BMButtonsScrollView.h"

@interface BMMoonWashCategoryView ()

@property (strong, nonatomic) BMButtonsScrollView *firstScrollView;  ///< 一级菜单
@property (strong, nonatomic) BMButtonsScrollView *secondScrollView;  ///< 二级菜单

@end

@implementation BMMoonWashCategoryView

#pragma mark - View Life

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUI];
    }
    return self;
}

#pragma mark - Public Method

#pragma mark - Private Method

- (void)setUI {
    CGFloat margin = 10;
    CGFloat width = self.frame.size.width - margin * 2;
    self.firstScrollView.frame = CGRectMake(margin, 5, width, 28);
    self.secondScrollView.frame = CGRectMake(margin, CGRectGetMaxY(self.firstScrollView.frame), width, 25);
}

#pragma mark - Getter and Setter

- (void)setFirstArray:(NSArray<NSString *> *)firstArray {
    self.firstScrollView.titleArray = firstArray;
}

- (void)setSecondArray:(NSArray<NSString *> *)secondArray {
    self.secondScrollView.titleArray = secondArray;
}

- (BMButtonsScrollView *)firstScrollView {
    if (!_firstScrollView) {
        _firstScrollView = [BMButtonsScrollView new];
        _firstScrollView.alignment = BMButtonsScrollViewAlignmentJustify;
        __weak typeof(self) weakSelf = self;
        _firstScrollView.selectedBlock = ^(NSInteger selectedIndex) {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            if (strongSelf.firstSelectedAction) strongSelf.firstSelectedAction(selectedIndex);
        };
    }
    return _firstScrollView;
}

- (BMButtonsScrollView *)secondScrollView {
    if (!_secondScrollView) {
        _secondScrollView = [BMButtonsScrollView new];
        _secondScrollView.alignment = BMButtonsScrollViewAlignmentLeft;
        _secondScrollView.font = [UIFont systemFontOfSize:12.0];
        __weak typeof(self) weakSelf = self;
        _secondScrollView.selectedBlock = ^(NSInteger selectedIndex) {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            if (strongSelf.secondSelectedAction) {
                strongSelf.secondSelectedAction(@[@(strongSelf.firstScrollView.selectedIndex), @(strongSelf.secondScrollView.selectedIndex)]);
            }
        };
    }
    return _secondScrollView;
}

@end
