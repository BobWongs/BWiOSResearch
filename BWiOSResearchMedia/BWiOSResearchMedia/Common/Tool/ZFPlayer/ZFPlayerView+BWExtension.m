//
//  ZFPlayerView+BWExtension.m
//  BWiOSResearchMedia
//
//  Created by BobWong on 2017/2/16.
//  Copyright © 2017年 BobWong. All rights reserved.
//

#import "ZFPlayerView+BWExtension.h"

@implementation ZFPlayerView (BWExtension)

- (ZFPlayerView *)bw_initWithPlayerModel:(ZFPlayerModel *)playerModel {
    ZFPlayerView *playerView = [[ZFPlayerView alloc] init];
    
    // 自定义视频播放控制视图
    ZFPlayerControlView *controlView = [[ZFPlayerControlView alloc] init];
    UIView *backBtn = (UIView *)[controlView valueForKey:@"backBtn"];
    if (backBtn) backBtn.hidden = YES;
    [playerView playerControlView:controlView playerModel:playerModel];
    
    // 设置代理
    playerView.delegate = self;
    
    //（可选设置）可以设置视频的填充模式，内部设置默认（ZFPlayerLayerGravityResizeAspect：等比例填充，直到一个维度到达区域边界）
    // self.playerView.playerLayerGravity = ZFPlayerLayerGravityResizeAspect;
    
    // 打开下载功能（默认没有这个功能）
    playerView.hasDownload    = YES;
    // 打开预览图
    playerView.hasPreviewView = YES;
    
    // 是否自动播放，默认不自动播放
    //    [self.playerView autoPlayTheVideo];
    
    return playerView;
}

@end
