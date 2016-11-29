//
//  BWSortByPinyinVC.m
//  BWResearchTableView
//
//  Created by BobWong on 16/10/24.
//  Copyright © 2016年 BobWongStudio. All rights reserved.
//

#import "BWSortByPinyinVC.h"

#define kName @"name"
#define kFirstChar @"first_char"
#define kValue @"value"

#define weakRef(object) __weak typeof(object) weak##object = object
#define strongRef(object)  __strong typeof(object) strong##object = object

@interface BWSortByPinyinVC () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSArray *dataSource;  ///< 原数据
@property (nonatomic, strong) NSMutableDictionary *dictSorted;  ///< 排序后的Dictionary数据
@property (nonatomic, strong) NSMutableArray *arraySorted;  ///< 排序后的Array数据源，TableView的数据源
@property (nonatomic, strong) NSMutableArray *arrayFirstChar;  ///< 首字母Array

@end

@implementation BWSortByPinyinVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Home";
    _dataSource = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"pinyin_source" ofType:@"plist"]];
    
    [self setSortedData];
    
//    NSLog(@"sorted array: %@", _arraySorted);
//    NSLog(@"sorted dict: %@", _dictSorted);
//    NSLog(@"pinyin: %@, first character: %@", [[self class] bw_pinyinFromString:@"王"], [[self class] bw_firstPinyinUpperCaseCharacterFromString:@"王"]);
    
    [self setUI];
}

// 设置排序数据
- (void)setSortedData {
    _dictSorted = [NSMutableDictionary dictionary];
    _arraySorted = [NSMutableArray array];
    _arrayFirstChar = [NSMutableArray array];
    
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
    
    // 对dictSorted的values进行按顺序添加到arraySorted上
    for (NSString *key in _dictSorted.allKeys) {
        NSArray *array = _dictSorted[key];
        
        // 没有则直接添加
        if (_arraySorted.count == 0) {
            [_arraySorted addObject:[self dictionaryAddToSortedWithFirstChar:key value:array]];
            continue ;
        }
        
        BOOL isAdded = NO;  // 是否已经添加
        // 插入排序
        for (NSInteger index = 0; index < _arraySorted.count; index++) {
            NSDictionary *dictInIndex = _arraySorted[index];
            NSString *firstChar = dictInIndex[kFirstChar];
            
            if ([key compare:firstChar] == NSOrderedAscending) {
                [_arraySorted insertObject:[self dictionaryAddToSortedWithFirstChar:key value:array] atIndex:index];
                isAdded = YES;
                break;
            }
        }
        
        if (isAdded) {
            continue ;
        }
        
        [_arraySorted addObject:[self dictionaryAddToSortedWithFirstChar:key value:array]];  // 添加到最末尾
    }
    
    
    // 首字母数组的生成
    for (NSInteger index = 0; index < _arraySorted.count; index++) {
        NSDictionary *dict = _arraySorted[index];
        [_arrayFirstChar addObject:dict[kFirstChar]];
    }
}

- (NSDictionary *)dictionaryAddToSortedWithFirstChar:(id)firstChar value:(id)array {
    NSDictionary *dictToAdd = @{
                                kFirstChar: firstChar,
                                kValue: array
                                };
    return dictToAdd;
}

- (void)setUI
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.sectionIndexColor = [UIColor orangeColor];  // 索引Title的颜色
    tableView.sectionIndexBackgroundColor = [UIColor clearColor];  // 索引时候的背景色
    tableView.sectionIndexTrackingBackgroundColor = [UIColor clearColor];  // 未索引时候的背景色
    [self.view addSubview:tableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _arraySorted.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_arraySorted[section][kValue] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    NSInteger section = indexPath.section, row = indexPath.row;
    NSArray *array = _arraySorted[section][kValue];
    cell.textLabel.text = array[row][kName];
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return _arraySorted[section][kFirstChar];
}

- (nullable NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return _arrayFirstChar;
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
//    for (NSString *string in _arrayFirstChar) {
//        if ([string isEqualToString:title]) {
//            return [_arrayFirstChar indexOfObject:string];
//        }
//    }
//    return 0;
    
    return index;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
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
