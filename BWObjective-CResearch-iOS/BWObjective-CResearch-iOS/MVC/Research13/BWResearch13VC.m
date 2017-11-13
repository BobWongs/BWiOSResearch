//
//  BWResearch13VC.m
//  BWObjective-CResearch-iOS
//
//  Created by BobWong on 2017/10/18.
//  Copyright © 2017年 BobWong. All rights reserved.
//

#import "BWResearch13VC.h"
#import <iCarousel.h>
#import "BMCarouselBannerView.h"
#import "BMTest13View.h"
#import "BMCardCycleView.h"

@interface BWResearch13VC ()

@property (strong, nonatomic) IBOutlet BMTest13View *test13View;
@property (weak, nonatomic) IBOutlet UIImageView *imageView0;
@property (strong, nonatomic) BMCarouselBannerView *bannerView;
@property (strong, nonatomic) BMCardCycleView *cardCycleView;

@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIButton *middleButton;

@property (weak, nonatomic) IBOutlet UIView *blockView;

@property (weak, nonatomic) IBOutlet UISlider *arcSlider;
@property (weak, nonatomic) IBOutlet UISlider *radiusSlider;
@property (weak, nonatomic) IBOutlet UISlider *spacingSlider;

@end

@implementation BWResearch13VC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self test1];  // Card banner
//    [self test2];
//    [self test3];
//    [self test4];
//    [self test5];
//    [self test6];
}


- (void)test1 {
    // 5
    self.cardCycleView.imageURLStringArray = @[@"http://img4.imgtn.bdimg.com/it/u=2263551760,3456847720&fm=27&gp=0.jpg", @"http://img2.imgtn.bdimg.com/it/u=1572089896,3318564242&fm=200&gp=0.jpg", @"http://img3.imgtn.bdimg.com/it/u=2336514904,1850230253&fm=200&gp=0.jpg", @"http://img3.imgtn.bdimg.com/it/u=2336514904,1850230253&fm=200&gp=0.jpg", @"http://img3.imgtn.bdimg.com/it/u=2336514904,1850230253&fm=200&gp=0.jpg"];
    
    // 4
//    self.cardCycleView.imageURLStringArray = @[@"http://img4.imgtn.bdimg.com/it/u=2263551760,3456847720&fm=27&gp=0.jpg", @"http://img2.imgtn.bdimg.com/it/u=1572089896,3318564242&fm=200&gp=0.jpg", @"http://img3.imgtn.bdimg.com/it/u=2336514904,1850230253&fm=200&gp=0.jpg", @"http://img3.imgtn.bdimg.com/it/u=2336514904,1850230253&fm=200&gp=0.jpg", @"http://img3.imgtn.bdimg.com/it/u=2336514904,1850230253&fm=200&gp=0.jpg", @"http://img3.imgtn.bdimg.com/it/u=2336514904,1850230253&fm=200&gp=0.jpg"];
    
    // 3
    //    self.cardCycleView.imageURLStringArray = @[@"http://img4.imgtn.bdimg.com/it/u=2263551760,3456847720&fm=27&gp=0.jpg", @"http://img2.imgtn.bdimg.com/it/u=1572089896,3318564242&fm=200&gp=0.jpg", @"http://img3.imgtn.bdimg.com/it/u=2336514904,1850230253&fm=200&gp=0.jpg"];
    
    // 2
//        self.cardCycleView.imageURLStringArray = @[@"http://img4.imgtn.bdimg.com/it/u=2263551760,3456847720&fm=27&gp=0.jpg", @"http://img2.imgtn.bdimg.com/it/u=1572089896,3318564242&fm=200&gp=0.jpg"];
    
//    [self.view addSubview:self.bannerView];
    [self.view addSubview:self.cardCycleView];
}

- (BMCarouselBannerView *)bannerView {
    if (!_bannerView) {
        CGFloat width = [UIScreen mainScreen].bounds.size.width;
        CGFloat height = 160 * width / 320;
        _bannerView = [[BMCarouselBannerView alloc] initWithFrame:CGRectMake(0, 50, width, height)];
        _bannerView.selectedAction = ^(NSInteger index) {
            NSLog(@"index: %ld", (long)index);
        };
    }
    return _bannerView;
}

- (BMCardCycleView *)cardCycleView {
    if (!_cardCycleView) {
        CGFloat width = [UIScreen mainScreen].bounds.size.width;
        CGFloat height = 160 * width / 320;
        _cardCycleView = [[BMCardCycleView alloc] initWithFrame:CGRectMake(0, 50, width, height)];
        _cardCycleView.selectedAction = ^(NSInteger index) {
            NSLog(@"index: %ld", (long)index);
        };
    }
    return _cardCycleView;
}

- (void)test6 {
    
}

- (void)test5 {
    self.blockView.layer.cornerRadius = 1.5;
}

- (void)test4 {
    self.middleButton.layer.cornerRadius = 45 / 2.0;
    NSLog(@"%@", self.middleButton.currentTitle);
}

- (void)test3 {
//    self.textView.textContainerInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.textView.textContainerInset = UIEdgeInsetsMake(0, -4, 0, -4);
}

- (void)test2 {
    self.test13View = [[BMTest13View alloc] initWithFrame:CGRectMake(10, 100, 200, 200)];
    
//    BMTest13View *testView = [[BMTest13View alloc] initWithFrame:CGRectMake(10, 100, 200, 200)];
//    [self.view addSubview:testView];
}

- (void)test0 {
    self.imageView0.image = [UIImage imageNamed:@"voucher_empty"];
    
    self.imageView0.layer.cornerRadius = 4.0;
    self.imageView0.layer.shadowColor = [UIColor colorWithHexString:@"0656f1"].CGColor;
    self.imageView0.layer.shadowRadius = 4;
    self.imageView0.layer.shadowOpacity = 0.2;
    self.imageView0.layer.shadowOffset = CGSizeMake(0, 0);
}

@end
