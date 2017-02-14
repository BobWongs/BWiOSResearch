//
//  main.m
//  BWObjective-CResearch-MacOS
//
//  Created by BobWong on 16/8/5.
//  Copyright © 2016年 BobWong. All rights reserved.
//

#import <Foundation/Foundation.h>

// Function declaration
void stringType();
void objectType();

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
//        stringType();
//        objectType();
        
        if ([@"HTTPS://" localizedCaseInsensitiveContainsString:@"http"]) {
            NSLog(@"contain");
        } else {
            NSLog(@"not contain");
        }
        
    }
    return 0;
}

// Function definition
void stringType() {
    NSString *str0 = @"123";
    NSString *str1 = @"123";
    
    NSLog(@"str0 pointer is %p, str1 pointer is %p", str0, str1);
    
    NSArray *array = @[str0];
    if ([array containsObject:@"123"]) {
        NSLog(@"contain");
    } else {
        NSLog(@"not contain");
    }
}

void objectType() {
    NSString *str0 = @"123";
    NSString *str1 = @"123";
    
    NSArray *array0 = @[str0, str1];
    NSArray *array1 = @[str0, str1];
    
    NSLog(@"array0 pointer is %p, array1 pointer is %p", array0, array1);
    
    if ([array0 containsObject:@"123"]) {
        NSLog(@"contain");
    } else {
        NSLog(@"not contain");
    }
}
