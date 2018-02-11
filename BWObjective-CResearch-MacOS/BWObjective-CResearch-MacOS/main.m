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
        
        BWCoreDataStudy *coreDataStudy = [BWCoreDataStudy new];
        [coreDataStudy study];
        
    }
    
    return 0;
}
