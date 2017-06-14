//
//  BWNewAddressSourceManager.h
//  BMiOSUIComponents
//
//  Created by BobWong on 2017/6/1.
//  Copyright © 2017年 月亮小屋（中国）有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BMNewRegionModel;

extern NSString *const BWAddressTypeProvince;
extern NSString *const BWAddressTypeCity;
extern NSString *const BWAddressTypeCounty;

@interface BWNewAddressSourceManager : NSObject

/**
 *  获取地址数据源
 *
 *  @param parentCode 父地址编码
 *  @param addressType 要获取的地址类型
 *  @return 地址数据源
 */
- (NSArray<BMNewRegionModel *> *)addressSourceArrayWithParentCode:(NSInteger)parentCode addressType:(NSString *)addressType;

@end
