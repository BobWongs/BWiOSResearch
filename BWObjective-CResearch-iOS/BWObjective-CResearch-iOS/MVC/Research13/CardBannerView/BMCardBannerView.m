//
//  BMCardBannerView.m
//  BWObjective-CResearch-iOS
//
//  Created by BobWong on 2017/10/18.
//  Copyright © 2017年 BobWong. All rights reserved.
//

#import "BMCardBannerView.h"
#import <iCarousel.h>
#import <UIImageView+WebCache.h>
#import "BMCardBannerIndicatorView.h"

@interface BMCardBannerView () <iCarouselDataSource, iCarouselDelegate>

@property (strong, nonatomic) iCarousel *carousel;
@property (strong, nonatomic) BMCardBannerIndicatorView *indicatorView;

@end

@implementation BMCardBannerView

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
    [self addSubview:self.carousel];
    [self addSubview:self.indicatorView];
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
        CGFloat height = width / 300 * 160;
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

    [imageView sd_setImageWithURL:[NSURL URLWithString:self.imageURLStringArray[index]] placeholderImage:nil];
    return view;
}

- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index {
    if (self.selectedAction) self.selectedAction(index);
}

- (void)carouselDidScroll:(iCarousel *)carousel {
#warning 滚动偏移，供指示点使用
    CGFloat scrollOffset = carousel.scrollOffset;
    CGSize contentOffset = carousel.contentOffset;
    CGSize viewpointOffset = carousel.viewpointOffset;
    NSLog(@"carouselDidScroll");
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

#pragma mark - Getter and Setter

- (void)setImageURLStringArray:(NSArray<NSString *> *)imageURLStringArray {
    _imageURLStringArray = imageURLStringArray;
    [self.carousel reloadData];
    
    [self.indicatorView setViewWithPointCount:imageURLStringArray.count];
}

- (iCarousel *)carousel {
    if (!_carousel) {
        _carousel = [[iCarousel alloc] initWithFrame:self.bounds];
        _carousel.dataSource = self;
        _carousel.delegate = self;
        _carousel.type = iCarouselTypeRotary;  // 为圆轮状
        _carousel.pagingEnabled = YES;
    }
    return _carousel;
}

- (BMCardBannerIndicatorView *)indicatorView {
    if (!_indicatorView) {
        _indicatorView = [BMCardBannerIndicatorView new];
    }
    return _indicatorView;
}

@end
