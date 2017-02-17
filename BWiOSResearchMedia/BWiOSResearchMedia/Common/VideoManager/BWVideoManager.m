//
//  BWVideoManager.m
//  BWiOSResearchMedia
//
//  Created by BobWong on 2017/2/13.
//  Copyright © 2017年 BobWong. All rights reserved.
//

#import "BWVideoManager.h"
#import "AFNetworking.h"
#import <UIKit/UIKit.h>

#define DOCUMENT_PATH [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]
#define VIDEO_CACHE_DIRECTORY_PATH [NSString stringWithFormat:@"%@/%@", DOCUMENT_PATH, @"VideoCache"]
#define NSFileDefaultManager [NSFileManager defaultManager]

#define DEFAULT_MAX_DOWNLOADING_COUNT 5

@interface BWVideoManager ()

@property (strong, nonatomic) NSMutableArray *downloadingURLArray;  ///< Downloading URL array

@end

@implementation BWVideoManager

#pragma mark - 单例

+ (instancetype)sharedManager {
    static BWVideoManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[self alloc] init];
    });
    return sharedManager;
}

- (instancetype)init {
    if (self = [super init]) {
        self.maxDownloadingCount = 0;
        self.downloadingURLArray = [NSMutableArray new];
    }
    return self;
}

#pragma mark - 下载

- (void)downloadVideoWithURL:(NSString *)URLString progress:(void (^)(NSProgress *))progress completion:(dispatch_block_t)completion {
    // Local file or not?

    // Downloaded or not.
    NSString *fileName = URLString.lastPathComponent;
    NSString *filePath = [NSString stringWithFormat:@"%@/%@", VIDEO_CACHE_DIRECTORY_PATH, fileName];
    if ([NSFileDefaultManager fileExistsAtPath:filePath]) {
        [[self class] confirmAlertWithTitle:@"已下载!"];
        return ;
    }
    // Downloading.
    if ([self.downloadingURLArray containsObject:URLString]) {
        [[self class] confirmAlertWithTitle:@"下载中!"];
        return ;
    }
    // Over Downloading count.
    NSUInteger maxDownloadCount = self.maxDownloadingCount ? self.maxDownloadingCount : DEFAULT_MAX_DOWNLOADING_COUNT;
    if (self.downloadingURLArray.count >= maxDownloadCount) {
        [[self class] confirmAlertWithTitle:@"超过最大同时下载数!"];
        return ;
    }
    // Create directory.
    if (![NSFileDefaultManager fileExistsAtPath:VIDEO_CACHE_DIRECTORY_PATH]) {
        if (![NSFileDefaultManager createDirectoryAtPath:VIDEO_CACHE_DIRECTORY_PATH withIntermediateDirectories:YES attributes:nil error:nil]) {
            NSLog(@"Path create failed: %@", VIDEO_CACHE_DIRECTORY_PATH);
            return ;
        }
    }
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *url = [NSURL URLWithString:URLString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    __weak typeof(self) weakSelf = self;
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:^(NSProgress *downloadProgress) {
        
        NSLog(@"totalUnitCount is %lld", downloadProgress.totalUnitCount);
        NSLog(@"completedUnitCount is %lld", downloadProgress.completedUnitCount);
        
        progress(downloadProgress);
        
    } destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        
        NSLog(@"targetPath is %@", filePath);
        return [NSURL fileURLWithPath:filePath];
        
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        NSLog(@"File downloaded to: %@", filePath);
        
        if (response && !error) {
            typeof(weakSelf) __strong strongSelf = weakSelf;
            [strongSelf.downloadingURLArray removeObject:URLString];
        }
        
        completion();
    }];
    
    [self.downloadingURLArray addObject:URLString];
    [downloadTask resume];
}

- (NSURL *)getVideoURLWithURLString:(NSString *)URLString {
    NSString *fileName = URLString.lastPathComponent;
    NSString *filePath = [NSString stringWithFormat:@"%@/%@", VIDEO_CACHE_DIRECTORY_PATH, fileName];
    
    if ([NSFileDefaultManager fileExistsAtPath:filePath]) {
        // Has local file.
        return [NSURL fileURLWithPath:filePath];
    } else {
        // No local file.
        return [NSURL URLWithString:URLString];
    }
}

#pragma mark - 缓存

- (NSUInteger)getCache {
    return [[self class] directoryByteSizeAtPath:VIDEO_CACHE_DIRECTORY_PATH];
}

- (void)clearAllCache {
    NSArray *fileArray = [NSFileDefaultManager contentsOfDirectoryAtPath:VIDEO_CACHE_DIRECTORY_PATH error:nil];
    if (!fileArray || fileArray.count == 0) return ;
    
    for (NSString *fileName in fileArray) {
        NSString *filePath = [NSString stringWithFormat:@"%@/%@", VIDEO_CACHE_DIRECTORY_PATH, fileName];
        [NSFileDefaultManager removeItemAtPath:filePath error:nil];
    }
}

- (BOOL)clearCacheWithFileName:(NSString *)fileName {
    NSString *filePath = [NSString stringWithFormat:@"%@/%@", VIDEO_CACHE_DIRECTORY_PATH, fileName];
    return [NSFileDefaultManager removeItemAtPath:filePath error:nil];
}

#pragma mark - 工具

// 遍历文件夹获得文件夹大小，返回Size已Byte为单位
+ (NSUInteger)directoryByteSizeAtPath:(NSString *)directoryPath {
    NSFileManager *manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:directoryPath]) return 0;
    
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:directoryPath] objectEnumerator];
    NSString *fileName;
    NSUInteger directorySize = 0;
    while ((fileName = [childFilesEnumerator nextObject]) != nil) {
        NSString *fileAbsolutePath = [directoryPath stringByAppendingPathComponent:fileName];
        directorySize += [[manager attributesOfItemAtPath:fileAbsolutePath error:nil] fileSize];
    }
    return directorySize;
}

+ (UIViewController *)topViewController {
    UIViewController *rootViewController = ((UIWindow *)[[[UIApplication sharedApplication] windows] objectAtIndex:0]).rootViewController;
    UIViewController *topViewController = rootViewController;
    while (topViewController.presentedViewController) {
        topViewController = topViewController.presentedViewController;
    }
    return topViewController;
}

+ (void)confirmAlertWithTitle:(NSString *)title {
    UIViewController *viewController = [[self class] topViewController];
    __weak typeof(viewController) weakController = viewController;
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        __strong typeof(weakController) strongController = weakController;
        [strongController dismissViewControllerAnimated:YES completion:nil];
    }]];
    [viewController presentViewController:alertController animated:YES completion:nil];
}

@end
