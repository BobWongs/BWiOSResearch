//
//  BMPlayer.m
//  BMWash
//
//  Created by elvin on 2016/12/5.
//  Copyright © 2016年 月亮小屋（中国）有限公司. All rights reserved.
//

#import "BMPlayer.h"

@interface BMPlayer ()

@property (nonatomic, strong) AVURLAsset     *videoURLAsset;
@property (nonatomic, strong) AVAsset        *videoAsset;
@property (nonatomic, strong) AVPlayer       *player;
@property (nonatomic, strong) AVPlayerItem   *currentPlayerItem;
@property (nonatomic, strong) AVPlayerLayer  *currentPlayerLayer;

@end

@implementation BMPlayer

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static id _sInstance;
    dispatch_once(&onceToken, ^{
        _sInstance = [[self alloc] init];
    });
    
    return _sInstance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

//清空播放器
- (void)releasePlayer
{
    if (!self.currentPlayerItem) {
        return;
    }
    self.currentPlayerItem = nil;
}

- (void)playWithUrl:(NSURL *)url showView:(UIView *)showView
{
    
    [self.player pause];
    [self releasePlayer];
    
    //开始播放，监听播放结束通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playerItemDidPlayToEnd:) name:AVPlayerItemDidPlayToEndTimeNotification object:self.currentPlayerItem];
    //开始播放，监听app进入后台通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appDidEnterBackground) name:UIApplicationWillResignActiveNotification object:nil];
    //开始播放，监听app回到前台通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appDidEnterPlayGround) name:UIApplicationDidBecomeActiveNotification object:nil];
    
    self.videoAsset  = [AVURLAsset URLAssetWithURL:url options:nil];
    self.currentPlayerItem = [AVPlayerItem playerItemWithAsset:_videoAsset];
    if (!self.player) {
        self.player = [AVPlayer playerWithPlayerItem:self.currentPlayerItem];
    } else {
        [self.player replaceCurrentItemWithPlayerItem:self.currentPlayerItem];
    }
    self.currentPlayerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    [showView.layer addSublayer:self.currentPlayerLayer];
    
    self.currentPlayerLayer.frame = CGRectZero;
    //    popanimation
    [UIView animateWithDuration:1.5 animations:^{
        self.currentPlayerLayer.frame = CGRectMake(0, 44, showView.bounds.size.width, showView.bounds.size.height-44);
        [self.player play];
    }];
}

#pragma mark - observer

- (void)appDidEnterBackground
{
    [self pause];
}
- (void)appDidEnterPlayGround
{
    [self resume];
}

- (void)resume
{
    if (!self.currentPlayerItem) {
        return;
    }
    [self.player play];
}

- (void)pause
{
    if (!self.currentPlayerItem) {
        return;
    }
    [self.player pause];
}

- (void)stop
{
    [self.player pause];
    [self releasePlayer];
}

//播放结束
- (void)playerItemDidPlayToEnd:(NSNotification *)notification
{
    NSLog(@"播放结束，重新播放！！！！！！");
    [self.player seekToTime:CMTimeMakeWithSeconds(0, NSEC_PER_SEC) completionHandler:^(BOOL finished) {
        [self.player play];
    }];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self releasePlayer];
}

@end
