//
//  BWResearch6VC.m
//  BWObjective-CResearch-iOS
//
//  Created by BobWong on 2017/6/14.
//  Copyright © 2017年 BobWong. All rights reserved.
//

#import "BWResearch6VC.h"
#import "BMNewAddressPicker.h"
#import <AFNetworkReachabilityManager.h>
#import <UIDevice+YYAdd.h>

#include <ifaddrs.h>
#include <arpa/inet.h>

@interface BWResearch6VC ()

@property (weak, nonatomic) IBOutlet UIButton *addressButton;
@property (weak, nonatomic) IBOutlet UIButton *addressButtonSecond;


@property (strong, nonatomic) BMNewAddressPicker *addressPicker;  ///< Address Picker
@property (strong, nonatomic) BMNewAddressPicker *addressPickerSecond;  ///< Address Picker

@end

@implementation BWResearch6VC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的收益";
    
    [self setNavigationBar];

    _addressPickerSecond = self.addressPickerSecond;
    
    
//    [self networkOriginalStatus];
}

+ (NSString *)getIPAddressSecond {
    
    NSString *address = @"error";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0) {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while(temp_addr != NULL) {
            if(temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                    
                }
                
            }
            
            temp_addr = temp_addr->ifa_next;
        }
    }
    // Free memory
    freeifaddrs(interfaces);
    return address;
    
}

- (void)printwithcode:(NSString *)code name:(NSString *)name {
    NSLog(@"code: %@, name: %@", code, name);
}

- (void)networkOriginalStatus {
    NSLog(@"is wifi: %d", [AFNetworkReachabilityManager sharedManager].isReachableViaWiFi);
    NSLog(@"is wwan: %d", [AFNetworkReachabilityManager sharedManager].isReachableViaWWAN);
    NSLog(@"status: %d", (int)[AFNetworkReachabilityManager sharedManager].networkReachabilityStatus);
}

- (void)networkReachablity {
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager startMonitoring];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        NSLog(@"status: %d", (int)[AFNetworkReachabilityManager sharedManager].networkReachabilityStatus);
        [[AFNetworkReachabilityManager sharedManager] stopMonitoring];
    }];
}

- (void)getIPAddress {
    NSLog(@"%@", [[self class] currentDeviceIPAddress]);
    
    NSLog(@"Second: %@", [[self class] getIPAddressSecond]);
}

+ (NSString *)currentDeviceIPAddress {
    NSString *ipAddress = @"";
    NSString *cellIPAddress = [UIDevice currentDevice].ipAddressCell;
    if (cellIPAddress && cellIPAddress.length > 5) {
        ipAddress = cellIPAddress;
    } else {
        NSString *wifiIPAddress = [UIDevice currentDevice].ipAddressWIFI;
        if (wifiIPAddress && wifiIPAddress.length > 5) {
            ipAddress = wifiIPAddress;
        }
    }
    return ipAddress;
}

- (void)setNavigationBar
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(0, 0, 50, 21);
    button.backgroundColor = [UIColor orangeColor];
    [button setTitle:@"我的收益" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(getIPAddress) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = item;
}

- (IBAction)tap:(id)sender {
    NSLog(@"Tap");
    
}

- (IBAction)select:(id)sender {
    [self.addressPicker show];
}

- (IBAction)selectSecond:(id)sender {
    [self.addressPickerSecond show];
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

- (BMNewAddressPicker *)addressPickerSecond {
    if (!_addressPickerSecond) {
        _addressPickerSecond = [BMNewAddressPicker new];
        
        __weak typeof(self) weakSelf = self;
        _addressPickerSecond.didSelectBlock = ^(NSArray<BMNewRegionModel *> *selectedModelArray) {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            
            NSMutableString *addressStr = [NSMutableString new];
            [selectedModelArray enumerateObjectsUsingBlock:^(BMNewRegionModel * _Nonnull model, NSUInteger idx, BOOL * _Nonnull stop) {
                [addressStr appendString:model.name];
            }];
            
            [strongSelf.addressButtonSecond setTitle:addressStr forState:UIControlStateNormal];
        };
        
        BMNewRegionModel *provinceModel = [BMNewRegionModel new];
        provinceModel.code = 44;
        provinceModel.type = @"province";
        provinceModel.name = @"广东";
        
        BMNewRegionModel *cityModel = [BMNewRegionModel new];
        cityModel.code = 4401;
        cityModel.type = @"city";
        cityModel.name = @"广州";
        
        BMNewRegionModel *countyModel = [BMNewRegionModel new];
        countyModel.code = 440106;
        countyModel.type = @"county";
        countyModel.name = @"天河区";
        
        [_addressPickerSecond setAddressWithSelectedAddressArray:@[provinceModel, cityModel, countyModel]];
        
        NSString *secondTitle = [NSString stringWithFormat:@"%@%@%@", provinceModel.name, cityModel.name, countyModel.name];
        [_addressButtonSecond setTitle:secondTitle forState:UIControlStateNormal];
    }
    return _addressPickerSecond;
}

@end
