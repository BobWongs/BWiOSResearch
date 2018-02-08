//
//  NSString+BWAdd.m
//  BWObjective-CResearch-MacOS
//
//  Created by BobWong on 2018/2/6.
//  Copyright © 2018年 BobWong. All rights reserved.
//

#import "NSString+BWAdd.h"

@implementation NSString (BWAdd)

- (BOOL)validAccount {
    return self.length > 3;
}

@end
