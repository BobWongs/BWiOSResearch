//
//  BWVideoPlayer.m
//  BWiOSResearchMedia
//
//  Created by BobWong on 2017/2/17.
//  Copyright © 2017年 BobWong. All rights reserved.
//

#import "BWVideoPlayer.h"
#import <ZFPlayer/ZFPlayer.h>
#import "BWVideoManager.h"
#import "Masonry.h"


#define KEY_PLAYER_STATE @"state"


@interface BWVideoPlayer () <ZFPlayerDelegate>

/*
 UI
 */
@property (strong, nonatomic) ZFPlayerView *playerView;  ///< Player view
@property (strong, nonatomic) ZFPlayerControlView *controlView;  ///< Control view
@property (strong, nonatomic) UIButton *playButton;  ///< Play button

/*
 Data
 */
@property (strong, nonatomic) ZFPlayerModel *playerModel;  ///< Player model

@end

@implementation BWVideoPlayer

#pragma mark - 生命周期

- (instancetype)initCustomPlayerWithPlayerModel:(ZFPlayerModel *)playerModel {
    if (self = [super init]) {
        [self setDataWithPlayerModel:playerModel];
        [self setUI];
    }
    return self;
}

- (void)setDataWithPlayerModel:(ZFPlayerModel *)playerModel {
    self.playerModel = [[self class] playerModelCopyFromModel:playerModel];
    NSURL *resultURLString = [[BWVideoManager sharedManager] getVideoURLWithURLString:self.playerModel.videoURL.absoluteString];  // 若有本地文件，则转换为本地URL
    self.playerModel.videoURL = resultURLString;
    
    [self.playerView addObserver:self forKeyPath:KEY_PLAYER_STATE options:NSKeyValueObservingOptionNew context:nil];  // KVO
}

- (void)setUI {
    [self.controlView addSubview:self.playButton];
    __weak typeof(self.controlView) weakControlView = self.controlView;
    [self.playButton mas_makeConstraints:^(MASConstraintMaker *make) {
        __strong typeof(weakControlView) strongView = weakControlView;
        make.centerX.mas_equalTo(strongView.mas_centerX);
        make.centerY.mas_equalTo(strongView.mas_centerY);
        make.width.height.mas_equalTo(60.0);
    }];
    
    [self.playerView playerControlView:self.controlView playerModel:self.playerModel];
    self.playerView.hasDownload = YES;  // 打开下载功能（默认没有这个功能）
    
    // 初始隐藏播放控件
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.03 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        SEL hideSelector = @selector(zf_playerHideControlView);
        if ([self.controlView respondsToSelector:hideSelector]) [self.controlView performSelector:hideSelector];
    });
#pragma clang diagnostic pop
}

- (void)dealloc {
    [self.playerView removeObserver:self forKeyPath:KEY_PLAYER_STATE];
}

#pragma mark - Action

// Play video.
- (void)playButtonAction:(UIButton *)sender
{
    self.playButton.hidden = YES;
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    UIButton *playButton = (UIButton *)[self.controlView valueForKey:@"playeBtn"];
    if (playButton) {
        SEL playSelector = @selector(playBtnClick:);
        if ([self.controlView respondsToSelector:playSelector]) [self.controlView performSelector:playSelector withObject:playButton];
    }
#pragma clang diagnostic pop
}

#pragma mark - Public Method

- (void)play {
    
}

- (void)pause {
    if (self.playerView.state == ZFPlayerStatePlaying) [self.playerView pause];
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

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    ZFPlayerState status = [change[NSKeyValueChangeNewKey] intValue];
    self.playButton.hidden = (status == ZFPlayerStatePause) ? NO : YES;
}

#pragma mark - Tool

- (void)setDownloadButtonState:(BOOL)enable {
    UIButton *downLoadButton = (UIButton *)[self.controlView valueForKey:@"downLoadBtn"];
    if (downLoadButton) downLoadButton.enabled = enable;
}

+ (ZFPlayerModel *)playerModelCopyFromModel:(ZFPlayerModel *)playerModel {
    ZFPlayerModel *copyModel = [ZFPlayerModel new];
    copyModel.title = playerModel.title;
    copyModel.videoURL = playerModel.videoURL;
    copyModel.placeholderImage = playerModel.placeholderImage;
    copyModel.placeholderImageURLString = playerModel.placeholderImageURLString;
    copyModel.resolutionDic = playerModel.resolutionDic;
    copyModel.seekTime = playerModel.seekTime;
    copyModel.tableView = playerModel.tableView;
    copyModel.indexPath = playerModel.indexPath;
    copyModel.fatherView = playerModel.fatherView;
    return copyModel;
}

#pragma mark - Getter and Setter

- (ZFPlayerView *)playerView {
    if (!_playerView) {
        _playerView = [[ZFPlayerView alloc] init];
        _playerView.delegate = self;  // 设置代理
        _playerView.hasPreviewView = YES;  // 打开预览图
        if ([self.playerModel.videoURL.absoluteString.lowercaseString hasPrefix:@"file"]) [self setDownloadButtonState:NO];  // 为本地文件
    }
    return _playerView;
}

- (ZFPlayerControlView *)controlView {
    if (!_controlView) {
        _controlView = [[ZFPlayerControlView alloc] init];
        _controlView.clipsToBounds = YES;
        UIView *backBtn = (UIView *)[_controlView valueForKey:@"backBtn"];
        if (backBtn) backBtn.hidden = YES;  // 隐藏视频播放框架的返回按钮
        
        UIImageView *placeholderImageView = (UIImageView *)[_controlView valueForKey:@"placeholderImageView"];
        if (placeholderImageView) placeholderImageView.contentMode =UIViewContentModeScaleAspectFill;
    }
    return _controlView;
}

- (UIButton *)playButton {
    if (!_playButton) {
        _playButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_playButton setImage:[UIImage imageNamed:@"btn_video_play"] forState:UIControlStateNormal];
        [_playButton addTarget:self action:@selector(playButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _playButton;
}

@end
