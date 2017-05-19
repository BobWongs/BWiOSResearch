//
//  UITableView+BWExtension.m
//  BWResearchTableView
//
//  Created by BobWong on 2017/2/27.
//  Copyright © 2017年 BobWongStudio. All rights reserved.
//

#import "UITableView+BWExtension.h"

@implementation UITableView (BWExtension)

- (void)bw_registerNibCellClass:(Class)cellClass forCellReuseIdentifier:(NSString *)identifier {
    
    [self registerNib:[UINib nibWithNibName:NSStringFromClass([cellClass class]) bundle:nil] forCellReuseIdentifier:identifier];
}

- (void)bw_registerNibHeaderFooterViewClass:(Class)nibHeaderFooterViewClass forHeaderFooterViewReuseIdentifier:(NSString *)identifier {
    
    [self registerNib:[UINib nibWithNibName:NSStringFromClass([nibHeaderFooterViewClass class]) bundle:nil] forHeaderFooterViewReuseIdentifier:identifier];
}

@end
