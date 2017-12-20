//
//  BWClass1.m
//  BWObjective-CResearch-MacOS
//
//  Created by BobWong on 2017/6/9.
//  Copyright © 2017年 BobWong. All rights reserved.
//

#import "BWClass1.h"

//NSString *const BWKey = @"BWKey";

@implementation BWClass1

+ (NSURL *)bm_URLWithString:(NSString *)URLString appendedQueryString:(NSString *)appendedQueryString {
    if (!URLString) return [NSURL new];
    NSURLComponents *components = [NSURLComponents componentsWithString:URLString];
    NSString *query = components.query ? [NSString stringWithFormat:@"%@&%@", components.query, appendedQueryString] : appendedQueryString;
    components.query = query;
    return components.URL;
}

@end
