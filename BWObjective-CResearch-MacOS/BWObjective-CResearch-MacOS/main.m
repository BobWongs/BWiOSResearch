//
//  main.m
//  BWObjective-CResearch-MacOS
//
//  Created by BobWong on 16/8/5.
//  Copyright © 2016年 BobWong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BWClass.h"
#import "BWClass1.h"
#import "BWCommon.h"
#import "NSString+BWAdd.h"
#import "BWNetwork0.h"
#import "BWCoreDataStudy.h"

#define BMFloatEquation(A, B) (ABS(A-B)<=0.00001)

typedef NS_ENUM(NSInteger, BWType) {
    BWType0,
    BWType1,
    BWType2
};

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
//        BWCoreDataStudy *coreDataStudy = [BWCoreDataStudy new];
//        [coreDataStudy study];
        
        NSDictionary *dict0 = @{@"key0": @"value0"};
        NSDictionary *dict1 = @{@"key1": @"value1"};
        
        NSMutableDictionary *dictM0 = [NSMutableDictionary dictionaryWithDictionary:dict0];
        NSMutableDictionary *dictM1 = [NSMutableDictionary dictionaryWithDictionary:dict1];
        
        NSArray *array = @[dictM0, dictM1];
        NSLog(@"array: %@", array);
        
        dictM0[@"key01"] = @"value01";
        
        NSLog(@"array: %@", array);
        
    }
    
    return 0;
}
