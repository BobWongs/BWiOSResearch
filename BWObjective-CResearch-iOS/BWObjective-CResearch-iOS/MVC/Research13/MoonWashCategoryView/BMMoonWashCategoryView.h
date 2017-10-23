//
//  BMMoonWashCategoryView.h
//  BWObjective-CResearch-iOS
//
//  Created by BobWong on 2017/10/20.
//  Copyright © 2017年 BobWong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BMMoonWashCategoryView : UIView

@property (strong, nonatomic) NSArray<NSString *> *firstArray;
@property (strong, nonatomic) NSArray<NSString *> *secondArray;

@property (copy, nonatomic) void(^selectedAction)(NSArray<NSNumber *> *selectedArray);  ///< 选中数组

@end
