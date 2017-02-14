//
//  BWVideoManager.m
//  BWiOSResearchMedia
//
//  Created by BobWong on 2017/2/13.
//  Copyright © 2017年 BobWong. All rights reserved.
//

#import "BWVideoManager.h"
#import "AFNetworking.h"

#define DOCUMENT_PATH [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]
#define VIDEO_CACHE_DIRECTORY_PATH [NSString stringWithFormat:@"%@/%@", DOCUMENT_PATH, @"VideoCache"]
#define NSFileDefaultManager [NSFileManager defaultManager]

@interface BWVideoManager ()

@property (strong, nonatomic) NSMutableArray *downloadingURLArray;  ///< Downloading URL array

@end

@implementation BWVideoManager

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
        self.downloadingURLArray = [NSMutableArray new];
    }
    return self;
}


- (void)downloadVideoWithURL:(NSString *)URLString {
    // Local file.
//    if (![URLString localizedCaseInsensitiveContainsString:@"http"]) {
//        NSLog(@"Local file.");
//        return ;
//    }
    // Downloaded or not.
    NSString *fileName = URLString.lastPathComponent;
    NSString *filePath = [NSString stringWithFormat:@"%@/%@", VIDEO_CACHE_DIRECTORY_PATH, fileName];
    if ([NSFileDefaultManager fileExistsAtPath:filePath]) {
        NSLog(@"file has downloaded!");
        return ;
    }
    // Downloading.
    if ([self.downloadingURLArray containsObject:URLString]) {
        NSLog(@"Downloading URLString: %@.", URLString);
        return ;
    }
    // Over Downloading count.
    if (self.downloadingURLArray.count >= 5) {
        NSLog(@"Over downloading URL count");
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
        
    } destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        
        NSLog(@"targetPath is %@", filePath);
        return [NSURL fileURLWithPath:filePath];
        
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        NSLog(@"File downloaded to: %@", filePath);
        
        typeof(weakSelf) __strong strongSelf = weakSelf;
        [strongSelf.downloadingURLArray removeObject:URLString];
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

- (double)getCache {
    return [self directorySizeAtPath:VIDEO_CACHE_DIRECTORY_PATH];
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


// Get a file size.
//- (long long)fileSizeAtPath:(NSString*)filePath {
//    NSFileManager *manager = [NSFileManager defaultManager];
//    if ([manager fileExistsAtPath:filePath]) {
//        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
//    }
//    return 0;
//}

//遍历文件夹获得文件夹大小，返回多少M
- (double)directorySizeAtPath:(NSString*)directoryPath{
    NSFileManager *manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:directoryPath]) return 0.0;
    
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:directoryPath] objectEnumerator];
    NSString *fileName;
    long long directorySize = 0.0;
    while ((fileName = [childFilesEnumerator nextObject]) != nil) {
        NSString *fileAbsolutePath = [directoryPath stringByAppendingPathComponent:fileName];
        directorySize += [[manager attributesOfItemAtPath:fileAbsolutePath error:nil] fileSize];
    }
    return directorySize / (1024.0 * 1024.0);
}

@end
