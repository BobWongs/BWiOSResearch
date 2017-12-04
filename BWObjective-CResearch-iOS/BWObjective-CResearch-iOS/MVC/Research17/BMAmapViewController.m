//
//  BMAmapViewController.m
//  BWObjective-CResearch-iOS
//
//  Created by BobWong on 2017/12/4.
//  Copyright © 2017年 BobWong. All rights reserved.
//

#import "BMAmapViewController.h"
#import "BMAmapView.h"

@interface BMAmapViewController ()

@end

@implementation BMAmapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.title = @"门店地图";
    [self setUI];
}

- (void)setUI {
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    BMAmapView *mapView = [[BMAmapView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight - 64)];
    [self.view addSubview:mapView];
    mapView.annotationArray = self.annotationArray;
}

@end
