//
//  BWLayoutXibCell.h
//  BWResearchTableView
//
//  Created by BobWong on 16/11/29.
//  Copyright © 2016年 BobWongStudio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BWLayoutXibCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lbOrder;
@property (weak, nonatomic) IBOutlet UIButton *btnDetail;
@property (weak, nonatomic) IBOutlet UILabel *lbName;
@property (weak, nonatomic) IBOutlet UILabel *lbAddress;
@property (weak, nonatomic) IBOutlet UIButton *btnPhone;
@property (weak, nonatomic) IBOutlet UILabel *lbSumMoney;
@property (weak, nonatomic) IBOutlet UILabel *lbTargetAmount;
@property (weak, nonatomic) IBOutlet UILabel *lbRealAmount;

@end
