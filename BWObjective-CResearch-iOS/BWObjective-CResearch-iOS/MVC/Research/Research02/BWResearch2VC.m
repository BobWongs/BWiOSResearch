//
//  BWResearch2VC.m
//  BWObjective-CResearch-iOS
//
//  Created by BobWong on 2017/2/28.
//  Copyright © 2017年 BobWong. All rights reserved.
//

#import "BWResearch2VC.h"
#import <Masonry.h>

@interface BWResearch2VC () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (strong, nonatomic) NSMutableArray *dataSource;  ///< Data source

@end

@implementation BWResearch2VC

#pragma mark - View Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Research2";
    
    [self setData];
    [self setUI];
    [self setConstraints];
    [self loadData];
}

#pragma mark - Public Method

#pragma mark - Action

#pragma mark - Network

#pragma mark - Custom Delegate

#pragma mark - System Delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}



#pragma mark - Private Method

- (void)setData
{
    self.dataSource = [NSMutableArray arrayWithArray:@[@"1", @"2", @"3", @"4", @"5"]];
}

- (void)setUI
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    [self.view addSubview:collectionView];
    
    [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
}

- (void)setConstraints
{
    
}

- (void)loadData
{
    
}

#pragma mark - Getter and Setter

@end
