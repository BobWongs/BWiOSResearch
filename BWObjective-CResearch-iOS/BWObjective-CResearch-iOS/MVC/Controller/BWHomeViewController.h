//
//  BWHomeViewController.h
//  BWObjective-CResearch-iOS
//
//  Created by BobWong on 16/10/12.
//  Copyright © 2016年 BobWong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BWHomeViewController : UIViewController

@end

/*
 熟悉Xib的使用
    TableViewCell使用Xib，注意重用问题，cell identifier需要和Xib所设的identifier名称一致，记得给Xib设置identifier，使用自定义基类或者Category的方式进行Cell重用生成方法的统一；
    使用Xib不用代码重置Cell的Width为屏幕宽度；
*/