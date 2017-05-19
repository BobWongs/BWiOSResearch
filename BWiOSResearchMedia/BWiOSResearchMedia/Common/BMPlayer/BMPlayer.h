//
//  BMPlayer.h
//  BMWash
//
//  Created by elvin on 2016/12/5.
//  Copyright © 2016年 月亮小屋（中国）有限公司. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import <UIKit/UIKit.h>

//用于播放视频
//1、本地没有缓存，下载网络视频，缓存到本地，直接播放本地的视频
//2、本地有缓存，直接播放本地视频
//3、缓存的文件用URL最后一个字符串命名，存放在tmp目录下

@interface BMPlayer : NSObject

+ (instancetype)sharedInstance;
- (void)playWithUrl:(NSURL *)url showView:(UIView *)showView;

- (void)resume;
- (void)pause;
- (void)stop;
@end
