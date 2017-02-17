//
//  ZFPlayerView+BWExtension.h
//  BWiOSResearchMedia
//
//  Created by BobWong on 2017/2/16.
//  Copyright © 2017年 BobWong. All rights reserved.
//

#import <ZFPlayer/ZFPlayer.h>

@interface ZFPlayerView (BWExtension)

/**
 创建默认样式的播放View
 */
+ (ZFPlayerView *)bw_playerViewWithPlayerModel:(ZFPlayerModel *)playerModel;

/**
 设置下载按钮的状态，是否为已下载
 */
- (void)setDownloadButtonState:(BOOL)enable;

@end
