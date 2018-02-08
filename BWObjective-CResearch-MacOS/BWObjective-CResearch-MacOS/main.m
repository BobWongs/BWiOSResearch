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

#define BMFloatEquation(A, B) (ABS(A-B)<=0.00001)

// Function declaration
void stringType();
void objectType();
void test0();
void test1();
void test2();
void test3();
void test4();
void test5();
void test6();
void test7();
void test8();

typedef NS_ENUM(NSInteger, BWType) {
    BWType0,
    BWType1,
    BWType2
};

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        NSString *text = @"text";
        NSString *text1;
        
        NSLog(@"text %d", [text validAccount]);
        NSLog(@"text1 %d", [text1 validAccount]);
    }
    
    return 0;
}

// Test
void test15() {
    BWCommonType type;
    type = BWCommonTypeThird;
    NSLog(@"type: %ld", (long)type);
}

void test14() {
//    NSString *path = @"https://www.baidu.com?key0=value0&key1=value1";
    NSString *path = @"https://www.baidu.com";
    NSURL *url = [BWClass1 bm_URLWithString:path appendedQueryString:@"key2=value2&key3=value3"];
    NSLog(@"URL: %@", url);
    
    NSString *host = url.host;
    NSLog(@"host: %@", host);
}

void test13() {
//    NSString *path = @"https://www.baidu.com?key0=value0&key1=value1";
    NSString *path = @"https://www.baidu.com";
    NSURLComponents *components = [NSURLComponents componentsWithString:path];
    NSLog(@"url string: %@", components.URL);
    
    NSString *query = components.query;
    NSLog(@"query: %@", query);
    NSLog(@"queryItems: %@", components.queryItems);
    
    NSString *addedQuery = @"key2=value2&key3=value3";
    query = [NSString stringWithFormat:@"%@&%@", query, addedQuery];
    components.query = query;
    NSLog(@"new query: %@", components.query);
    NSLog(@"url: %@", components.URL);
    
    [NSURL URLWithString:@""];
}

void test12() {
    BWType type = BWType1;
    switch (type) {
        case BWType0: {
            NSLog(@"BWType0");
        }
            break;
        case BWType1:
        case BWType2: {
            NSLog(@"BWType2");
        }
            break;
    }
}

void test11() {
    //        NSDictionary *dict = @{@(1): @"first",
    //                               @(2): @"second",
    //                               @(3): @"third",
    //                               @(1): @"forth"};
    //        NSLog(@"dict is %@", dict);
    //
    //        NSMutableDictionary *dictM = [dict mutableCopy];
    //        dictM[@(1)] = @"fifth";
    //        NSLog(@"dictM is %@", dictM);
    //
    //        id object = dictM[@(100)];
    //        NSLog(@"object: %@", object);
    
    //        NSArray *array = @[@"first"];
    //        id object = array[0];
    //        object = @"second";
    //        NSLog(@"object: %@", object);
    //        NSLog(@"array: %@", array);
    
    //        BOOL has;
    //        NSLog(@"%d", has);
    
    NSString *str = @"123";
    NSLog(@"%@", [str substringToIndex:1]);
}

void test10() {
    double yuan = 1990 / 100.0;
    NSLog(@"yuan: %f", yuan);
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.roundingMode = NSNumberFormatterRoundDown;  // 19.9 -> 19, -19.9 -> 19, round towards to zero.
    [formatter setPositiveFormat:@",##0;"];
    NSString *string = [formatter stringFromNumber:[NSNumber numberWithDouble:yuan]];
    NSLog(@"str: %@", string);
}

void test9() {
    //        NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:10];
    ////        NSMutableArray *arrayM = [NSMutableArray new];
    //        arrayM[2] = @"30";
    //        NSLog(@"ArrayM: %@", arrayM);
    
    NSDictionary *dict = @{};
    NSString *param0 = dict[@"key0"];
    NSLog(@"%@", param0);
}

void test0() {
    stringType();
    objectType();

    if ([@"HTTPS://" localizedCaseInsensitiveContainsString:@"http"]) {
        NSLog(@"contain");
    } else {
        NSLog(@"not contain");
    }
}

void test1() {
    NSString *str0 = @"str0";
    NSMutableString *mutableStr0 = [NSMutableString stringWithString:str0];
    NSString *str1 = mutableStr0;
    NSString *str2 = [mutableStr0 copy];
    [mutableStr0 appendString:@"append str0"];
    NSLog(@"str1 is %@", str1);
    NSLog(@"str2 is %@", str2);
}

void test2() {
    NSString *arrayClassString = NSStringFromClass([NSArray class]);
    NSLog(@"arrayClassString is %@", arrayClassString);
    
    //        id maybeArray = @[@"123", @"231", @"312"];
    id maybeArray = [NSArray arrayWithObjects:@"1", @"2", nil];
    if ([maybeArray class] == [NSArray class]) {
        NSLog(@"equal");
    } else {
        NSLog(@"not equal");
    }
    
    NSString *maybeArrayClassString = NSStringFromClass([maybeArray class]);
    NSLog(@"maybeArrayClassString is %@", maybeArrayClassString);
}

void test3() {
    BWClass *object = [BWClass new];
//    [object performSelector:NSSelectorFromString(@"no_finded_method")];
//    [object doSomething];
//    [object performSelector:@selector(objectAtIndex:)];
//    id firstObject = [object performSelector:@selector(firstObject)];
    id firstObject = [object performSelector:@selector(arrayWithObject:)];
    NSLog(@"first object is %@", firstObject);
}

void test4() {
    NSObject *object = [NSObject new];
    [[object class] isSubclassOfClass:[NSObject class]];
    [object isKindOfClass:[NSObject class]];
    [object isMemberOfClass:[NSObject class]];
}

void test5() {
    NSCache *cache = [NSCache new];
    //        cache.totalCostLimit = 5 * 1024 * 1024; // 5MB
    //        cache.countLimit = 100;
    
    NSString *key = @"name";
    
    [cache setObject:@"bob" forKey:key];
    
    NSCache *cache2 = [NSCache new];
    NSString *name = [cache objectForKey:key];
    NSLog(@"name: %@", name);
}

void test6() {
    NSString *str0 = @"str0";
    
    NSArray *array = @[@"1", @"2", @"3", str0];
    NSLog(@"array: %@", array);
    
    str0 = @"new str0";
    NSLog(@"array: %@", array);
}

void test7() {
    NSMutableArray<NSNumber *> *array = [NSMutableArray arrayWithArray:@[@(11), @(243), @(3), @(323), @(2)]];
    NSLog(@"original array is %@", array);
    
    // 从大到小，对可变数组进行排序，没有返回值
    [array sortUsingComparator:^NSComparisonResult(NSNumber *  _Nonnull obj1, NSNumber *  _Nonnull obj2) {
        return (obj1.integerValue > obj2.integerValue) ? NSOrderedAscending : NSOrderedDescending;
    }];
    NSLog(@"original sorted array is %@", array);
    
    // 从小到大，对数组进行排序，返回排序后的数组
    NSArray *sortedArray = [array sortedArrayUsingComparator:^NSComparisonResult(NSNumber *  _Nonnull obj1, NSNumber *  _Nonnull obj2) {
        return (obj1.integerValue < obj2.integerValue) ? NSOrderedAscending : NSOrderedDescending;
    }];
    NSLog(@"array is %@", sortedArray);
}

void test8() {
    float a = 100.0;
    float b = 101.0;
    NSLog(@"a: %f, b: %f", a, b);
    
    if (BMFloatEquation(a, b)) {
        NSLog(@"=");
    } else {
        NSLog(@"!=");
    }
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
