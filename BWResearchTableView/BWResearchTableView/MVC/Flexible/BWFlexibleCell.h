//
//  BWFlexibleCell.h
//  BWResearchTableView
//
//  Created by BobWong on 16/10/21.
//  Copyright © 2016年 BobWongStudio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BWFlexibleCell : UITableViewCell

@property (nonatomic, strong) UILabel *lbText;
@property (nonatomic, strong) UIButton *btnChange;

@property (nonatomic, copy) dispatch_block_t blockChange;

- (void)setTextLabelUnfold:(BOOL)unfold;

@end
