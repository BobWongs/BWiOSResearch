//
//  BMCardCycleView.m
//  BWObjective-CResearch-iOS
//
//  Created by BobWong on 2017/10/18.
//  Copyright © 2017年 BobWong. All rights reserved.
//

#import "BMCardCycleView.h"
#import <UIImageView+WebCache.h>
#import "BMCardBannerIndicatorView.h"
#import "TYCyclePagerView.h"
#import "BMCardCycleItemCell.h"

NSString *const BMCardCycleViewCellId = @"BMCardCycleViewCellId";

@interface BMCardCycleView () <TYCyclePagerViewDataSource, TYCyclePagerViewDelegate>

@property (strong, nonatomic) TYCyclePagerView *pagerView;
@property (strong, nonatomic) BMCardBannerIndicatorView *indicatorView;

@property (nonatomic, strong) NSTimer *timer;

@end

@implementation BMCardCycleView

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
    [self addSubview:self.pagerView];
    [self addSubview:self.indicatorView];
}

#pragma mark - iCarousel Protocol

- (NSInteger)numberOfItemsInPagerView:(TYCyclePagerView *)pageView {
    return self.imageURLStringArray.count;
}

- (UICollectionViewCell *)pagerView:(TYCyclePagerView *)pagerView cellForItemAtIndex:(NSInteger)index {
    BMCardCycleItemCell *cell = [pagerView dequeueReusableCellWithReuseIdentifier:BMCardCycleViewCellId forIndex:index];
    [cell.contentImageView sd_setImageWithURL:[NSURL URLWithString:self.imageURLStringArray[index]] placeholderImage:self.placeholderImage];
    return cell;
}

- (void)pagerView:(TYCyclePagerView *)pageView didSelectedItemCell:(__kindof UICollectionViewCell *)cell atIndex:(NSInteger)index {
    if (self.selectedAction) self.selectedAction(index);
}

- (TYCyclePagerViewLayout *)layoutForPagerView:(TYCyclePagerView *)pageView {
    TYCyclePagerViewLayout *layout = [[TYCyclePagerViewLayout alloc]init];
    layout.layoutType = TYCyclePagerTransformLayoutLinear;
    
    CGFloat width = pageView.frame.size.width - 10 * 2;
    CGFloat height = pageView.frame.size.height;
    layout.itemSize = CGSizeMake(width, height);
    layout.itemHorizontalCenter = YES;
    layout.itemSpacing = 4;
    layout.minimumScale = 0.85;
    
    return layout;
}

- (void)pagerView:(TYCyclePagerView *)pageView didScrollFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex {
    self.indicatorView.selectedIndex = toIndex;
}

#pragma mark - Getter and Setter

- (void)setImageURLStringArray:(NSArray<NSString *> *)imageURLStringArray {
    _imageURLStringArray = imageURLStringArray;
    [self.pagerView reloadData];
    
    [self.indicatorView setViewWithPointCount:imageURLStringArray.count];
}

- (TYCyclePagerView *)pagerView {
    if (!_pagerView) {
        _pagerView = [[TYCyclePagerView alloc] initWithFrame:self.bounds];
        _pagerView.isInfiniteLoop = YES;
        _pagerView.autoScrollInterval = 5.0;
        _pagerView.dataSource = self;
        _pagerView.delegate = self;
        [_pagerView registerNib:[UINib nibWithNibName:NSStringFromClass([BMCardCycleItemCell class]) bundle:nil] forCellWithReuseIdentifier:BMCardCycleViewCellId];
        _pagerView.clipsToBounds = NO;
        
        UIView *collectionView = [_pagerView valueForKey:@"collectionView"];
        if (collectionView && [collectionView isKindOfClass:[UIView class]]) {
            collectionView.clipsToBounds = NO;
        }
    }
    return _pagerView;
}

- (BMCardBannerIndicatorView *)indicatorView {
    if (!_indicatorView) {
        _indicatorView = [BMCardBannerIndicatorView new];
        _indicatorView.selectedStyle = BMCardBannerIndicatorSelectedStyleRoundCircle;
    }
    return _indicatorView;
}

@end
