//
//  BMMoonWashCategoryView.h
//  BWObjective-CResearch-iOS
//
//  Created by BobWong on 2017/10/20.
//  Copyright © 2017年 BobWong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BMMoonWashCategoryView : UIView

@property (strong, nonatomic) NSArray<NSString *> *firstArray;  ///< 一级菜单
@property (strong, nonatomic) NSArray<NSString *> *secondArray;  ///< 二级菜单

@property (copy, nonatomic) void(^firstSelectedAction)(NSInteger firstSelectedIndex);  ///< 一级选中Action
@property (copy, nonatomic) void(^secondSelectedAction)(NSArray<NSNumber *> *selectedArray);  ///< 二级选中Action

@end
