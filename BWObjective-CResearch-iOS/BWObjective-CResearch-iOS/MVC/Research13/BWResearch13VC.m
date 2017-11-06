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
#import "BMTest13View.h"

@interface BWResearch13VC ()

@property (strong, nonatomic) IBOutlet BMTest13View *test13View;
@property (weak, nonatomic) IBOutlet UIImageView *imageView0;
@property (strong, nonatomic) BMCardBannerView *bannerView;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIButton *middleButton;

@end

@implementation BWResearch13VC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self test1];
//    [self test2];
//    [self test3];
//    [self test4];
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

- (void)test1 {
    // 5
//    self.bannerView.imageURLStringArray = @[@"http://img4.imgtn.bdimg.com/it/u=2263551760,3456847720&fm=27&gp=0.jpg", @"http://img2.imgtn.bdimg.com/it/u=1572089896,3318564242&fm=200&gp=0.jpg", @"http://img3.imgtn.bdimg.com/it/u=2336514904,1850230253&fm=200&gp=0.jpg", @"http://img3.imgtn.bdimg.com/it/u=2336514904,1850230253&fm=200&gp=0.jpg", @"http://img3.imgtn.bdimg.com/it/u=2336514904,1850230253&fm=200&gp=0.jpg"];
    
    // 3
//    self.bannerView.imageURLStringArray = @[@"http://img4.imgtn.bdimg.com/it/u=2263551760,3456847720&fm=27&gp=0.jpg", @"http://img2.imgtn.bdimg.com/it/u=1572089896,3318564242&fm=200&gp=0.jpg", @"http://img3.imgtn.bdimg.com/it/u=2336514904,1850230253&fm=200&gp=0.jpg"];
    
    // 2
    self.bannerView.imageURLStringArray = @[@"http://img4.imgtn.bdimg.com/it/u=2263551760,3456847720&fm=27&gp=0.jpg", @"http://img2.imgtn.bdimg.com/it/u=1572089896,3318564242&fm=200&gp=0.jpg"];
    
    [self.view addSubview:self.bannerView];
}

- (BMCardBannerView *)bannerView {
    if (!_bannerView) {
        CGFloat width = [UIScreen mainScreen].bounds.size.width;
        CGFloat height = 160 * width / 320;
        _bannerView = [[BMCardBannerView alloc] initWithFrame:CGRectMake(0, 50, width, height)];
        _bannerView.selectedAction = ^(NSInteger index) {
            NSLog(@"index: %ld", (long)index);
        };
    }
    return _bannerView;
}

@end
