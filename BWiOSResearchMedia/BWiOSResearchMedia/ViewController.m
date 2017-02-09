//
//  ViewController.m
//  BWiOSResearchMedia
//
//  Created by BobWong on 2017/2/7.
//  Copyright © 2017年 BobWong. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <>

#define kStatus @"status"
#define kLoadedTimeRanges @"loadedTimeRanges"

@interface ViewController () {
    double _fullTime;
}

/*
 UI
 */
@property (weak, nonatomic) IBOutlet UIView *videoView;
@property (weak, nonatomic) IBOutlet UILabel *fullTimeLabel;
@property (weak, nonatomic) IBOutlet UIProgressView *cacheProgressView;
@property (weak, nonatomic) IBOutlet UISlider *controlProgressSlider;
@property (nonatomic, weak) IBOutlet UILabel *currentTimeLable;  ///< 显示当前播放时长

/*
 Data
 */
@property (nonatomic, strong) AVPlayer *player;
@property (nonatomic, strong) AVPlayerItem *playerItem;

@property (nonatomic, strong) NSString *status_playType;  // 正在播放, 等待播放


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _fullTime = 1;
    
    
    NSString *videoURLString = @"/Users/BobWong/Desktop/test.mp4";
    NSString *videoPath = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"mp4"];
    NSString *webVideoURLString = @"http://pubfile.bluemoon.com.cn/group1/M00/04/85/wKgwBliX3zqASBQkAG-e7r3kAYw078.mp4";
    
    if (!_player) {
        NSURL *videoURL = [NSURL URLWithString:webVideoURLString];
        //        NSURL *videoURL = [NSURL fileURLWithPath:videoPath];
        
//        _player = [AVPlayer playerWithURL:videoURL];
//        _playerItem = _player.currentItem;
        
        _playerItem = [AVPlayerItem playerItemWithAsset:[AVURLAsset URLAssetWithURL:videoURL options:nil]];
        _player = [AVPlayer playerWithPlayerItem:_playerItem];
        
        AVPlayerLayer *layer = [AVPlayerLayer playerLayerWithPlayer:_player];
        layer.frame = self.videoView.bounds;
        layer.backgroundColor = UIColor.grayColor.CGColor;
        [_videoView.layer addSublayer:layer];
        
        
        [_playerItem addObserver:self forKeyPath:kStatus options:NSKeyValueObservingOptionNew context:nil];  // 监听status属性
        [_playerItem addObserver:self forKeyPath:kLoadedTimeRanges options:NSKeyValueObservingOptionNew context:nil];// 监听loadedTimeRanges属性
    }
    
    [_player pause];
}

- (IBAction)buttonActionPlay:(UIButton *)sender {
    [_player play];
}

- (IBAction)buttonActionStop:(id)sender {
    [_player pause];
}

- (IBAction)buttonActionEnd:(id)sender {
    NSLog(@"End");
}

- (IBAction)buttonActionClearCache:(id)sender {
    NSLog(@"Clear Cache");
}

- (IBAction)buttonActionPlayVideo:(id)sender {
    AVPlayer *player = [AVPlayer playerWithURL:[NSURL URLWithString:@"http://pubfile.bluemoon.com.cn/group1/M00/04/85/wKgwBliX3zqASBQkAG-e7r3kAYw078.mp4"]];
    AVPlayerViewController *playerVC = [[AVPlayerViewController alloc]init];
    playerVC.player = player;
}

#pragma mark - KVO回调方法

//keyPath:变化的属性的名称  如果属性是声明在.m中就监测不到？
//object:被观察的对象
//change:存放属性变化前后的值
//context:添加观察者时候context的值
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    AVPlayerItem *item = (AVPlayerItem *)object;
    
    if ([keyPath isEqualToString:@"status"]) {
        AVPlayerItemStatus status = [change[NSKeyValueChangeNewKey] intValue];
        //对比，看目前播放单元的状态
        switch (status) {
            case AVPlayerItemStatusUnknown:
                NSLog(@"未知状态");
                break;
            case AVPlayerItemStatusFailed:
                NSLog(@"失败");
                break;
            case AVPlayerItemStatusReadyToPlay:
            {
                NSLog(@"准备好播放");
                _fullTime = CMTimeGetSeconds(self.player.currentItem.duration);
                self.fullTimeLabel.text = [NSString stringWithFormat:@"%fs", _fullTime];
            }
                break;
            default:
                break;
        }
    }
    else if ([keyPath isEqualToString:@"loadedTimeRanges"]) {
//        NSLog(@"new ranges -- %@ ", change[NSKeyValueChangeNewKey]);  // 变化之后的值
//        NSLog(@"old ranges -- %@", change[NSKeyValueChangeOldKey]);  // 取出变化之前的值
        
        NSTimeInterval timeInterval = [self availableDuration];  // 计算缓冲进度
        self.cacheProgressView.progress = timeInterval / _fullTime;  // 缓存进度
        self.controlProgressSlider.value = [self getCurrentPlayingTime] / _fullTime;  // 播放进度
        
//        NSLog(@"已缓存时长 : %f",timeInterval);
        
        self.currentTimeLable.text = [NSString stringWithFormat:@"当前播放时长： %fs \n已缓存： %f", self.getCurrentPlayingTime, timeInterval];
        
        if (timeInterval > self.getCurrentPlayingTime + 5){ // 缓存 大于 播放 当前时长+5
            if ([self.status_playType  isEqual: @"等待播放"]) { // 接着之前 播放时长 继续播放
                [self.player play];
                self.status_playType = @"正在播放";
            }
        } else {
            self.status_playType = @"等待播放"; // 出现问题，等待播放
            NSLog(@"等待播放，网络出现问题");
        }
    }
}

/**
 *  返回 当前 视频 播放时长
 */
- (double)getCurrentPlayingTime{
//    return self.player.currentTime.value/self.player.currentTime.timescale;
    return CMTimeGetSeconds(self.player.currentTime);
}

/**
 *  返回 当前 视频 缓存时长
 */
- (NSTimeInterval)availableDuration{
    NSArray *loadedTimeRanges = [[self.player currentItem] loadedTimeRanges];
    CMTimeRange timeRange = [loadedTimeRanges.firstObject CMTimeRangeValue];// 获取缓冲区域
    float startSeconds = CMTimeGetSeconds(timeRange.start);
    float durationSeconds = CMTimeGetSeconds(timeRange.duration);
    NSTimeInterval result = startSeconds + durationSeconds;// 计算缓冲总进度
    
    return result;
}

- (void)dealloc {
    [_playerItem removeObserver:self forKeyPath:kStatus];
    [_playerItem removeObserver:self forKeyPath:kLoadedTimeRanges];
}

@end
