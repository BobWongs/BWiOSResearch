//
//  BWVideoManager.h
//  BWiOSResearchMedia
//
//  Created by BobWong on 2017/2/13.
//  Copyright © 2017年 BobWong. All rights reserved.
//

#import <Foundation/Foundation.h>

#define BWVideoSharedManager [BWVideoManager sharedManager]
#define MAX_DOWNLOAD_COUNT 5

@interface BWVideoManager : NSObject

+ (instancetype)sharedManager;

- (void)downloadVideoWithURL:(NSString *)URLString progress:(void (^)(NSProgress *))progress completion:(dispatch_block_t)completion;

/**
 *  Get video URL, if has cache, return the cache URL.
 */
- (NSURL *)getVideoURLWithURLString:(NSString *)URLString;

/**
 *  Clear all cache data.
 */
- (void)clearAllCache;

- (double)getCache;

- (BOOL)clearCacheWithFileName:(NSString *)fileName;

@end
