//
//  BMCarouselBannerView.m
//  BWObjective-CResearch-iOS
//
//  Created by BobWong on 2017/10/18.
//  Copyright © 2017年 BobWong. All rights reserved.
//

#import "BMCarouselBannerView.h"
#import <iCarousel.h>
#import <UIImageView+WebCache.h>
#import "BMCardBannerIndicatorView.h"

@interface BMCarouselBannerView () <iCarouselDataSource, iCarouselDelegate>

@property (strong, nonatomic) iCarousel *carousel;
@property (strong, nonatomic) BMCardBannerIndicatorView *indicatorView;

@property (nonatomic, strong) NSTimer *timer;

@end

@implementation BMCarouselBannerView

#pragma mark - View Life

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUI];
    }
    return self;
}

- (void)dealloc {
    [self stopAnimation];
}

#pragma mark - Public Method

/** 开启自动翻页动画 */
- (void)startAnimation
{
    NSInteger numberOfItems = self.carousel.numberOfItems;
    if (numberOfItems == 0 || numberOfItems == 1) return;
    
    if (!_timer)
    {
        self.timer = [NSTimer timerWithTimeInterval:5.0
                                             target:self
                                           selector:@selector(autoPaging)
                                           userInfo:nil
                                            repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSDefaultRunLoopMode];
    }
}
/** 关闭自动翻页动画 */
- (void)stopAnimation
{
    [_timer invalidate];
    _timer = nil;
}

#pragma mark - Private Method

- (void)setUI {
    [self addSubview:self.carousel];
    [self addSubview:self.indicatorView];
}

- (void)autoPaging {
    NSInteger numberOfItems = self.carousel.numberOfItems;
    NSInteger toIndex = self.carousel.currentItemIndex + 1;
    if (toIndex > numberOfItems - 1) toIndex = 0;
    [self.carousel scrollToItemAtIndex:toIndex animated:YES];
}

#pragma mark - iCarousel Protocol

- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel {
    return self.imageURLStringArray.count;
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view {
    UIImageView *imageView;
    // create new view if no view is available for recycling
    if (view == nil)
    {
        // 圆角加在UIImageView，阴影加在reusingView
        CGFloat width = carousel.frame.size.width - 10 * 2;
        CGFloat height = carousel.frame.size.height;
        view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
        view.layer.shadowColor = [UIColor colorWithHexString:@"0656f1"].CGColor;
        view.layer.shadowRadius = 4;
        view.layer.shadowOpacity = 0.4;
        view.layer.shadowOffset = CGSizeMake(0, 0);
        
        imageView = [[UIImageView alloc] initWithFrame:view.bounds];
        imageView.tag = 1;
        imageView.layer.cornerRadius = 8.0;
        imageView.clipsToBounds = YES;
        [view addSubview:imageView];
    }
    else
    {
        // get a reference to the label in the recycled view
        imageView = (UIImageView *)[view viewWithTag:1];
    }

    [imageView sd_setImageWithURL:[NSURL URLWithString:self.imageURLStringArray[index]] placeholderImage:self.placeholderImage];
    return view;
}

- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index {
    if (self.selectedAction) self.selectedAction(index);
}

- (void)carouselDidScroll:(iCarousel *)carousel {
    CGFloat scrollOffset = carousel.scrollOffset;  // Offset is from 0 to numberOfItems-1
    NSInteger numberOfItems = carousel.numberOfItems;
    
    if (scrollOffset < 0 || scrollOffset > numberOfItems - 1 || numberOfItems - 1 == 0) return;
    
    CGFloat xRate = scrollOffset / (numberOfItems - 1);  // Get the rate

    CGFloat offsetDecimal = ABS(scrollOffset - (NSInteger)scrollOffset);  // Decimal part
    CGFloat offsetRate = ABS(0.5 - offsetDecimal) + 0.5;  // (The distance to 0.5) + 0.5, 0.5 means mmiddle
    
    [self.indicatorView setCircleCenterXRate:xRate circleOffsetRate:offsetRate];
}

- (CGFloat)carousel:(iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value {
    switch (option)
    {
        case iCarouselOptionArc:
        {
            return 2 * M_PI * 0.191285715;
        }
        case iCarouselOptionRadius:
        {
            return value * 2;
        }
        case iCarouselOptionSpacing:
        {
            return value * 0.573;
        }
        default:
        {
            return value;
        }
    }
}

- (void)carouselWillBeginDragging:(iCarousel *)carousel {
    [self stopAnimation];
}

- (void)carouselDidEndScrollingAnimation:(iCarousel *)carousel {
    [self startAnimation];
}

#pragma mark - Getter and Setter

- (void)setImageURLStringArray:(NSArray<NSString *> *)imageURLStringArray {
    _imageURLStringArray = imageURLStringArray;
    [self.carousel reloadData];
    
    [self.indicatorView setViewWithPointCount:imageURLStringArray.count];
    
    if (!imageURLStringArray || imageURLStringArray.count == 0 || imageURLStringArray.count == 1) {
        [self stopAnimation];
    } else {
        [self startAnimation];
    }
}

- (iCarousel *)carousel {
    if (!_carousel) {
        _carousel = [[iCarousel alloc] initWithFrame:self.bounds];
        _carousel.dataSource = self;
        _carousel.delegate = self;
        _carousel.type = iCarouselTypeRotary;  // 为圆轮状
        _carousel.pagingEnabled = YES;
        _carousel.bounces = NO;
    }
    return _carousel;
}

- (BMCardBannerIndicatorView *)indicatorView {
    if (!_indicatorView) {
        _indicatorView = [BMCardBannerIndicatorView new];
        _indicatorView.selectedStyle = BMCardBannerIndicatorSelectedStyleRoundCircle;
    }
    return _indicatorView;
}

@end
