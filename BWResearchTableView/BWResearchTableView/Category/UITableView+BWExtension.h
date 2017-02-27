//
//  UITableView+BWExtension.h
//  BWResearchTableView
//
//  Created by BobWong on 2017/2/27.
//  Copyright © 2017年 BobWongStudio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (BWExtension)

- (void)bw_registerNibCellClass:(Class)cellClass forCellReuseIdentifier:(NSString *)identifier;

- (void)bw_registerNibHeaderFooterViewClass:(Class)nibHeaderFooterViewClass forHeaderFooterViewReuseIdentifier:(NSString *)identifier;

@end
