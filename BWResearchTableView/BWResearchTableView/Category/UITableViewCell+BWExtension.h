//
//  UITableViewCell+BWExtension.h
//  BWResearchTableView
//
//  Created by BobWong on 16/11/30.
//  Copyright © 2016年 BobWongStudio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableViewCell (BWExtension)

+ (instancetype)bw_cellAllocWithTableView:(UITableView *)tableView;
+ (instancetype)bw_cellXibWithTableView:(UITableView *)tableView;

@end
