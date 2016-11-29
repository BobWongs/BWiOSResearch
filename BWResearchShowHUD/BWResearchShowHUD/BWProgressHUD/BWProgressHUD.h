//
//  BWProgressHUD.h
//  BWResearchShowHUD
//
//  Created by BobWong on 16/10/28.
//  Copyright © 2016年 BobWongStudio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BWProgressHUD : UIView

/**
 *  样式为描述文+标红文本
 *
 *  @param textDesc      描述文
 *  @param textHighlight 标红文本
 */
+ (void)showDescriptionText:(NSString *)textDesc
              highlightText:(NSString *)textHighlight;

/**
 *  样式仅有描述文
 *
 *  @param textDesc 描述文
 */
+ (void)showDescriptionText:(NSString *)textDesc;

/**
 *  先把之前显示的先进行隐藏，再显示新的
 *
 *  @param textDesc 描述文
 */
+ (void)showDescriptionHideTheShowedHudText:(NSString *)textDesc;

/**
 *  根据文本长度获得显示的时间长度，参考SVProgressHUD
 */
+ (NSTimeInterval)displayDurationForString:(NSString*)string;

@end
