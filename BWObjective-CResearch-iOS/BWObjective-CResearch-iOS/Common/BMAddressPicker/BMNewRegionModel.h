//
//  BMNewRegionModel.h
//  BMiOSUIComponents
//
//  Created by BobWong on 2017/6/1.
//  Copyright © 2017年 月亮小屋（中国）有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BMNewRegionModel : NSObject

@property (assign, nonatomic) NSInteger code;  ///< 区域编码
@property (strong, nonatomic) NSString *name;  ///< 区域名称
@property (assign, nonatomic) NSInteger parentCode;  ///< 上级区域编码
@property (strong, nonatomic) NSString *type;  ///< 区域类型

@end
