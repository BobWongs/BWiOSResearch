//
//  BWZFPlayerViewController.m
//  BWiOSResearchMedia
//
//  Created by BobWong on 2017/2/13.
//  Copyright © 2017年 BobWong. All rights reserved.
//

#import "BWZFPlayerViewController.h"
#import "ZFPlayer.h"
#import "AFNetworking.h"
#import "BWVideoManager.h"
#import "ZFPlayerView+BWExtension.h"
#import "BWVideoPlayer.h"

@interface BWZFPlayerViewController ()

@property (weak, nonatomic)  IBOutlet UIView *playerSuperView;
@property (strong, nonatomic) ZFPlayerView *playerView;
@property (strong, nonatomic) ZFPlayerControlView *controlView;  ///< Control View
@property (nonatomic, assign) BOOL isPlaying;
@property (nonatomic, strong) ZFPlayerModel *playerModel;

@property (strong, nonatomic) BWVideoPlayer *videoPlayer;  ///< Video player

@end

@implementation BWZFPlayerViewController

- (void)dealloc
{
    NSLog(@"%@释放了",self.class);
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
//    // pop回来时候是否自动播放
//    if (self.navigationController.viewControllers.count == 2 && self.playerView && self.isPlaying) {
//        self.isPlaying = NO;
//        [self.playerView play];
//    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
//    // push出下一级页面时候暂停
//    if (self.navigationController.viewControllers.count == 3 && self.playerView && !self.playerView.isPauseByUser)
//    {
//        self.isPlaying = YES;
//        [self.playerView pause];
//    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.playerView = [ZFPlayerView bw_playerViewWithPlayerModel:self.playerModel];
    
    self.videoPlayer = [[BWVideoPlayer alloc] initCustomPlayerWithPlayerModel:self.playerModel];
    
}

// 返回值要必须为NO
- (BOOL)shouldAutorotate
{
    return NO;
}

#pragma mark - Getter

- (ZFPlayerModel *)playerModel
{
    if (!_playerModel) {
        _playerModel = [[ZFPlayerModel alloc] init];
        _playerModel.title = @" ";
        _playerModel.videoURL = [NSURL URLWithString:@"http://pubfile.bluemoon.com.cn/group1/M00/04/85/wKgwBliX3zqASBQkAG-e7r3kAYw078.mp4"];
        _playerModel.placeholderImage = [UIImage imageNamed:@"bg_image"];
        _playerModel.fatherView = self.playerSuperView;
    }
    return _playerModel;
}

#pragma mark - Tool

@end
