//
//  BWCoreDataStudy.m
//  BWObjective-CResearch-MacOS
//
//  Created by BobWong on 2018/2/11.
//  Copyright © 2018年 BobWong. All rights reserved.
//

#import "BWCoreDataStudy.h"
#import <CoreData/CoreData.h>
#import "BWPerson.h"

@interface BWCoreDataStudy ()

@property (strong, nonatomic) NSPersistentContainer *persistentContainer;
@property (strong, nonatomic) NSManagedObjectContext *context;

@end

@implementation BWCoreDataStudy

//- (id)init
//{
//    self = [super init];
//    if (!self) return nil;
//    return self;
//}

- (void)study {
    [self setupData];
}

- (void)setupData {
//    self.persistentContainer = [[NSPersistentContainer alloc] initWithName:@"Person"];
//    [self.persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription * _Nonnull description, NSError * _Nullable error) {
//        if (error != nil) {
//            NSLog(@"Failed to load Core Data stack: %@", error);
//            abort();
//        }
//        NSLog(@"Load Core Data successfully!");
//    }];
    
    // 创建上下文对象，并发队列设置为主队列
    NSManagedObjectContext *context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    self.context = context;
    
    // 创建托管对象模型，并使用Company.momd路径当做初始化参数
    NSURL *modelPath = [[NSBundle mainBundle] URLForResource:@"Person" withExtension:@"momd"];
    NSManagedObjectModel *model = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelPath];
    
    // 创建持久化存储调度器
    NSPersistentStoreCoordinator *coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
    
    // 创建并关联SQLite数据库文件，如果已经存在则不会重复创建
    NSString *dataPath = NSSearchPathForDirectoriesInDomains(NSDesktopDirectory, NSUserDomainMask, YES).lastObject;
    NSLog(@"dataPath: %@", dataPath);
    dataPath = [dataPath stringByAppendingFormat:@"/CoreData/%@.sqlite", @"Person"];
    [coordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:[NSURL fileURLWithPath:dataPath] options:nil error:nil];
    
    // 上下文对象设置属性为持久化存储器
    context.persistentStoreCoordinator = coordinator;
}

- (void)insert {
    BWPerson *person = [NSEntityDescription insertNewObjectForEntityForName:@"Person" inManagedObjectContext:self.context];
    person.name = @"Bob";
    person.gender = @"male";
    person.age = 24;
    
    NSError *error = nil;
    if (self.context.hasChanges) {
        [self.context save:&error];
    }
    
    if (error) {
        NSLog(@"core data insert error: %@", error);
        return;
    }
    
    NSLog(@"Core data insert successfully!");
}

- (void)fetch {
    // 建立获取数据的请求对象，指明操作的实体为Employee
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Person"];
    
    // 执行获取操作，获取所有Employee托管对象
    NSError *error = nil;
    NSArray<BWPerson *> *persons = [self.context executeFetchRequest:request error:&error];
    [persons enumerateObjectsUsingBlock:^(BWPerson * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"");
        NSLog(@"Person Name : %@, Gender : %@, Age : %hd", obj.name, obj.gender, obj.age);
        NSLog(@"ObjectId: %@", obj.objectID);
        NSLog(@"");
    }];
    
    // 错误处理
    if (error) {
        NSLog(@"CoreData Ergodic Data Error : %@", error);
    }
}

- (void)remove {
    
}

- (void)modify {
    
}

@end
