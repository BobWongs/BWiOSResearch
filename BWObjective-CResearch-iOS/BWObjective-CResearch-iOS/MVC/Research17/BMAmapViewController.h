//
//  BMAmapViewController.h
//  BWObjective-CResearch-iOS
//
//  Created by BobWong on 2017/12/4.
//  Copyright © 2017年 BobWong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MAMapKit/MAPointAnnotation.h>

@interface BMAmapViewController : UIViewController

@property (nonatomic, strong) NSArray<MAPointAnnotation *> *annotationArray;  ///< 标注点坐标

@end
