//
//  BWVideoManager.h
//  BWiOSResearchMedia
//
//  Created by BobWong on 2017/2/13.
//  Copyright © 2017年 BobWong. All rights reserved.
//

#import <Foundation/Foundation.h>

#define AFNETWORKING_2  // AFNetworking版本，注释掉为3.0

#define BWVideoSharedManager [BWVideoManager sharedManager]

@interface BWVideoManager : NSObject

@property (assign, nonatomic) NSUInteger maxDownloadingCount;  ///< 最大的正在下载数，默认为5，如果为0，则使用默认值

+ (instancetype)sharedManager;

#ifdef AFNETWORKING_2
- (void)downloadVideoWithURL:(NSString *)URLString progress:(void (^)(NSProgress *))progress completion:(dispatch_block_t)completion;
#else
- (void)downloadVideoWithURL:(NSString *)URLString progress:(void (^)(NSProgress *))progress completion:(dispatch_block_t)completion;
#endif

/**
 *  Get video URL, if has cache, return the cache URL.
 */
- (NSURL *)getVideoURLWithURLString:(NSString *)URLString;

/**
 *  Clear all cache data.
 */
- (void)clearAllCache;

- (NSUInteger)getCache;

- (BOOL)clearCacheWithFileName:(NSString *)fileName;

@end
