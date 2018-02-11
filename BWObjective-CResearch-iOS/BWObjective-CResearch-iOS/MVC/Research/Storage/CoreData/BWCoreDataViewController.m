//
//  BWCoreDataViewController.m
//  BWObjective-CResearch-iOS
//
//  Created by BobWong on 2018/2/11.
//  Copyright © 2018年 BobWong. All rights reserved.
//

#import "BWCoreDataViewController.h"
#import <CoreData/CoreData.h>

@interface BWCoreDataViewController ()

@property (strong, nonatomic) NSPersistentContainer *persistentContainer;

@end

@implementation BWCoreDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Core Data";
    [self setupData];
}

- (void)setupData {
    self.persistentContainer = [[NSPersistentContainer alloc] initWithName:@"Person"];
    [self.persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription * _Nonnull description, NSError * _Nullable error) {
        if (error != nil) {
            NSLog(@"Failed to load Core Data stack: %@", error);
            return;
        }
        NSLog(@"Load Core Data successfully!");
    }];
}

- (IBAction)saveAction:(id)sender {
}

- (IBAction)readAction:(id)sender {
}

- (IBAction)clearAction:(id)sender {
}

@end
