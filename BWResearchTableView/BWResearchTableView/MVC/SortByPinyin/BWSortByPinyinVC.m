//
//  BWSortByPinyinVC.m
//  BWResearchTableView
//
//  Created by BobWong on 16/10/24.
//  Copyright © 2016年 BobWongStudio. All rights reserved.
//

#import "BWSortByPinyinVC.h"

#define kName @"name"

@interface BWSortByPinyinVC () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSArray *dataSource;  ///< 原数据
@property (nonatomic, strong) NSMutableDictionary *dictSorted;  ///< 排序后的Dictionary数据
@property (nonatomic, strong) NSMutableArray *arraySorted;  ///< 排序后的Array数据源，TableView的数据源

@end

@implementation BWSortByPinyinVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Home";
    _dataSource = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"pinyin_source" ofType:@"plist"]];
    
    _dictSorted = [NSMutableDictionary dictionary];
    _arraySorted = [NSMutableArray array];
    
    for (NSDictionary *dict in _dataSource) {
        NSString *name = dict[kName];
        NSString *firstUpperChar = [[self class] bw_firstPinyinUpperCaseCharacterFromString:name];
        
        NSArray *arrayChar = [_dictSorted allKeys];  // 已有的拼音首字母Array
        BOOL isExistChar = NO;
        for (NSString *addedChar in arrayChar) {
            if ([addedChar isEqualToString:firstUpperChar]) {
                // 已有则直接添加
                isExistChar = YES;
                
                NSMutableArray *arrayMutable = _dictSorted[addedChar];
                [arrayMutable addObject:dict];
                
                break ;
            }
        }
        
        if (!isExistChar) {
            // 没有则创建新的键值对，并且添加到数据Value上
            NSMutableArray *arrayMutableNew = [NSMutableArray array];
            [arrayMutableNew addObject:dict];
            _dictSorted[firstUpperChar] = arrayMutableNew;
        }
    }
    
    NSLog(@"sorted dict: %@", _dictSorted);
    
    NSLog(@"pinyin: %@, first character: %@", [[self class] bw_pinyinFromString:@"王"], [[self class] bw_firstPinyinUpperCaseCharacterFromString:@"王"]);
    
    [self setUI];
}

- (void)setUI
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _arraySorted.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSource ? _dataSource.count : 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.textLabel.text = _dataSource[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    NSString *strClass = _dataSource[indexPath.row];
    Class class = NSClassFromString(strClass);
    UIViewController *vc = [[class alloc] init];
    vc.title = strClass;
    [self.navigationController pushViewController:vc animated:YES];
}

+ (NSString *)bw_pinyinFromString:(NSString *)string {
    NSMutableString *stringMutable = [[NSMutableString alloc] initWithString:string];
    
    if (!CFStringTransform((__bridge CFMutableStringRef)stringMutable, NULL, kCFStringTransformMandarinLatin, NO)) return @"";
    if (!CFStringTransform((__bridge CFMutableStringRef)stringMutable, NULL, kCFStringTransformStripDiacritics, NO)) return @"";
    
    return stringMutable;
}

+ (NSString *)bw_firstPinyinCharacterFromString:(NSString *)string {
    if (!string) {
        return @"";
    }
    
    NSMutableString *stringMutable = [[NSMutableString alloc] initWithString:string];
    
    if (!CFStringTransform((__bridge CFMutableStringRef)stringMutable, NULL, kCFStringTransformMandarinLatin, NO)) return @"";
    if (!CFStringTransform((__bridge CFMutableStringRef)stringMutable, NULL, kCFStringTransformStripDiacritics, NO)) return @"";
    
    return stringMutable.length > 0 ? [stringMutable substringToIndex:1] : @"";
}

+ (NSString *)bw_firstPinyinLowerCaseCharacterFromString:(NSString *)string {
    if (!string) {
        return @"";
    }
    
    NSMutableString *stringMutable = [[NSMutableString alloc] initWithString:string];
    
    if (!CFStringTransform((__bridge CFMutableStringRef)stringMutable, NULL, kCFStringTransformMandarinLatin, NO)) return @"";
    if (!CFStringTransform((__bridge CFMutableStringRef)stringMutable, NULL, kCFStringTransformStripDiacritics, NO)) return @"";
    
    return stringMutable.length > 0 ? [[stringMutable substringToIndex:1] lowercaseString] : @"";
}

+ (NSString *)bw_firstPinyinUpperCaseCharacterFromString:(NSString *)string {
    if (!string) {
        return @"";
    }
    
    NSMutableString *stringMutable = [[NSMutableString alloc] initWithString:string];
    
    if (!CFStringTransform((__bridge CFMutableStringRef)stringMutable, NULL, kCFStringTransformMandarinLatin, NO)) return @"";
    if (!CFStringTransform((__bridge CFMutableStringRef)stringMutable, NULL, kCFStringTransformStripDiacritics, NO)) return @"";
    
    return stringMutable.length > 0 ? [[stringMutable substringToIndex:1] uppercaseString] : @"";
}

@end
