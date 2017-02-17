//
//  ZFPlayerView+BWExtension.m
//  BWiOSResearchMedia
//
//  Created by BobWong on 2017/2/16.
//  Copyright © 2017年 BobWong. All rights reserved.
//

#import "ZFPlayerView+BWExtension.h"
#import "BWVideoManager.h"
#import "Masonry.h"

@interface ZFPlayerView () <ZFPlayerDelegate>

@end

@implementation ZFPlayerView (BWExtension)

#pragma mark - Init

+ (ZFPlayerView *)bw_playerViewWithPlayerModel:(ZFPlayerModel *)playerModel {
    ZFPlayerView *playerView = [[ZFPlayerView alloc] init];
    
    // 自定义视频播放控制视图
    ZFPlayerControlView *controlView = [[ZFPlayerControlView alloc] init];
    UIView *backBtn = (UIView *)[controlView valueForKey:@"backBtn"];
    if (backBtn) backBtn.hidden = YES;  // 隐藏视频播放框架的返回按钮
    
    ZFPlayerModel *playerModelCopy = [[self class] playerModelCopyFromModel:playerModel];
    NSURL *resultURLString = [[BWVideoManager sharedManager] getVideoURLWithURLString:playerModelCopy.videoURL.absoluteString];  // 若有本地文件，则转换为本地URL
    playerModelCopy.videoURL = resultURLString;
    
    [playerView playerControlView:controlView playerModel:playerModelCopy];
    
    playerView.delegate = playerView;  // 设置代理
    playerView.hasDownload    = YES;  // 打开下载功能（默认没有这个功能）
    playerView.hasPreviewView = YES;  // 打开预览图
    if ([resultURLString.absoluteString.lowercaseString hasPrefix:@"file"]) [playerView setDownloadButtonState:NO];  // 为本地文件
    
    
    // 初始隐藏播放控件
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.03 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        SEL hideSelector = @selector(zf_playerHideControlView);
        if ([controlView respondsToSelector:hideSelector]) [controlView performSelector:hideSelector];
    });
#pragma clang diagnostic pop
    
    return playerView;
}

#pragma mark - ZFPlayerDelegate

- (void)zf_playerDownload:(NSString *)url
{
    __weak typeof(self) weakSelf = self;
    [[BWVideoManager sharedManager] downloadVideoWithURL:url progress:^(NSProgress *progress) {
        
    } completion:^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf setDownloadButtonState:NO];
    }];
}

#pragma mark - Tool

- (void)setDownloadButtonState:(BOOL)enable {
    ZFPlayerControlView *controlView = (ZFPlayerControlView *)[self valueForKey:@"controlView"];
    if (controlView) {
        UIButton *downLoadButton = (UIButton *)[controlView valueForKey:@"downLoadBtn"];
        if (downLoadButton) downLoadButton.enabled = enable;
    }
}

+ (ZFPlayerModel *)playerModelCopyFromModel:(ZFPlayerModel *)playerModel {
    ZFPlayerModel *copyModel = [ZFPlayerModel new];
    copyModel.title = playerModel.title;
    copyModel.videoURL = playerModel.videoURL;
    copyModel.placeholderImage = playerModel.placeholderImage;
    copyModel.placeholderImageURLString = playerModel.placeholderImageURLString;
    copyModel.resolutionDic = playerModel.resolutionDic;
    copyModel.seekTime=playerModel.seekTime;
    copyModel.tableView=playerModel.tableView;
    copyModel.indexPath=playerModel.indexPath;
    copyModel.fatherView=playerModel.fatherView;
    return copyModel;
}

@end
