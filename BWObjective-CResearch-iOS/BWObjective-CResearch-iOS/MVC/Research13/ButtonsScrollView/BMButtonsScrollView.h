//
//  BMButtonsScrollView.h
//  BWObjective-CResearch-iOS
//
//  Created by BobWong on 2017/10/20.
//  Copyright © 2017年 BobWong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, BMButtonsScrollViewAlignment) {
    BMButtonsScrollViewAlignmentJustify,  // Default, 按钮分散居中排列，按钮之间的间距 = (父容器宽度 - 所有文本拼在一起的总宽度) / 按钮个数
    BMButtonsScrollViewAlignmentLeft  // 从左按照一定间距往右排
};

@interface BMButtonsScrollView : UIScrollView

@property (assign, nonatomic) BMButtonsScrollViewAlignment alignment;
@property (strong, nonatomic) UIColor *normalColor;
@property (strong, nonatomic) UIColor *selectedColor;
@property (strong, nonatomic) UIFont *font;
@property (assign, nonatomic) CGFloat space;
@property (assign, nonatomic) CGFloat inset;
@property (assign, nonatomic) BOOL showIndicator;
@property (assign, nonatomic) CGFloat indicatorHeight;
@property (strong, nonatomic) UIColor *indicatorColor;

@property (copy, nonatomic) void(^selectedBlock)(NSInteger);

@property (strong, nonatomic) NSArray<NSString *> *titleArray;
@property (assign, nonatomic) NSInteger toSelectIndex;

@end
