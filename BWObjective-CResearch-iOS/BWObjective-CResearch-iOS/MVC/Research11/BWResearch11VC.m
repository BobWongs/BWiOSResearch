//
//  BWResearch11VC.m
//  BWObjective-CResearch-iOS
//
//  Created by BobWong on 2017/10/10.
//  Copyright © 2017年 BobWong. All rights reserved.
//

#import "BWResearch11VC.h"
#import "BWResearch11Cell.h"
#import <Masonry.h>

NSString *const BWCellId = @"BWCellId";

@interface BWResearch11VC () <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation BWResearch11VC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor grayColor];
    
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(changeShowTypeAction)];
    self.navigationItem.rightBarButtonItem = item;
    
    
    
    BWResearch11Cell *cell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([BWResearch11Cell class]) owner:nil options:nil].firstObject;
    [self.view addSubview:cell];
    [cell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.width.mas_equalTo(200);
        make.top.mas_equalTo(100);
        make.height.mas_equalTo(100);
    }];
}

BOOL showType = YES;

- (void)changeShowTypeAction {
    showType = !showType;
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
//    layout.minimumLineSpacing = 4;
//    layout.minimumInteritemSpacing = 4;
//    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    CGFloat sw = [UIScreen mainScreen].bounds.size.width;
    
    
    if (showType) {
        layout.itemSize = CGSizeMake(200, 100);
    } else {
        layout.itemSize = CGSizeMake(sw, 50);
    }
    
    self.collectionView.collectionViewLayout = layout;
    [self.collectionView reloadData];  // 调用reload已运用对应的Cell
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 3;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 20;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    BWResearch11Cell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:BWCellId forIndexPath:indexPath];
//    BWResearch11Cell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:BWCellId forIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    
    static int num = 0;
    NSString *text = @"text";
    for (NSInteger index = 0; index < num; index++) {
        text = [text stringByAppendingString:@"\nText"];
    }
    cell.label.text = text;
    num += 1;
    if (num == 4) {
        num = 0;
    }
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(50, 135);
}

//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
//    CGFloat sw = [UIScreen mainScreen].bounds.size.width;
//    CGFloat width = (sw - 10 * 3) / 2;
//    return CGSizeMake(width, 80);
//}

//- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
//    return UIEdgeInsetsMake(5, 5, 5, 5);
//}

//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
//    return 20;
//}

//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
//    return 10;
//}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 4;
        layout.minimumInteritemSpacing = 4;
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
//        layout.headerReferenceSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 100);
        layout.headerReferenceSize = CGSizeMake(kScreenWidth, 100);
        
        CGFloat sw = [UIScreen mainScreen].bounds.size.width;
//        layout.itemSize = CGSizeMake((sw - 4)/2.0, (sw - 4)/2.0 + 111);
//        layout.estimatedItemSize = CGSizeMake((sw - 4)/2.0, (sw - 4)/2.0 + 111);  // Dynamic height
        layout.estimatedItemSize = CGSizeMake(45, 100);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.delegate   = self;
        _collectionView.dataSource = self;
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([BWResearch11Cell class]) bundle:nil] forCellWithReuseIdentifier:BWCellId];
        
        _collectionView.backgroundColor = [UIColor whiteColor];
    }
    return _collectionView;
}

@end
