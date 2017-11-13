//
//  BMCardCycleView.h
//  BWObjective-CResearch-iOS
//
//  Created by BobWong on 2017/10/18.
//  Copyright © 2017年 BobWong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BMCardCycleView : UIView

@property (strong, nonatomic) UIImage *placeholderImage;

@property (strong, nonatomic) NSArray<NSString *> *imageURLStringArray;  ///< 图片路径数据
@property (copy, nonatomic) void(^selectedAction)(NSInteger);

@end
