//
//  BWVideoPlayer.h
//  BWiOSResearchMedia
//
//  Created by BobWong on 2017/2/17.
//  Copyright © 2017年 BobWong. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ZFPlayerModel;

@interface BWVideoPlayer : NSObject

- (instancetype)initCustomPlayerWithPlayerModel:(ZFPlayerModel *)playerModel;
- (void)play;
- (void)pause;

@end
