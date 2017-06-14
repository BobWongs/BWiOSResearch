//
//  main.m
//  BWObjective-CResearch-MacOS
//
//  Created by BobWong on 16/8/5.
//  Copyright © 2016年 BobWong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BWClass.h"

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

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        
        
    }
    return 0;
}

// Test
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
