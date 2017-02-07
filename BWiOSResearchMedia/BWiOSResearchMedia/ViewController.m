//
//  ViewController.m
//  BWiOSResearchMedia
//
//  Created by BobWong on 2017/2/7.
//  Copyright © 2017年 BobWong. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIView *videoView;

@property (nonatomic, strong) AVPlayer *player;
@property (nonatomic, strong) AVPlayerItem *playerItem;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSString *videoURLString = @"/Users/BobWong/Desktop/test.mp4";
    NSString *videoPath = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"mp4"];
    NSString *webVideoURLString = @"http://pubfile.bluemoon.com.cn/group1/M00/04/85/wKgwBliX3zqASBQkAG-e7r3kAYw078.mp4";
    
    if (!_player) {
        NSURL *videoURL = [NSURL URLWithString:webVideoURLString];
        //        NSURL *videoURL = [NSURL fileURLWithPath:videoPath];
        
        _player = [AVPlayer playerWithURL:videoURL];
        _playerItem = _player.currentItem;
        
        //        _playerItem = [AVPlayerItem playerItemWithAsset:[AVURLAsset URLAssetWithURL:videoURL options:nil]];
        //        _player = [AVPlayer playerWithPlayerItem:_playerItem];
        
        AVPlayerLayer *layer = [AVPlayerLayer playerLayerWithPlayer:_player];
        layer.frame = self.videoView.bounds;
        layer.backgroundColor = UIColor.grayColor.CGColor;
        [_videoView.layer addSublayer:layer];
        
        
        [_playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];  // 监听status属性
        [_playerItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];// 监听loadedTimeRanges属性
    }
}

- (IBAction)buttonActionPlay:(UIButton *)sender {
    [_player play];
}


#pragma mark - KVO回调方法

//keyPath:变化的属性的名称  如果属性是声明在.m中就监测不到？
//object:被观察的对象
//change:存放属性变化前后的值
//context:添加观察者时候context的值
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    AVPlayerItem *item = (AVPlayerItem *)object;
    
    NSLog(@"new -- %@ ",change[NSKeyValueChangeNewKey]);  // 变化之后的值
    NSLog(@"old -- %@",change[NSKeyValueChangeOldKey]);  // 取出变化之前的值
    
    if ([keyPath isEqualToString:@"status"]) {
        AVPlayerItemStatus status = [change[NSKeyValueChangeNewKey]intValue];
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
                [self.player play];
                //            _isReayToPlay = YES;
            }
                break;
            default:
                break;
        }
    }
    else if ([keyPath isEqualToString:@"loadedTimeRanges"]) {
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    _playerItem removeObserver:self forKeyPath:<#(nonnull NSString *)#>
}

@end
