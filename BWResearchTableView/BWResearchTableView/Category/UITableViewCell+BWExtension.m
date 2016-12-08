//
//  UITableViewCell+BWExtension.m
//  BWResearchTableView
//
//  Created by BobWong on 16/11/30.
//  Copyright © 2016年 BobWongStudio. All rights reserved.
//

#import "UITableViewCell+BWExtension.h"

@implementation UITableViewCell (BWExtension)

+ (instancetype)bw_cellAllocWithTableView:(UITableView *)tableView {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
    if (!cell) {
        cell = [[[self class] alloc] initWithStyle:0 reuseIdentifier:NSStringFromClass([self class])];
    }
    return cell;
}

+ (instancetype)bw_cellXibWithTableView:(UITableView *)tableView {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] firstObject];
    }
    return cell;
}

@end
