//
//  ZFHomeViewController.m
//  BWiOSResearchMedia
//
//  Created by BobWong on 2017/2/14.
//  Copyright © 2017年 BobWong. All rights reserved.
//

#import "ZFHomeViewController.h"
#import "BWVideoManager.h"
#import "UIImageView+WebCache.h"

@interface ZFHomeViewController ()

@property (weak, nonatomic) IBOutlet UILabel *cacheSizeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

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
    self.cacheSizeLabel.text = [NSString stringWithFormat:@"%f M", [BWVideoSharedManager getCache] / (1024.0 * 1024.0)];
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:@"https://ss0.baidu.com/6ONWsjip0QIZ8tyhnq/it/u=1392219153,1359969436&fm=80&w=179&h=119&img.JPEG"]];
}

@end
