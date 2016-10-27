//
//  BMScanedResultHUD.h
//  BMBlueMoonAngel
//
//  Created by BobWong on 16/9/22.
//  Copyright © 2016年 elvin. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  扫码弹框视图
 */
@interface BMScanedResultHUD : UIView

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
 *  根据文本长度获得显示的时间长度，参考SVProgressHUD
 */
+ (NSTimeInterval)displayDurationForString:(NSString*)string;

@end
