//
//  BMCustomAnnotationView.h
//  BWObjective-CResearch-iOS
//
//  Created by BobWong on 2017/11/30.
//  Copyright © 2017年 BobWong. All rights reserved.
//

#import <MAMapKit/MAMapKit.h>
#import "BMCustomCalloutView.h"

@interface BMCustomAnnotationView : MAAnnotationView

@property (nonatomic, readonly) BMCustomCalloutView *calloutView;

@end
