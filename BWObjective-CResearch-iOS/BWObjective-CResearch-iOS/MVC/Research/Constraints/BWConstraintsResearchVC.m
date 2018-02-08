//
//  BWConstraintsResearchVC.m
//  BWObjective-CResearch-iOS
//
//  Created by BobWong on 2018/1/3.
//  Copyright © 2018年 BobWong. All rights reserved.
//

#import "BWConstraintsResearchVC.h"
#import <Masonry.h>
#import <MJExtension.h>
#import <YYCache.h>

@interface BWTestModel : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *title;

@end

@implementation BWTestModel

@end

@interface BWConstraintsResearchVC ()

@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation BWConstraintsResearchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self test5];
}

- (void)test5 {
    
}

NSString *const myKey0 = @"myKey0";
- (IBAction)saveAction:(id)sender {
    NSTimeInterval interval = [NSDate timeIntervalSinceReferenceDate];
    [[NSUserDefaults standardUserDefaults] setObject:@(interval) forKey:myKey0];
}

- (IBAction)showAction:(id)sender {
    
}

- (IBAction)clearAction:(id)sender {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:myKey0];
}

- (void)test4 {
    NSString *pathSandbox = NSHomeDirectory();
    NSLog(@"path sandbox: %@", pathSandbox);
}

- (void)test3 {
    NSDictionary *dict0 = @{@"first": @"one",
                           @"second": @"two",
                           @"third": @"three"};
    NSString *dict0JSONString = [dict0 mj_JSONString];
    NSLog(@"dict0 json string: %@", dict0JSONString);
    
    BWTestModel *testModel = [BWTestModel new];
    testModel.name = @"name";
    testModel.title = @"title";
    
    NSArray<BWTestModel *> *array = @[testModel];
    NSArray *newArray = [BWTestModel mj_keyValuesArrayWithObjectArray:array];
    NSString *dict1JSONString = [newArray mj_JSONString];
    NSLog(@"dict1 json string: %@", dict1JSONString);
    
    NSLog(@"model json string: %@", [testModel mj_JSONString]);
}

- (void)test2 {
//    self.textView.contentInset =
}

- (void)test1 {
    [NSTimer scheduledTimerWithTimeInterval:1.0 block:^(NSTimer * _Nonnull timer) {
        static NSInteger num = 0;
        NSLog(@"num: %@", @(num).stringValue);
        num += 1;
    } repeats:YES];
}

- (void)test0 {
    UIView *containerView = [[UIView alloc] init];
    containerView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:containerView];
    
    //    [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.left.mas_equalTo(20);
    //        make.width.mas_equalTo(200);
    //        make.top.mas_equalTo(100);
    //        make.height.mas_equalTo(200);
    //    }];
    
    CGFloat space = 20;
    self.view.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:containerView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:space]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:containerView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:space]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:containerView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:space]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:containerView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:space]];
}


@end
