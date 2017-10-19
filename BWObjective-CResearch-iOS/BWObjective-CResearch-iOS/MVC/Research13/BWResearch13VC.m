//
//  BWResearch13VC.m
//  BWObjective-CResearch-iOS
//
//  Created by BobWong on 2017/10/18.
//  Copyright © 2017年 BobWong. All rights reserved.
//

#import "BWResearch13VC.h"
#import <iCarousel.h>
#import "BMCardBannerView.h"

@interface BWResearch13VC ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView0;
@property (strong, nonatomic) BMCardBannerView *bannerView;

@end

@implementation BWResearch13VC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self test1];
}

- (void)test0 {
    self.imageView0.image = [UIImage imageNamed:@"voucher_empty"];
    
    self.imageView0.layer.cornerRadius = 4.0;
    self.imageView0.layer.shadowColor = [UIColor colorWithHexString:@"0656f1"].CGColor;
    self.imageView0.layer.shadowRadius = 4;
    self.imageView0.layer.shadowOpacity = 0.2;
    self.imageView0.layer.shadowOffset = CGSizeMake(0, 0);
}

- (void)test1 {
    self.bannerView.imageURLStringArray = @[@"http://img4.imgtn.bdimg.com/it/u=2263551760,3456847720&fm=27&gp=0.jpg", @"http://img2.imgtn.bdimg.com/it/u=1572089896,3318564242&fm=200&gp=0.jpg", @"http://img3.imgtn.bdimg.com/it/u=2336514904,1850230253&fm=200&gp=0.jpg"];
    [self.view addSubview:self.bannerView];
}

- (BMCardBannerView *)bannerView {
    if (!_bannerView) {
        CGFloat sw = [UIScreen mainScreen].bounds.size.width;
        _bannerView = [[BMCardBannerView alloc] initWithFrame:CGRectMake(0, 50, sw, 160)];
        _bannerView.selectedAction = ^(NSInteger index) {
            NSLog(@"index: %ld", (long)index);
        };
    }
    return _bannerView;
}

@end
