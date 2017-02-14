//
//  ZFHomeViewController.m
//  BWiOSResearchMedia
//
//  Created by BobWong on 2017/2/14.
//  Copyright © 2017年 BobWong. All rights reserved.
//

#import "ZFHomeViewController.h"
#import "BWVideoManager.h"

@interface ZFHomeViewController ()

@property (weak, nonatomic) IBOutlet UILabel *cacheSizeLabel;

@end

@implementation ZFHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self resetCacheLabel];
}

- (IBAction)clearAllCache:(id)sender {
    [BWVideoSharedManager clearAllCache];
    [self resetCacheLabel];
}

- (void)resetCacheLabel {
    self.cacheSizeLabel.text = [NSString stringWithFormat:@"%f M", [BWVideoSharedManager getCache]];
}

@end
