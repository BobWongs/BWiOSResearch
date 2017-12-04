//
//  BMMapNavigationTool.h
//  BWObjective-CResearch-iOS
//
//  Created by BobWong on 2017/12/4.
//  Copyright © 2017年 BobWong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface BMMapNavigationTool : NSObject

+ (void)navigateWithCoordinate:(CLLocationCoordinate2D)coordinate;

@end
