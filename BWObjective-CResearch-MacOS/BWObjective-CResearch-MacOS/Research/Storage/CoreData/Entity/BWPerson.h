//
//  BWPerson.h
//  BWObjective-CResearch-MacOS
//
//  Created by BobWong on 2018/2/11.
//  Copyright © 2018年 BobWong. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface BWPerson : NSManagedObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *gender;
@property (assign, nonatomic) int16_t age;

@end
