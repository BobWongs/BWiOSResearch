//
//  BWResearch6VC.m
//  BWObjective-CResearch-iOS
//
//  Created by BobWong on 2017/6/14.
//  Copyright © 2017年 BobWong. All rights reserved.
//

#import "BWResearch6VC.h"
#import "BMNewAddressPicker.h"

@interface BWResearch6VC ()

@property (weak, nonatomic) IBOutlet UIButton *addressButton;
@property (strong, nonatomic) BMNewAddressPicker *addressPicker;  ///< Address Picker

@end

@implementation BWResearch6VC

- (void)viewDidLoad {
    [super viewDidLoad];

    
}

- (IBAction)select:(id)sender {
    [self.addressPicker show];
}

- (BMNewAddressPicker *)addressPicker {
    if (!_addressPicker) {
        _addressPicker = [BMNewAddressPicker new];
        
        __weak typeof(self) weakSelf = self;
        _addressPicker.didSelectBlock = ^(NSArray<BMNewRegionModel *> *selectedModelArray) {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            
            NSMutableString *addressStr = [NSMutableString new];
            [selectedModelArray enumerateObjectsUsingBlock:^(BMNewRegionModel * _Nonnull model, NSUInteger idx, BOOL * _Nonnull stop) {
                [addressStr appendString:model.name];
            }];
            
            [strongSelf.addressButton setTitle:addressStr forState:UIControlStateNormal];
        };
    }
    return _addressPicker;
}

@end
