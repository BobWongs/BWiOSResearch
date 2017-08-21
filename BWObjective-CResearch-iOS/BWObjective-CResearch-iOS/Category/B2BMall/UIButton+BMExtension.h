//
//  UIButton+BMExtension.h
//  BWObjective-CResearch-iOS
//
//  Created by BobWong on 2017/8/21.
//  Copyright © 2017年 BobWong. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 * 按钮类型定义，细分到按钮分类的子类，减少使用部分对按钮样式设置的重复性代码
 */
typedef NS_ENUM(NSInteger, BMb2bButtonType) {
    BMb2bButtonType_btn1_1 = 1,
    BMb2bButtonType_btn1_2,
    BMb2bButtonType_btn2_1,
    BMb2bButtonType_btn2_2,
    BMb2bButtonType_btn3_1,
    BMb2bButtonType_btn3_2,
    BMb2bButtonType_btn3_3,
    BMb2bButtonType_btn3_4
};

@interface UIButton (BMExtension)

+ (UIButton *)bm_buttonWithType:(BMb2bButtonType)type;

@end
